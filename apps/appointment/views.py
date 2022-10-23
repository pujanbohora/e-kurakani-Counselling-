import requests
from rest_framework import viewsets, status, generics
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView
from django.db.models import Q
from apps.category.models import Category
from apps.core.models import UserRole
from apps.category.serializer import CategoryTreeSerializer
from zoom_api_functions import *
from .utils import *
from .models import *
from .serializers import *

from datetime import datetime as dt

from decouple import config 

class AppointmentRequestViewSet(viewsets.ModelViewSet):
    queryset = AppointmentRequest.objects.all()
    serializer_class = AppointmentRequestSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = super(AppointmentRequestViewSet, self).get_queryset()
        if 'counsellor' in self.kwargs:
            qs = qs.filter(counsellor_id=self.kwargs['counsellor'])
        return qs


#dashboard
class DashboardAPIViews(APIView):
    
    # queryset = UserRole.objects.all()
    permission_classes= [AllowAny]

    
    def get(self, request, *args, **kwargs):
        user_id = request.user.id
        user_role = request.user.get_user_role.title
        current_date = dt.now().date()
        if user_role=="Business":
            associated_business = user_id
            total_counsellor = CounsellorProfile.objects.filter(associated_business__user__id=associated_business).count()
            appointment =  Appointment.objects.filter(counsellor__associated_business__user__id=associated_business)
            total_appointment = appointment.count()
            feedback_count = Feedback.objects.filter(feedback_for='counsellor', counsellor__associated_business__user__id=associated_business).count()
            
            counsellor_list = CounsellorProfile.objects.filter(associated_business__user__id=associated_business)
            serializers = ListCounsellorProfileSerializer(counsellor_list, many=True, context={"request": request})
            balance = 0
            for i in appointment:
                if i.appointment_charge == None:
                    i.appointment_charge = 0

                balance += i.appointment_charge
            context = {
                "total_counsellor": total_counsellor,
                "total_appointment": total_appointment,
                "collected_balance": balance,
                "feedback_count": feedback_count,
                "counsellors": serializers.data
            }
            return Response(context, status=status.HTTP_200_OK)

        elif user_role=="Admin":
            total_business = UserRole.objects.filter(user_role__title="Business").count()
            total_customer = UserRole.objects.filter(user_role__title="Customer").count()
            total_admin = UserRole.objects.filter(user_role__title="Admin").count()
            total_counsellor = CounsellorProfile.objects.all().count()
            total_appointment = Appointment.objects.all().count()
            appointment =  Appointment.objects.all().count()
            counsellor_list = CounsellorProfile.objects.all()
            serializers = self.serializer_class(counsellor_list)
            print("serializer data = ", serializers.data)
            balance = 0
            for i in appointment:
                if i.appointment_charge == None:
                    i.appointment_charge = 0

                balance += i.appointment_charge
            context = {
            "total_counsellor":total_counsellor,
            "total_business":total_business,
            "total_customer":total_customer,
            "total_admin": total_admin,
            "total_counsellor":total_counsellor,
            "total_appointment": total_appointment,
            "collected_balance": balance,
            "counsellor": serializers.data

            }
            return Response(context, status=status.HTTP_200_OK)

        elif user_role=="Counsellor":
            counsellor_id = user_id
            appointment =  Appointment.objects.filter(counsellor__user__id=counsellor_id)
            upcoming_appointment = appointment.filter(Q(date__gt=current_date))[:3]
            upcoming_appointment_count = appointment.filter(Q(date__gt=current_date)).count()
            past_appointment = appointment.filter(date__lte=current_date)
            past_appointment_count = past_appointment.count()

            feedback_count = Feedback.objects.filter(feedback_for='counsellor', counsellor__user__id=counsellor_id).count()

            appointment_serialized = AppointmentDetailsSerializer(upcoming_appointment, many=True, context={"request": request})
            
            total_appointment = appointment.count()
            counsellor_list = CounsellorProfile.objects.filter(id=counsellor_id)
            balance = 0
            for i in appointment:
                if i.appointment_charge == None:
                    i.appointment_charge = 0

                balance += i.appointment_charge
            context = {
                "collected_balance": balance,
                "upcoming_appointment_count": upcoming_appointment_count,
                "feedback_count": feedback_count,
                "past_appointment_count": past_appointment_count,
                "appointments": appointment_serialized.data
            }
            return Response(context, status=status.HTTP_200_OK)
        elif user_role == "Customer":
            categories = Category.objects.filter(level__lt=1)[:6]
            counsellors = CounsellorProfile.objects.all()[:3]
            category_serialized = CategoryTreeSerializer(categories, many=True, context={'request': request})
            counsellor_serialized = ListCounsellorProfileSerializer(counsellors, many=True, context={'request': request})

            response_data = {
                "categories": category_serialized.data,
                "counsellors": counsellor_serialized.data,
            }
            return Response(response_data, status=status.HTTP_200_OK)
        else:
            return Response({}, status=status.HTTP_400_BAD_REQUEST)
        # for business account
        # if user_role == "Business":
        #     return "" 


        # context = {
        #     "total_counsellor":total_counsellor,
        #     "total_business":total_business,
        #     "total_customer":total_customer,
        #     "total_admin": total_admin,
        #     "total_appointment": total_appointment,
        #     "collected_balance": balance

        # }
        # return Response(context, status=status.HTTP_200_OK)
       



class CreateAppointmentViewSet(viewsets.ModelViewSet):
    serializer_class = CreateAppointmentSerializer
    queryset = Appointment.objects.all()
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = super().get_queryset()
        if not self.request.user.is_anonymous:
            if self.request.user.get_user_role.title == 'Customer':
                qs = qs.filter(user=self.request.user)
            elif self.request.user.get_user_role.title == "Counsellor":
                qs = qs.filter(counsellor=self.request.user.counsellorprofile)
            elif self.request.user.get_user_role.title == "Business":
                counsellor_profiles = list(CounsellorProfile.objects.filter(associated_business__user=self.request.user).values_list('pk', flat=True))
                qs = qs.filter(counsellor__in=counsellor_profiles)
        if self.request.method == 'GET':
            qs = qs.filter(date__gt=dt.now().date())
        return qs

    def get_serializer_class(self):
        if self.action == 'retrieve':
            return AppointmentDetailsSerializer
        if self.action == 'list':
            return AppointmentDetailsSerializer
        return super().get_serializer_class()
    
    def create(self, request, *args, **kwargs):
        data = request.data 
        requested_time = dt.strptime(data["time"],'%H:%M').time()
        requested_date = dt.strptime(data["date"] + " 00:00:00",'%Y-%m-%d %H:%M:%S').date()

        zoom_api_data = {}
        zoom_api_data["server_start_time"] = dt.combine(requested_date, requested_time)
        zoom_api_data["start_time"] = dt.combine(requested_date, requested_time)
        if data.get("counsellor"):
            zoom_api_data["duration"] = CounsellorProfile.objects.get(id=data["counsellor"]).time_interval
        else:
            return Response({"message": "counsellor not selected"}, status=status.HTTP_400_BAD_REQUEST)
        
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        response_data = serializer.data
        
        new_meeting = create_meeting(zoom_api_data, response_data["id"])
        
        response_data['appointment_meeting'] = new_meeting
        headers = self.get_success_headers(response_data)
        return Response(response_data, status=status.HTTP_201_CREATED, headers=headers)

    def list(self, request, *args, **kwargs):
        qs = self.get_queryset()
        live_meeting_qs = AppointmentMeeting.objects.all()
        serializer = AppointmentDetailsSerializer(qs, many=True)
        response_data = serializer.data
        for appointment in response_data:
            appointment_id = appointment["id"]
            
            meeting_data = list_meeting(live_meeting_qs, appointment_id)
            appointment["appointment_meeting"] = meeting_data
        return Response(response_data)
    
    def retrieve(self, request, *args, **kwargs):
        appointment_obj = self.get_object()
        serializer = AppointmentDetailsSerializer(appointment_obj)
        response_data = serializer.data
        response_data["appointment_meeting"] = retrieve_meeting(appointment_obj.appointmentmeeting_set.all())
        return Response(response_data)

    def destroy(self, request, **kwargs):
        appointment_obj = self.get_object()
        am_object = appointment_obj.appointmentmeeting_set.first()
        status_code = delete_meeting(am_object)

        if (status_code == 204):
            self.perform_destroy(appointment_obj)
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class PastAppointmentAPIView(generics.ListAPIView):
    serializer_class = AppointmentDetailsSerializer
    queryset = Appointment.objects.all()
    permission_classes = [AllowAny]

    def get_queryset(self):
        time = dt.now().strftime("%H:%M")
        date = dt.now().date()
        qs = super().get_queryset()
        if not self.request.user.is_anonymous:
            if self.request.user.get_user_role.title == "Customer":
                qs = qs.filter(
                    Q(user=self.request.user) &
                    Q(date__lte=date) &
                    Q(time__lte=time)
                    )
            elif self.request.user.get_user_role.title == "Counsellor":
                qs = qs.filter(
                                Q(counsellor=self.request.user.counsellorprofile) &             
                                Q(date__lte=date) 
                                )
            elif self.request.user.get_user_role.title == "Business":
                counsellor_profiles = list(CounsellorProfile.objects.filter(associated_business__user=self.request.user).values_list('pk', flat=True))
                qs = qs.filter(
                                Q(counsellor__in=counsellor_profiles) &             
                                Q(date__lte=date) &
                                Q(time__lte=time)
                                )
        return qs



class CounsellorBusinessAppointmentsView(generics.ListAPIView):
    serializer_class = AppointmentDetailsSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        current_user = self.request.user
        current_date = dt.now().date()
        qs = Appointment.objects.filter(counsellor__user=current_user, date__gt=current_date)
        return qs


class AppointmentMeetingViewSet(viewsets.ModelViewSet):
    queryset = AppointmentMeeting.objects.all()
    serializer_class = LiveMeetingSerializer

    def create(self, request, *args, **kwargs):
        zoom_api_data = request.data
        appointment_id = self.kwargs.get('appointment_id')
        response_data = create_meeting(zoom_api_data, appointment_id)
        headers = self.get_success_headers(response_data)
        return Response(response_data, status=status.HTTP_201_CREATED, headers=headers)

    def update(self, request, *args, **kwargs):
        am_object = self.get_object()
        appointment_id = self.kwargs.get('appointment_id')
        
        # Preparing data for Zoom Meeting update and Live Class update
        zoom_api_data = request.data
        processed_data = {
            'start_time': zoom_api_data['server_start_time'],
        }
        if appointment_id is not None:
            appointment_obj = Appointment.objects.get(id=appointment_id)
            processed_data["appointment"] = appointment_obj

        serializer = self.get_serializer(
            am_object, data=processed_data, partial=True)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)
        response_data = serializer.data

        # Updating the Zoom Meeting
        headers = {'authorization': 'Bearer %s' % generateToken(),
                   'content-type': 'application/json'}
        r = requests.patch(
            f'https://api.zoom.us/v2/meetings/{am_object.zoom_meeting_id}',
            data=json.dumps(zoom_api_data), headers=headers)

        if r.status_code == 204:
            updated_meeting = requests.get(
                f'https://api.zoom.us/v2/meetings/{am_object.zoom_meeting_id}',
                headers=headers)

            response_data['zoom_meeting'] = updated_meeting.json()

        return Response(response_data)

    def list(self, request, *args, **kwargs):
        appointment_id = self.kwargs.get('appointment_id')
        response_data = list_meeting(self.get_queryset(), appointment_id)
        return Response(response_data)

    def retrieve(self, request, **kwargs):
        am_obj = self.get_object()
        serializer = self.get_serializer(am_obj)
        response_data = serializer.data

        # Getting the Zoom Meeting
        headers = {'authorization': 'Bearer %s' % generateToken(),
                   'content-type': 'application/json'}
        r = requests.get(
            f'https://api.zoom.us/v2/meetings/{am_obj.zoom_meeting_id}',
            headers=headers)
        response_data['zoom_meeting'] = r.json()
        return Response(response_data)

    def destroy(self, request, **kwargs):
        am_object = self.get_object()
        response_status_code = delete_meeting(am_object)
        if (response_status_code == 204):
            self.perform_destroy(am_object)
            return Response(status=status.HTTP_204_NO_CONTENT)
        else:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetZoomSDKSignature(generics.GenericAPIView):
    permission_classes = [AllowAny]

    def post(self, request, course_slug, format=None):
        data = request.data
        response = {
            'signature': getSignatureCode(data)
        }
        return Response(response)


class GetZoomMeetingInvitation(generics.GenericAPIView):
    permission_classes = [AllowAny]

    def get(self, request, appointment_id, meeting_id, format=None):
        headers = {'authorization': 'Bearer %s' % generateToken(),
                   'content-type': 'application/json'}
        r = requests.get(
            f'https://api.zoom.us/v2/meetings/{meeting_id}/invitation',
            headers=headers)
        # return r.text
        return Response(r.json())


#khalti api integeration
class VerifyKhaltiPaymentView(APIView):
    permission_classes=[AllowAny]

    def post(self, request, *args, **kwargs):
        # confirmation_code = request.GET.get("confirmation_code")
        data = request.data
        print(data)
        # preparing meeting data 
        requested_time = dt.strptime(data["time"],'%H:%M:%S').time()
        requested_date = dt.strptime(data["date"] + " 00:00:00",'%Y-%m-%d %H:%M:%S').date()

        zoom_api_data = {}
        zoom_api_data["server_start_time"] = dt.combine(requested_date, requested_time)
        zoom_api_data["start_time"] = dt.combine(requested_date, requested_time)
        if data.get("counsellor"):
            zoom_api_data["duration"] = CounsellorProfile.objects.get(id=data["counsellor"]).time_interval
        else:
            return Response({"message": "counsellor not selected"}, status=status.HTTP_400_BAD_REQUEST)
        
        # preparing khalti payment data
        token = request.GET.get("token")
        amount = float(request.GET.get('amount'))
        url = config('KHALTI_VERIFY_URL')
        payload = {
            "token": token,
            "amount": amount
            }
        secret_key = config('KHALTI_SECRET_KEY')
        headers = {
        "Authorization": f'Key {secret_key}'
        }

        response = requests.post(url, payload, headers = headers)
        resp_dict = response.json()

        if resp_dict.get("idx"):
            success = True
            data["payment_intent"] = resp_dict.get("idx")
            data["appointment_charge"] = amount
            data["payment"] = True

            serializer = CreateAppointmentSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                response_data = serializer.data
                new_meeting = create_meeting(zoom_api_data, response_data["id"])
        
                response_data['appointment_meeting'] = new_meeting
                resp_dict["appointment"] = response_data
        else:
            success = False
        data = {
            "success": success,
            "response": resp_dict
        }
        return Response(data, status=status.HTTP_200_OK)


class ReportViewSet(viewsets.ModelViewSet):
    queryset = Report.objects.all()
    serializer_class = ReportSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = super(ReportViewSet, self).get_queryset()
        filter_by = self.request.GET.get('filter_by')
        if filter_by == 'counsellor':
            qs = qs.filter(report_for='counsellor')
        elif filter_by == 'appointment':
            qs = qs.filter(report_for='appointment')
        return qs

    def get_serializer_class(self):
        if self.action in ['retrieve', 'list']:
            return ReportInfoSerializer
        return super().get_serializer_class()


class FeedbackViewSet(viewsets.ModelViewSet):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = super(FeedbackViewSet, self).get_queryset()
        filter_by = self.request.GET.get('filter_by')
        if filter_by == 'counsellor':
            qs = qs.filter(feedback_for='counsellor')
        elif filter_by == 'appointment':
            qs = qs.filter(feedback_for='appointment')
        return qs

    def get_serializer_class(self):
        if self.action in ['retrieve', 'list']:
            return FeedbackInfoSerializer
        return super().get_serializer_class()

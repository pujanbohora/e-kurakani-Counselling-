import ast
from datetime import datetime, date
from rest_framework import viewsets, status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework import generics
from django.db.models import Q

from .models import *
from .serializers import *

class BusinessProfileViewSet(viewsets.ModelViewSet):
    queryset = BusinessProfile.objects.all()
    serializer_class = BusinessProfileSerializer
    permission_classes = [AllowAny]

    def update(self, request, *args, **kwargs):
        profile = self.get_object()
        initial_data = request.data
        attachments_list = None
        attached_files = None
        if type(initial_data) != dict:
            initial_data._mutable = True
            attachments_list = initial_data.pop('attachments', None)
            attached_files = initial_data.pop('files', None)
            initial_data = dict(initial_data.lists())
            processed_data = {}
            for key, value in initial_data.items():
                if value[0] != "":
                    processed_data[key] = value[0]
        else:
            processed_data = initial_data
        serializer = self.serializer_class(
            instance=profile, data=processed_data, partial=True)
        if serializer.is_valid(raise_exception=True):
            serializer.save()

        processed_attachments = []
        if attachments_list is not None and attached_files is not None:
            # attachments_list = ast.literal_eval(attachments_list[0])
            for i in range(len(attachments_list)):
                item = ast.literal_eval(attachments_list[i])
                processed_attachments.append({'business_profile': profile.id, 'label': item['label'], 'file': attached_files[i],
                                             'remarks': item['remarks']})
            for pa in processed_attachments:
                attachments_serialized = ProfileAttachmentSerializer(
                    data=pa)
                if attachments_serialized.is_valid(raise_exception=True):
                    attachments_serialized.save()
        return Response(serializer.data, status=status.HTTP_200_OK)


class CounsellorProfileViewSet(viewsets.ModelViewSet):
    queryset = CounsellorProfile.objects.all()
    serializer_class = CounsellorProfileSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = super(CounsellorProfileViewSet, self).get_queryset()
        if 'business_profile' in self.kwargs:
            qs = qs.filter(associated_business_id=self.kwargs['business_profile'])
        return qs
    
    def update(self, request, *args, **kwargs):
        profile = self.get_object()
        initial_data = request.data
        attachments_list = None
        attached_files = None
        if type(initial_data) != dict:
            initial_data._mutable = True
            attachments_list = initial_data.pop('attachments', None)
            attached_files = initial_data.pop('files', None)
            initial_data = dict(initial_data.lists())
            processed_data = {}
            for key, value in initial_data.items():
                if value[0] != "":
                    processed_data[key] = value[0]
        else:
            processed_data = initial_data
        # print(processed_data)
        serializer = self.serializer_class(
            instance=profile, data=processed_data, partial=True)
        if serializer.is_valid(raise_exception=True):
            serializer.save()

        processed_attachments = []
        if attachments_list is not None and attached_files is not None:
            # attachments_list = ast.literal_eval(attachments_list[0])
            for i in range(len(attachments_list)):
                item = ast.literal_eval(attachments_list[i])
                processed_attachments.append({'counsellor_profile': profile.id, 'label': item['label'], 'file': attached_files[i],
                                             'remarks': item['remarks']})
            # print(f'Processed Attachments 🟡 {processed_attachments}')
            for pa in processed_attachments:
                attachments_serialized = ProfileAttachmentSerializer(
                    data=pa)
                if attachments_serialized.is_valid(raise_exception=True):
                    attachments_serialized.save()
        return Response(serializer.data, status=status.HTTP_200_OK)


class ProfileAttachmentViewSet(viewsets.ModelViewSet):
    queryset = ProfileAttachments.objects.all()
    serializer_class = ProfileAttachmentSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = super(ProfileAttachmentViewSet, self).get_queryset()
        if 'business_profile' in self.kwargs:
            qs = qs.filter(business_profile_id=self.kwargs['business_profile'])
        elif 'counsellor_profile' in self.kwargs:
            qs = qs.filter(counsellor_profile_id=self.kwargs['counsellor_profile'])
        return qs 
    
    def create(self, request, *args, **kwargs):
        data = request.data
        if 'business_profile' in kwargs:
            business_profile = kwargs.get('business_profile', None)
            response_data = {'detail': 'Unable to create!'}
            if business_profile is not None:
                data['business_profile'] = business_profile
        elif 'counsellor_profile' in kwargs:
            counsellor_profile = kwargs.get('counsellor_profile', None)
            response_data = {'detail': 'Unable to create!'}
            if counsellor_profile is not None:
                data['counsellor_profile'] = counsellor_profile
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        serializer.save()
        response_data = serializer.data
        return Response(response_data, status=status.HTTP_201_CREATED)


class GetUserCounsellorProfileView(generics.RetrieveAPIView):
    serializer_class = ListCounsellorProfileSerializer
    permission_classes = [AllowAny]
    queryset = CounsellorProfile.objects.all()

    def get(self, request, *args, **kwargs):
        qs = self.get_queryset()
        profile_obj = qs.filter(user__id=self.kwargs['id'])
        if profile_obj.exists():
            serialized = self.get_serializer(profile_obj[0])
            return Response(serialized.data, status=status.HTTP_200_OK)
        else:
            return Response({"message": "No profile found"}, status=status.HTTP_400_BAD_REQUEST)


class CounsellorTimeTableViewSet(viewsets.ModelViewSet):
    queryset = CounsellorTimeTable.objects.all()
    serializer_class = CounsellorTimeSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = super(CounsellorTimeTableViewSet, self).get_queryset()
        qs = qs.filter(counsellor=self.request.user.counsellorprofile)
        return qs 
    
    def create(self, request, *args, **kwargs):
        data = request.data
        if 'counsellor_profile' in kwargs:
            counsellor = kwargs.get('counsellor_profile', None)
            response_data = {'detail': 'Unable to create!'}
            if counsellor is not None:
                data['counsellor'] = counsellor
        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        serializer.save()
        response_data = serializer.data
        return Response(response_data, status=status.HTTP_201_CREATED)


def get_int_month(month_value):
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    return months.index(month_value)


class MonthlyTimeTableCreateView(generics.CreateAPIView):
    queryset = CounsellorTimeTable.objects.all()
    serializer_class = CounsellorTimeSerializer
    permission_classes = [AllowAny]

    def post(self, request, *args, **kwargs):
        initial_data = request.data
        month_value = initial_data.pop("month")
        month_index = get_int_month(month_value)
        limit = 30
        if month_index == 1:
            limit = 28
        elif month_index in [0, 2, 4, 6, 7, 9, 11]:
            limit = 31
        today_date = date.today()
        current_year = today_date.year
        if today_date.month == 12 and month_index != 11:
            current_year += 1
        for i in range(1, limit + 1):
            time_table_date = datetime(current_year, month_index + 1, i).date()
           
            schedule_on_weekend = False
            if initial_data.get('counsellor'):
                counsellor_profile = CounsellorProfile.objects.get(id=initial_data['counsellor'])
                if counsellor_profile.available_for_weekend:
                    schedule_on_weekend = True
            
            if not schedule_on_weekend and time_table_date.weekday() == 6:
                continue

            if time_table_date.weekday() == 5:
                continue

            st_to_compare = datetime.strptime(initial_data["start_time"], '%H:%M').time()
            et_to_compare = datetime.strptime(initial_data["end_time"], '%H:%M').time()
            
            time_table_exists = CounsellorTimeTable.objects.filter(
                                    Q(counsellor__id=initial_data['counsellor']) &
                                    Q(date=time_table_date) & 
                                    Q(Q(start_time__lte=st_to_compare, end_time__gte=st_to_compare) | 
                                    Q(start_time__lte=et_to_compare, end_time__gte=et_to_compare))
                                ).exists()
            if time_table_exists:
                return Response({"message": "Time table already set for the selected month"}, status=status.HTTP_400_BAD_REQUEST)
            else:
                initial_data['date'] = time_table_date
                serializer = self.get_serializer(data=initial_data)
                serializer.is_valid(raise_exception=True)
                
                self.perform_create(serializer)
                serializer.save()
        
        return Response({"message": "Time table successfully created"}, status=status.HTTP_200_OK)


class ListAppliedCounsellorProfiles(generics.ListAPIView):
    serializer_class = ListCounsellorProfileSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = CounsellorProfile.objects.filter(apply_for_verification=True)
        return qs


class ListAppliedBusinessProfiles(generics.ListAPIView):
    serializer_class = ListBusinessProfileSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        qs = BusinessProfile.objects.filter(apply_for_verification=True)
        return qs


class GetUserBusinessProfileView(generics.RetrieveAPIView):
    serializer_class = ListBusinessProfileSerializer
    permission_classes = [AllowAny]
    queryset = BusinessProfile.objects.all()

    def get(self, request, *args, **kwargs):
        qs = self.get_queryset()
        profile_obj = qs.filter(user__id=self.kwargs['id'])
        if profile_obj.exists():
            serialized = self.get_serializer(profile_obj[0])
            return Response(serialized.data, status=status.HTTP_200_OK)
        else:
            return Response({"message": "No profile found"}, status=status.HTTP_400_BAD_REQUEST)


class MyScheduleAPIView(generics.ListAPIView):
    permission_classes = [AllowAny]
    queryset = CounsellorTimeTable.objects.all()

    def list(self, request, *args, **kwargs):
        week_days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        today = datetime.today()
        current_week_start = today - timedelta(days=today.weekday())
        
        week_list = []

        qs = self.get_queryset().filter(counsellor__user=self.request.user, date__gte=current_week_start.date())
        if qs.exists():

            last_qs_obj = qs.last() 

            ewd_dt = datetime.combine(last_qs_obj.date, datetime.min.time())
            end_week_date = ewd_dt - timedelta(days=ewd_dt.weekday()) + timedelta(days=6)

            while end_week_date > current_week_start:
                week_end = current_week_start + timedelta(days=6)
                week_dict = {"week": current_week_start.strftime("%m/%d/%Y") + "-" + week_end.strftime("%m/%d/%Y")}
                current_week_start = week_end + timedelta(days=1)
                week_list.append(week_dict)

            for week in week_list:
                days_list = []
                week_dates = week["week"].split("-")

                start_date = datetime.strptime(week_dates[0], '%m/%d/%Y')
                for i in range(7):
                    days_dict = {"date": start_date.date(), "day": week_days[start_date.weekday()]}
                    time_list = []
                    for schedule in qs.filter(date=start_date.date()):
                        time_dict = {"start_time": schedule.start_time, "end_time": schedule.end_time, "id": schedule.id}
                        time_list.append(time_dict)
                    days_dict["time"] = time_list
                    days_list.append(days_dict)
                    start_date += timedelta(1)
                week["days"] = days_list
        return Response(week_list, status=status.HTTP_200_OK)

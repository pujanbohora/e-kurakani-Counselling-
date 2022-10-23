# from django.shortcuts import render
from datetime import timedelta, datetime
import email
# from msilib.schema import Error
import re
# import email
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework.views import APIView

from rest_framework import viewsets
# from rest_framework import filters
from rest_framework.permissions import AllowAny
from rest_framework import generics
from rest_framework_simplejwt.exceptions import TokenError, InvalidToken
# from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status
from rest_framework.response import Response
# from djoser.views import UserViewSet
from djoser.conf import settings as dj_settings
from djoser import signals as dj_signals
import ast

from apps.core.helpers import generate_code
from apps.profiles.models import BusinessProfile, CounsellorProfile

from .serializers import *
from .models import User, Role, UserRole, UserDetail
from .permissions import IsSuperUser, IsLoggedInUser
from .helpers import send_ev_email, send_reset_psw



class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = (AllowAny,)

    def get_serializer_class(self):
        if self.action == 'list':
            return ListUserSerializer
        return super().get_serializer_class()

    def get_queryset(self):
        qs = super().get_queryset()
        if self.action == 'list':
            if self.request.user.get_user_role.title == 'Business':
                counsellor_profiles = list(CounsellorProfile.objects.filter(associated_business__user=self.request.user).values_list('user__id', flat=True))
                qs = qs.filter(id__in=counsellor_profiles)
        return qs

    def create(self, request, *args, **kwargs):
        data = request.data
        role_title = data.pop('user_role', None)
        associated_business = data.pop('associated_business', None)
        serializer = RegisterSerializer(data=data)
        try:
            serializer.is_valid(raise_exception=True)
            # serializer.perform_create()
            user = serializer.save()
            dj_signals.user_registered.send(
                sender=self.__class__, user=user, request=self.request
            )

            # context = {"user": user}
            # to = [user.email]
            # if dj_settings.SEND_ACTIVATION_EMAIL:
            #     dj_settings.EMAIL.activation(self.request, context).send(to)
            # Creating the User Role object
            if role_title is not None:
                role_obj = Role.objects.get(title=role_title)
                user_role = UserRole.objects.create(
                    user=user, user_role=role_obj)
                user_role.save()
                if role_obj.title == "Admin":
                    user.is_admin = True
                    user.save()
            
            if role_title == "Business":
                business_user = BusinessProfile.objects.create(user=user)
                business_user.save()
            
            elif role_title == "Counsellor":
                if associated_business:
                    associated_business = BusinessProfile.objects.get(user__email=associated_business)
                    counsellor_user = CounsellorProfile.objects.create(associated_business=associated_business,user=user)    
                else:
                    counsellor_user = CounsellorProfile.objects.create(user=user, is_freelancer=True)
                counsellor_user.save()

            userdetail = UserDetail.objects.create(user=user)
            userdetail.save()
            send_ev_email(user)
        except TokenError as e:
            raise InvalidToken(e.args[0])
        response_data = serializer.validated_data
        return Response(response_data, status=status.HTTP_200_OK)


class UserRegisterAPI(generics.CreateAPIView):
    permission_classes = (AllowAny,)
    # authentication_classes = ()
    serializer_class = RegisterSerializer

    def perform_create(self, serializer):
        data = self.request.data.copy()
        user = serializer.save()
        dj_signals.user_registered.send(
            sender=self.__class__, user=user, request=self.request
        )
        context = {"user": user}
        # Creating the User Role object
        role_title = data.pop("user_role")
        associated_business = data.pop('associated_business', None)
        if type(role_title) != str:
            role_title = role_title[0]
        selected_role = Role.objects.get(title=role_title)
        user_role = UserRole.objects.create(user=user, user_role=selected_role)
        user_role.save()
        # Creating User Detail
        if role_title == "Business":
                business_user = BusinessProfile.objects.create(user=user)
                business_user.save()
            
        elif role_title == "Counsellor":
            if associated_business:
                associated_business = BusinessProfile.objects.get(user__email=associated_business)
                print("associated :", associated_business)
                counsellor_user = CounsellorProfile.objects.create(associated_business=associated_business,user=user)    
            else:
                counsellor_user = CounsellorProfile.objects.create(user=user, is_freelancer=True)
            counsellor_user.save()

        userdetail = UserDetail.objects.create(user=user)
        userdetail.save()
        send_ev_email(user)
        # to = [user.email]
        # if dj_settings.SEND_ACTIVATION_EMAIL:
        #     dj_settings.EMAIL.activation(self.request, context).send(to)
        # elif dj_settings.SEND_CONFIRMATION_EMAIL:
        #     dj_settings.EMAIL.confirmation(self.request, context).send(to)

class ForgetPasswordView(APIView):
    permission_classes = (AllowAny,)
    def post(self, request, *args, **kwargs):
        data = request.data
        print("data", data["email"])
        try:
            user = User.objects.get(email=data["email"])
            if user:
                
                send_reset_psw(user)
                return Response({"success":True, "message":"Please check your email for reset code"}, status=status.HTTP_200_OK)
        except:
            return Response({"success":False, "message":"Provided email doesnot exist, ", }, status=status.HTTP_400_BAD_REQUEST)
        
class ResetCodeView(APIView):
    permission_classes = (AllowAny,)
    def post(self, request, *args, **kwargs):
        data = request.data
        user = User.objects.get(email=data["email"])
        userdetail = user.userdetail
        reset_code = userdetail.reset_code
        if reset_code == str(data.get("otp")):
            return Response({"success":True, "message":"Code matched, Enter new password", "otp": data.get("otp")}, status=status.HTTP_200_OK)
        return Response({"success":False, "message":"Code not matched, Enter a correct code or you can apply for new code"}, status=status.HTTP_400_BAD_REQUEST)

class ResetPassword(APIView):
    permission_classes = (AllowAny,)
    def patch(self, request, *args, **kwargs):
        data = request.data
        print(data)
        user = User.objects.get(email=data["email"])
        if user:
            userdetail = user.userdetail
            reset_code = userdetail.reset_code
            if reset_code == str(data.get("otp")):
                user.set_password(data["password"])
                user.save()
                return Response({"success":True, "message":"Password changed successfully"}, status=status.HTTP_200_OK)
            return Response({"success":False, "message":"Code not matched, Enter a correct code or you can apply for new code"}, status=status.HTTP_400_BAD_REQUEST)
        return Response({"success":False, "message":"Email not matched"}, status=status.HTTP_400_BAD_REQUEST)

            
        


class VerifyOTPView(APIView):
    permission_classes = (AllowAny, )

    def post(self, request, *args, **kwargs):
        data = request.data 
        user = User.objects.get(email=data["email"])
        userdetail = user.userdetail
        otp = userdetail.erv_code
        if datetime.date(datetime.now()) < (user.created_at + timedelta(days=1)):
            if otp == str(data.get("otp")):
                user.is_active = True
                user.save()
                userdetail.erv_code = None
                userdetail.save()
                return Response({"success": True, "message": "Account Verified!"}, status=status.HTTP_200_OK)
            return Response({"success": False, "message": "OTP did not match!"}, status=status.HTTP_400_BAD_REQUEST)
        return Response({"success": False, "message": "OTP Expired!"}, status=status.HTTP_400_BAD_REQUEST)
            

class LoginViewSet(viewsets.ModelViewSet, TokenObtainPairView):
    serializer_class = LoginSerializer
    permission_classes = (AllowAny,)
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        # Checking and filtering email not verified users
        email = request.data['email']
        if (email):
            user_exists = User.objects.filter(email=email)
            if user_exists:
                user = User.objects.get(email=email)
                if not user.is_active or user.is_suspended:
                    ev_data = LoggedInUserSerializer(user).data
                    
                    return Response({'user': ev_data}, status=status.HTTP_200_OK)

            serializer = self.get_serializer(data=request.data)
            # print(serializer.initial_data)
            try:
                serializer.is_valid(raise_exception=True)
                
            except TokenError as e:
                raise InvalidToken(e.args[0])
                
            response_data = serializer.validated_data
            return Response(response_data, status=status.HTTP_200_OK)


class ValidateLoggedInUserAPI(APIView):
    queryset = User.objects.all()
    serializer_class = LoggedInUserSerializer
    permission_classes = (IsLoggedInUser,)

    def get(self, request, *args, **kwargs):
        current_user = request.user
        serializer = self.serializer_class(current_user)
        return Response(serializer.data, status=status.HTTP_200_OK)


class RefreshViewSet(viewsets.ViewSet, TokenRefreshView):
    permission_classes = (AllowAny,)
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])

        return Response(serializer.validated_data, status=status.HTTP_200_OK)


class MyAccountAPI(generics.RetrieveAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = MyAccountSerializer
    permission_classes = [AllowAny]


class UserDetailViewSet(viewsets.ModelViewSet):
    http_method_names = ['patch', ]
    queryset = UserDetail.objects.all()
    serializer_class = UserDetailSerializer
    permission_classes = (AllowAny,)


class ChangePasswordView(generics.UpdateAPIView):
    queryset = User.objects.all()
    permission_classes = [AllowAny]
    serializer_class = UserPasswordSerializer

    def partial_update(self, request):
        processed_data = request.data
        self.object = request.user
        serializer = self.get_serializer(data=processed_data)
        if serializer.is_valid():
            if not self.object.check_password(serializer.data.get('old_password')):
                return Response({"old password": "Wrong Password"}, status=status.HTTP_400_BAD_REQUEST)
            self.object.set_password(serializer.data.get("new_password"))
            self.object.save()
            response = {
                'status': 'success',
                'message': 'Password updated successfully',
            }
            return Response(response, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

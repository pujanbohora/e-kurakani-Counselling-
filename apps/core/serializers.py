from dataclasses import fields
from statistics import mode
from rest_framework import serializers
from django.core.exceptions import ObjectDoesNotExist
from django.contrib.auth import get_user_model
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.settings import api_settings
from django.contrib.auth.models import update_last_login
from .models import UserDetail

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class UserAppointment(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('email',)


class RegisterSerializer(UserSerializer):
    password = serializers.CharField(
        max_length=128, min_length=8, write_only=True, required=True)
    # email = serializers.EmailField(
    #     required=True, write_only=True, max_length=128)

    class Meta:
        model = User
        fields = ['email', 'password', ]

    def create(self, validated_data):
        try:
            user = User.objects.get(email=validated_data['email'])
        except ObjectDoesNotExist:
            user = User.objects.create_user(**validated_data)
        return user

class LoggedInUserSerializer(serializers.ModelSerializer):
    user_role = serializers.ReadOnlyField(source='get_role_title')
    profile_image = serializers.ReadOnlyField(
        source='get_profile_image')

    class Meta:
        model = User
        fields = ('id', 'email', 'is_active',
                  'is_suspended', 'user_role', 'enrv', 'profile_image')


class LoginSerializer(TokenObtainPairSerializer):

    def validate(self, attrs):
        data = super().validate(attrs)
        refresh = self.get_token(self.user)

        user_data = LoggedInUserSerializer(self.user).data
        # print(user_data)
        data['user'] = user_data
        data['refresh'] = str(refresh)
        data['access'] = str(refresh.access_token)

        if api_settings.UPDATE_LAST_LOGIN:
            update_last_login(None, self.user)

        return data


class UserDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserDetail
        exclude = ('user', 'erv_code')


class MyAccountSerializer(serializers.ModelSerializer):
    user_role = serializers.ReadOnlyField(source='get_role_title')
    details = UserDetailSerializer(source="userdetail")

    class Meta:
        model = User
        fields = ['email', 'user_role', 'details']


class ListUserSerializer(serializers.ModelSerializer):
    user_role = serializers.ReadOnlyField(source='get_role_title')
    details = UserDetailSerializer(source="userdetail")
    class Meta:
        model = User
        exclude = ('password',)


class UserPasswordSerializer(serializers.Serializer):
    model = User
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)

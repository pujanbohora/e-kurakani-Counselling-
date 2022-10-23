from dataclasses import field
from rest_framework import serializers
from django.contrib.auth import get_user_model
import requests
import json
from apps.core.models import UserRole

from apps.core.serializers import MyAccountSerializer, UserAppointment, UserSerializer
from apps.profiles.serializers import CounsellorProfileSerializer, ListCounsellorProfileSerializer

from .models import *
from zoom_api_functions import generateToken

# UserRole = get_user_model()

class AppointmentRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppointmentRequest
        fields = '__all__'


class ListAppointmentRequestSerializer(serializers.ModelSerializer):
    requested_by = MyAccountSerializer()
    # counsellor = 
    class Meta:
        model = AppointmentRequest
        fields = '__all__'

class CreateAppointmentSerializer(serializers.ModelSerializer):
    appointment_meeting = serializers.ReadOnlyField()
    class Meta:
        model = Appointment
        fields = '__all__'

class ListAppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = '__all__'

class AppointmentDetailsSerializer(serializers.ModelSerializer):
    user = MyAccountSerializer(read_only=True)
    counsellor = ListCounsellorProfileSerializer(read_only=True)

    class Meta:
        model = Appointment
        fields = '__all__'


class LiveMeetingSerializer(serializers.ModelSerializer):
    zoom_meeting = serializers.ReadOnlyField()
    status = serializers.ReadOnlyField(default='upcoming')
    api_url = serializers.ReadOnlyField(required=False)
    start_meeting_url = serializers.ReadOnlyField(required=False)
    invitation_url = serializers.ReadOnlyField(source='get_meeting_invitation')

    class Meta:
        model = AppointmentMeeting
        fields = '__all__'


class GetAppointmentMeetingSerializer(serializers.ModelSerializer):
    zoom_meeting = serializers.SerializerMethodField()
    status = serializers.ReadOnlyField(default='upcoming')
    join_meeting_url = serializers.ReadOnlyField(source='get_join_meeting_url')
    invitation_url = serializers.ReadOnlyField(source='get_meeting_invitation')
    api_url = serializers.ReadOnlyField(source='get_api_url')

    class Meta:
        model = AppointmentMeeting
        exclude = ('created_by', 'created_date',
                   'last_modified_by', 'last_modified_date',)

    def get_zoom_meeting(self, obj):
        meeting_id = obj.zoom_meeting_id
        # Getting the Zoom Meeting
        headers = {'authorization': 'Bearer %s' % generateToken(),
                   'content-type': 'application/json'}
        r = requests.get(
            f'https://api.zoom.us/v2/meetings/{meeting_id}',
            headers=headers)
        # print(r.json())
        return r.json()

class DashboardSerializer(serializers.ModelSerializer):
        total_counsellor_user = serializers.SerializerMethodField()
        total_business_user = serializers.SerializerMethodField()
        total_customer_user = serializers.SerializerMethodField()
        
        class Meta:
            model = UserRole
            fields = ['total_counsellor_user', 'total_business_user', 'total_customer_user']

        def get_total_counsellor_user(self, obj):
            return UserRole.objects.filter(user_role__title="Counsellor").count()

        def get_total_business_user(self, obj):
            return UserRole.objects.filter(user_role__title="Business").count()

        def get_total_customer_user(self, obj):
            return UserRole.objects.filter(user_role__title="Customer").count()
    
class ReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = Report
        fields = '__all__'


class ReportInfoSerializer(serializers.ModelSerializer):
    appointment = AppointmentDetailsSerializer(read_only=True)
    counsellor = ListCounsellorProfileSerializer(read_only=True)
    reported_by = MyAccountSerializer(read_only=True)

    class Meta:
        model = Report
        fields = '__all__'


class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'


class FeedbackInfoSerializer(serializers.ModelSerializer):
    appointment = AppointmentDetailsSerializer(read_only=True)
    counsellor = ListCounsellorProfileSerializer(read_only=True)
    feedback_by = MyAccountSerializer(read_only=True)
    
    class Meta:
        model = Feedback
        fields = '__all__'


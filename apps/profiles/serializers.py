from rest_framework import serializers
from django.contrib.auth import get_user_model

from apps.core.serializers import MyAccountSerializer
from collections import defaultdict
from datetime import datetime, timedelta

from .models import *

User = get_user_model()

class CategoryListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'
class CategoryTreeSerializer(serializers.ModelSerializer):
    children = serializers.SerializerMethodField()

    class Meta:
        model = Category
        fields = ('id', 'name', 'children')

    def get_children(self, obj):
        descendants = obj.get_descendants()
        children_dict = defaultdict(list)
        for descendant in descendants:
            children_dict[descendant.get_parent.pk].append(descendant)
        children = children_dict.get(obj.id, [])
        serializer = CategoryTreeSerializer(children,
                                            many=True,
                                            context=self.context)
        return serializer.data

class BusinessProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = BusinessProfile
        fields = '__all__'


class CounsellorProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = CounsellorProfile
        fields = '__all__'


class CounsellorProfileInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = CounsellorProfile
        fields = ('id', 'name', 'email')


class BusinessProfileInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = BusinessProfile
        fields = ('id', 'name', 'email')


class ProfileAttachmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProfileAttachments
        fields = '__all__'


class ListProfileAttachmentSerializer(serializers.ModelSerializer):
    counsellor_profile = CounsellorProfileInfoSerializer()
    business_profile = CounsellorProfileInfoSerializer()
    class Meta:
        model = ProfileAttachments
        fields = '__all__'


class CounsellorTimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = CounsellorTimeTable
        fields = '__all__'

class CounsellorTimeInfoSerializer(serializers.ModelSerializer):
    counsellor = CounsellorProfileInfoSerializer()
    class Meta:
        model = CounsellorTimeTable
        fields = '__all__'        


class ListBusinessProfileSerializer(serializers.ModelSerializer):
    # attachments = ProfileAttachmentSerializer(source='profileattachments_set.all', many=True)
    attachments = ListProfileAttachmentSerializer(source='profileattachments_set.all', many=True)
    user = MyAccountSerializer()
    category = CategoryListSerializer()

    class Meta:
        model = BusinessProfile
        fields = '__all__'

class ListCounsellorProfileSerializer(serializers.ModelSerializer):
    attachments = ListProfileAttachmentSerializer(source='profileattachments_set.all', many=True)
    user = MyAccountSerializer()
    category = CategoryListSerializer()
    associated_business = ListBusinessProfileSerializer()

class ListCounsellorProfileSerializer(serializers.ModelSerializer):
    attachments = ListProfileAttachmentSerializer(source='profileattachments_set.all', many=True)
    user = MyAccountSerializer()
    category = CategoryTreeSerializer()
    associated_business = ListBusinessProfileSerializer()
    available_times = serializers.SerializerMethodField()

    class Meta:
        model = CounsellorProfile
        fields = '__all__'



    def get_available_times(self, obj):
        time_table = obj.counsellortimetable_set.filter(date__gt=datetime.now().date())
        counsellor_appointments = obj.appointment_set.filter(date__gt=datetime.now().date())
        available_data = []
        for time_data in time_table:
            interval = obj.time_interval
            start_time = time_data.start_time
            time_intervals = [start_time]
            if interval:
                while start_time < time_data.end_time:
                    str_start_time = f"{start_time.hour}:{start_time.minute}"
                    start_time_obj = datetime.strptime(str_start_time, '%H:%M')
                    session_interval = f"00:{interval}:00"
                    interval_obj = datetime.strptime(session_interval, '%H:%M:%S')
                    start_time_obj += timedelta(hours=interval_obj.hour, minutes=interval_obj.minute, seconds=interval_obj.second)
                    start_time = start_time_obj.time()
                    if start_time != time_data.end_time and start_time < time_data.end_time:
                        time_intervals.append(start_time)
                
                time_intervals_length = len(time_intervals)
                updated_time_intervals = time_intervals.copy()
                
                if len(counsellor_appointments) > 0:
                    for appointment in counsellor_appointments:
                        for i in range(time_intervals_length):
                            if time_intervals[i] == appointment.time and appointment.date == time_data.date:
                                # time_intervals.remove(time_intervals[i])
                                updated_time_intervals.remove(time_intervals[i])
                time_intervals = updated_time_intervals
                
                serialized = CounsellorTimeInfoSerializer(time_data)
                data_to_append = serialized.data
                data_to_append["intervals"] = time_intervals
                
                available_data.append(data_to_append)
            
        return available_data[:3]

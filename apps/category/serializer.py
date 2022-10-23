from multiprocessing import context
from rest_framework import serializers
from django.utils import timezone
from datetime import datetime
from apps.profiles.serializers import ListCounsellorProfileSerializer
from .models import Category
from collections import defaultdict


class CreateCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = Category
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    all_children = serializers.SerializerMethodField()
    
    
    class Meta:
        model = Category
        fields = ('id','name','all_children','parent')

    
    def get_all_children(self,obj):
        return CategorySerializer(obj.get_children(), many=True).data


class CategoryTreeSerializer(serializers.ModelSerializer):
    children = serializers.SerializerMethodField()

    class Meta:
        model = Category
        fields = ('id', 'name', 'children', 'image')

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


class CategoryCounsellorSerializer(serializers.ModelSerializer):
    counsellors = serializers.SerializerMethodField()
    
    class Meta:
        model = Category
        fields = ('id', 'name', 'counsellors')

    def get_counsellors(self, obj):
        counsellors = obj.counsellorprofile_set.filter(status='approved')
        serialized = ListCounsellorProfileSerializer(counsellors, many=True, context=self.context)
        return serialized.data
        

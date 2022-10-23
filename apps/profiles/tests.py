from datetime import datetime
import json
from time import time
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.test import APITestCase
from .models import *

User = get_user_model()

class CounsellorProfileTestCase(APITestCase):
    def setUp(self):
        test_user = User.objects.create(email="testcase@email.com", password="testcase")  
    
    def test_create_cp(self):
        data = {
            "user": User.objects.all().first().id
        }
        response = self.client.post("/api/rest/v1/profiles/counsellor-profile/", data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_cp(self):
        cp_obj = CounsellorProfile.objects.create(
                        user=User.objects.all().first(),
                        price=100
                    )
        response = self.client.get(f"/api/rest/v1/profiles/counsellor-profile/{cp_obj.id}/")
        self.assertEqual(response.data["price"], 100)
    
    def test_delete_cp(self):
        cp_obj = CounsellorProfile.objects.create(
                        user=User.objects.all().first(),
                        price=100
                    )
        response = self.client.delete(f"/api/rest/v1/profiles/counsellor-profile/{cp_obj.id}/")
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)


class BusinessProfileTestCase(APITestCase):
    def setUp(self):
        test_user = User.objects.create(email="testcase@email.com", password="testcase")  
    
    def test_create_bp(self):
        data = {
            "user": User.objects.all().first().id
        }
        response = self.client.post("/api/rest/v1/profiles/business-profile/", data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_bp(self):
        bp_obj = BusinessProfile.objects.create(
                        user=User.objects.all().first(),
                        name="Test"
                    )
        response = self.client.get(f"/api/rest/v1/profiles/business-profile/{bp_obj.id}/")
        self.assertEqual(response.data["name"], "Test")
    
    def test_delete_cp(self):
        bp_obj = BusinessProfile.objects.create(
                        user=User.objects.all().first(),
                        name="Test"
                    )
        response = self.client.delete(f"/api/rest/v1/profiles/business-profile/{bp_obj.id}/")
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
    

class ScheduleTestCase(APITestCase):
    def setUp(self):
        test_user = User.objects.create(email="testcase@email.com", password="testcase")  
        test_counsellor = CounsellorProfile.objects.create(user=test_user)
    
    def test_create_schedule(self):
        data = {
            "date": "2022-06-20",
            "start_time": "11:00",
            "end_time": "15:00",
            "counsellor": CounsellorProfile.objects.first().id
        }
        response = self.client.post("/api/rest/v1/profiles/schedule/", data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_schedule(self):
        schedule_obj = CounsellorTimeTable.objects.create(
                        counsellor=CounsellorProfile.objects.first(),
                        date="2022-06-20",
                        start_time="11:00",
                        end_time="15:00",
                    )
        response = self.client.get(f"/api/rest/v1/profiles/schedule/{schedule_obj.id}/")
        self.assertEqual(response.data["date"], "2022-06-20")
    
    def test_delete_schedule(self):
        schedule_obj = CounsellorTimeTable.objects.create(
                        counsellor=CounsellorProfile.objects.first(),
                        date="2022-06-20",
                        start_time="11:00",
                        end_time="15:00",
                    )
        response = self.client.delete(f"/api/rest/v1/profiles/schedule/{schedule_obj.id}/")
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

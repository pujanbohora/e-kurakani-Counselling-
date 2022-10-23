from datetime import datetime
import json
from time import time
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.test import APITestCase
from .models import *
from .serializers import *

User = get_user_model()

class ReportTestCase(APITestCase):
    def setUp(self):
        test_user = User.objects.create(email="testcase@email.com", password="testcase")
        test_counsellor = CounsellorProfile.objects.create(user=test_user)
        test_appointment = Appointment.objects.create(
                                user=test_user, 
                                counsellor=test_counsellor, 
                                time=datetime.now().time(), 
                                date=datetime.now().date()
                            )   

    def test_create_report(self):
        user_obj = User.objects.all().first()
        counsellor_obj = CounsellorProfile.objects.all().first()
        counsellor_report_data = {
            "counsellor": counsellor_obj.id,
            "reported_by": user_obj.id,
            "report_for": "counsellor",
            "title": "Test Case",
            "description": "Test Description",
        }
        appointment_report_data = {
            "counsellor": counsellor_obj.id,
            "reported_by": user_obj.id,
            "report_for": "appointment",
            "title": "Test Case",
            "description": "Test Description",
        }
        counsellor_response = self.client.post("/api/rest/v1/appointment/report/", counsellor_report_data)
        appointment_response = self.client.post("/api/rest/v1/appointment/report/", appointment_report_data)
        self.assertEqual(counsellor_response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(appointment_response.status_code, status.HTTP_201_CREATED)

    def test_get_report(self):
        report_obj = Report.objects.create(
                        appointment=Appointment.objects.all().first(), 
                        reported_by=User.objects.all().first(), 
                        report_for="appointment",
                        title="Test",
                        description="Description"
                    )
        response = self.client.get(f"/api/rest/v1/appointment/report/{report_obj.id}/")
        self.assertEqual(response.data["report_for"], "appointment")
    
    def test_delete_report(self):
        report_obj = Report.objects.create(
                        appointment=Appointment.objects.all().first(), 
                        reported_by=User.objects.all().first(), 
                        report_for="appointment",
                        title="Test",
                        description="Description"
                    )
        response = self.client.delete(f"/api/rest/v1/appointment/report/{report_obj.id}/")
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)


class FeedbackTestCase(APITestCase):
    def setUp(self):
        test_user = User.objects.create(email="testcase@email.com", password="testcase")
        test_counsellor = CounsellorProfile.objects.create(user=test_user)
        test_appointment = Appointment.objects.create(
                                user=test_user, 
                                counsellor=test_counsellor, 
                                time=datetime.now().time(), 
                                date=datetime.now().date()
                            )   

    def test_create_feedback(self):
        counsellor_feedback_data = {
            "counsellor": "1",
            "feedback_by": "1",
            "feedback_for": "counsellor",
            "message": "Test Description",
        }
        appointment_feedback_data = {
            "appointment": "1",
            "feedback_by": "1",
            "feedback_for": "appointment",
            "message": "Test Description",
        }
        counsellor_response = self.client.post("/api/rest/v1/appointment/feedback/", counsellor_feedback_data)
        appointment_response = self.client.post("/api/rest/v1/appointment/feedback/", appointment_feedback_data)
        self.assertEqual(counsellor_response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(appointment_response.status_code, status.HTTP_201_CREATED)

    def test_get_feedback(self):
        feedback_obj = Feedback.objects.create(
                        appointment=Appointment.objects.all().first(), 
                        feedback_by=User.objects.all().first(), 
                        feedback_for="appointment",
                        message="Test",
                    )
        response = self.client.get(f"/api/rest/v1/appointment/feedback/{feedback_obj.id}/")
        self.assertEqual(response.data["feedback_for"], "appointment")
    
    def test_delete_feedback(self):
        feedback_obj = Feedback.objects.create(
                        appointment=Appointment.objects.all().first(), 
                        feedback_by=User.objects.all().first(), 
                        feedback_for="appointment",
                        message="Test",
                    )
        response = self.client.delete(f"/api/rest/v1/appointment/feedback/{feedback_obj.id}/")
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)


    
    
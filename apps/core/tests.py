import json
from django.contrib.auth import get_user_model
from django.urls import reverse
from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.test import APITestCase
from .models import *
from .serializers import *

User = get_user_model()

class RegistrationTestCase(APITestCase):
    def setUp(self):
        Role.objects.create(title="Customer", hierarchy=0)
        Role.objects.create(title="Counsellor", hierarchy=1)
        Role.objects.create(title="Business", hierarchy=2)
        Role.objects.create(title="Admin", hierarchy=3)

    def test_registration(self):
        data = {"email": "testcase@email.com", "password": "qpalzm10", "user_role": "Customer"}

        response = self.client.post("/api/rest/v1/core/user-register/", data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
    
class LoginTestCase(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(email="new@email.com", password="qpalzm10")

    def test_login(self):
        data = {"email": self.user.email, "password": self.user.password}
        response = self.client.post("/api/rest/v1/core/user-login/", data)
        self.assertEqual(response.data["user"]["email"], self.user.email)

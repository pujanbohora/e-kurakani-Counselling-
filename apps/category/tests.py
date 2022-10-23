from datetime import datetime
import json
from time import time
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.test import APITestCase
from .models import *

User = get_user_model()

class CategoryTestCase(APITestCase):
    def test_create_category(self):
        data = {
            "name": "New Category",
        }
        response = self.client.post("/api/rest/v1/category/", data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_category(self):
        category_obj = Category.objects.create(
                        name="Test Case",
                    )
        response = self.client.get(f"/api/rest/v1/category/{category_obj.id}/")
        self.assertEqual(response.data["name"], "Test Case")
    
    def test_delete_category(self):
        category_obj = Category.objects.create(
                        name="Test Case",
                    )
        response = self.client.delete(f"/api/rest/v1/category/{category_obj.id}/")
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

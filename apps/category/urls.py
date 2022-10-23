from rest_framework.routers import DefaultRouter
from .views import *
from django.urls import path, re_path, include

routes = DefaultRouter()

routes.register("",CategoryViewSet, basename = 'category')

app_name = 'category'

urlpatterns = [
    path('sub-categories/', ListSubCategoryView.as_view(), name='sub-categories'),
    path('<str:category_id>/counsellors/', ListCategoryCounsellors.as_view(), name='category-counsellors'),
]

urlpatterns += routes.urls
from posixpath import basename
from .views import *
from django.urls import path, re_path, include
from rest_framework.routers import DefaultRouter

routes = DefaultRouter()

routes.register(r'user-login', LoginViewSet, basename='user-login')
routes.register(r'user', UserViewSet, basename='user')
routes.register(r'refresh-jwt', RefreshViewSet,
                basename='refresh-jwt')
routes.register(r'user-details', UserDetailViewSet, basename='user-details')

app_name = 'core'

urlpatterns = [
    path('user-register/', UserRegisterAPI.as_view(), name='user-register'),
    path('verify-email/', VerifyOTPView.as_view(), name='verify-email'),
    path('user-account/<str:pk>/', MyAccountAPI.as_view(), name='my-account'),

    re_path(r'^auth/', include('djoser.urls')),

    path('validate-logged-in-user/', ValidateLoggedInUserAPI.as_view()),
    path('forget-password/', ForgetPasswordView.as_view(), name='forget-password'),
    path('reset-code/', ResetCodeView.as_view(), name='reset-code'),
    path('reset-password/', ResetPassword.as_view(), name='reset-password'),
    path('change-password/', ChangePasswordView.as_view(), name='change-password'),
]

urlpatterns += routes.urls


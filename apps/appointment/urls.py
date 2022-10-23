from posixpath import basename

from apps.core.views import ForgetPasswordView
from .views import *
from django.urls import path, re_path, include
from rest_framework.routers import DefaultRouter

routes = DefaultRouter()

routes.register(r'request', AppointmentRequestViewSet, basename='request')
routes.register(r'(?P<counsellor>[-\w]+)/request', AppointmentRequestViewSet, basename='request')
routes.register(r'generate', CreateAppointmentViewSet, basename='generate')
routes.register(r'(?P<appointment_id>[-\w]+)/meeting', AppointmentMeetingViewSet, basename='appointment-meeting')
routes.register(r'report', ReportViewSet, basename='report')
routes.register(r'feedback', FeedbackViewSet, basename='feedback')


app_name = 'appointment'

urlpatterns = [
    path('counsellor-business-appointments/', CounsellorBusinessAppointmentsView.as_view(), name='counsellor-appointments'),

    path('<str:appointment_id>/get-zoom-sdk-sign/', GetZoomSDKSignature.as_view(),
         name='get-zoom-sdk-sign'),
    path('<str:appointment_id>/get-zoom-invitation/<str:meeting_id>/', GetZoomMeetingInvitation.as_view(),
         name='get-zoom-invitation'),
         
    path('khalti-verify/', VerifyKhaltiPaymentView.as_view(), name='khalti-verify'),
    path('past-appointment/', PastAppointmentAPIView.as_view(), name='past-appointment'), 
    path('dashboard-data/', DashboardAPIViews.as_view(), name='dashboard-data'), 
]

urlpatterns += routes.urls


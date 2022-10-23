from posixpath import basename
from .views import *
from django.urls import path, re_path, include
from rest_framework.routers import DefaultRouter

routes = DefaultRouter()

routes.register(r'business-profile', BusinessProfileViewSet, basename='business_profile')
routes.register(r'counsellor-profile', CounsellorProfileViewSet, basename='counsellor_profile')
routes.register(r'schedule', CounsellorTimeTableViewSet, basename='counsellor_schedule')
routes.register(r'attachments', ProfileAttachmentViewSet, basename='attachments')
routes.register(r'(?P<business_profile>[-\w]+)/counsellor-profile',
                CounsellorProfileViewSet,
                basename='counsellor_profile')
routes.register(r'(?P<business_profile>[-\w]+)/business/attachments',
                ProfileAttachmentViewSet,
                basename='business_attachments')
routes.register(r'(?P<counsellor_profile>[-\w]+)/counsellor/attachments',
                ProfileAttachmentViewSet,
                basename='counsellor_attachments')


app_name = 'profiles'

urlpatterns = [
    path('get-counsellor-profile/<str:id>/', GetUserCounsellorProfileView.as_view(), name='user-counsellor-profile'),
    path('get-business-profile/<str:id>/', GetUserBusinessProfileView.as_view(), name='user-business-profile'),
    path('create-month-timetable/', MonthlyTimeTableCreateView.as_view(), name='create-month-timetable'),
    path('applied-counsellor-profiles/', ListAppliedCounsellorProfiles.as_view(), name='applied-counsellor-profiles'),
    path('applied-business-profiles/', ListAppliedBusinessProfiles.as_view(), name='applied-business-profiles'),
    path('my-schedule/', MyScheduleAPIView.as_view(), name='my-schedule'),
]

urlpatterns += routes.urls


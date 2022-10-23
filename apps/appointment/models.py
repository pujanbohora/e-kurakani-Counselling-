from tkinter import CASCADE
from django.db import models
from django.forms import ChoiceField
from apps.core.models import DefaultModel
from django.contrib.auth import get_user_model

from apps.profiles.models import CounsellorProfile

User = get_user_model()

class AppointmentRequest(DefaultModel):
    REQUEST_CHOICES = (
        ('requested', 'Requested'),
        ('approved', 'Approved'),
        ('declined', 'Declined')
    )
    requested_by = models.ForeignKey(User, on_delete=models.CASCADE)
    counsellor = models.ForeignKey(CounsellorProfile, on_delete=models.CASCADE)
    preferred_date = models.DateField()
    preferred_time = models.CharField(max_length=100)
    remarks = models.TextField(null=True, blank=True)
    status = models.CharField(max_length=20, choices=REQUEST_CHOICES, default='requested')

    def __str__(self):
        return f"Request: {self.requested_by.email} to {self.counsellor.name}"

class Appointment(DefaultModel):
    APPOINTMENT_STATUS = (
        ('pending', 'Pending'),
        ('completed', 'Completed'),
        ('canceled', 'Canceled')
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    counsellor = models.ForeignKey(CounsellorProfile, on_delete=models.CASCADE)
    time = models.TimeField()
    date = models.DateField()
    status = models.CharField(max_length=20, choices=APPOINTMENT_STATUS, default="pending")
    payment = models.BooleanField(default=False)
    appointment_charge = models.FloatField(null=True, blank=True, max_length=20, default=0.0)
    payment_intent = models.CharField(max_length=90, null=True, blank=True)

    # def __str__(self) -> str:
    #     return self.time, self.date, self.customer, self.customer 
    @property
    def total_appointment():
        return Appointment.objects.all().count()

class AppointmentMeeting(DefaultModel):
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE)
    zoom_meeting_id = models.CharField(max_length=75)
    start_time = models.DateTimeField(blank=True, null=True)

    class Meta:
        ordering = ['start_time']
    
    def __str__(self):
        return f'Meeting {self.id} for Appointment {self.appointment.id}'

    @property
    def get_api_url(self):
        url = '/api/rest/v1/appointment/' + str(self.appointment.id) + '/meeting/' + str(self.id) + '/'
        return url

    @property
    def get_start_meeting_url(self):
        url = ''
        # url = '/course-secondary/' + \
        #         str(self.course_object.slug) + \
        #         '/live-class/start/' + str(self.id) + '/'
        return url

    @property
    def get_join_meeting_url(self):
        url = ''
        # url = '/course-secondary/' + \
        #         str(self.course_object.slug) + \
        #         '/live-class/join/' + str(self.id) + '/'        
        return url

    @property
    def get_meeting_invitation(self):
        url = '/api/rest/v1/appointment/' + str(self.appointment.id) + '/get-zoom-invitation/' + str(self.zoom_meeting_id) + '/'
        return url
    

GENERAL_TYPE = (
    ('counsellor', 'Counsellor'),
    ('appointment', 'Appointment'),
)

class Report(DefaultModel):
    counsellor = models.ForeignKey(CounsellorProfile, on_delete=models.CASCADE, null=True, blank=True)
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE, null=True, blank=True)
    reported_by = models.ForeignKey(User, on_delete=models.CASCADE)
    report_for = models.CharField(max_length=20, choices=GENERAL_TYPE, default='counsellor')
    title = models.CharField(max_length=155)
    description = models.TextField(null=True, blank=True)


class Feedback(DefaultModel):
    counsellor = models.ForeignKey(CounsellorProfile, on_delete=models.CASCADE, null=True, blank=True)
    appointment = models.ForeignKey(Appointment, on_delete=models.CASCADE, null=True, blank=True)
    feedback_by = models.ForeignKey(User, on_delete=models.CASCADE)
    feedback_for = models.CharField(max_length=20, choices=GENERAL_TYPE, default='counsellor')
    star = models.PositiveSmallIntegerField(null=True)
    message = models.TextField()


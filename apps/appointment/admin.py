from django.contrib import admin
from .models import *

admin.site.register(AppointmentRequest)
admin.site.register(Appointment)
admin.site.register(AppointmentMeeting)
admin.site.register(Report)
admin.site.register(Feedback)

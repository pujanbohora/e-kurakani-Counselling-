from django.db import models
from apps.category.models import Category
from apps.core.models import DefaultModel
from django.contrib.auth import get_user_model

User = get_user_model()

PROFILE_STATUSES = (
    ('submitted', 'Submitted'),
    ('under_review', 'Under Review'),
    ('approved', 'Approved'),
    ('declined', 'Declined')
)


class ProfileModel(DefaultModel):
    name = models.CharField(max_length=100, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    contact_number = models.CharField(max_length=20, null=True)
    status = models.CharField(max_length=20, choices=PROFILE_STATUSES, default='submitted')
    apply_for_verification = models.BooleanField(default=False)
    remarks = models.CharField(max_length=255, null=True, blank=True)

    class Meta:
        abstract = True


class CounsellorProfile(ProfileModel):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, null=True, blank=True, on_delete=models.CASCADE)
    is_freelancer = models.BooleanField(default=False)
    associated_business = models.ForeignKey('BusinessProfile', null=True, blank=True, on_delete=models.CASCADE)
    time_interval = models.PositiveSmallIntegerField(null=True)
    price = models.FloatField(null=True)
    available_for_weekend = models.BooleanField(default=False)

    class Meta:
        ordering = ['-created_date']

    # def __str__(self):
    #     return self.name


class BusinessProfile(ProfileModel):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, null=True, blank=True, on_delete=models.CASCADE)
    logo = models.ImageField(upload_to="user-profiles/logos", null=True)

    class Meta:
        ordering = ['-created_date']

    @property
    def total_businessUser(self):
        return BusinessProfile.objects.all().count()
    
    # def __str__(self):
    #     return self.name


class ProfileAttachments(DefaultModel):
    counsellor_profile = models.ForeignKey(CounsellorProfile, null=True, blank=True, on_delete=models.CASCADE)
    business_profile = models.ForeignKey(BusinessProfile, null=True, blank=True, on_delete=models.CASCADE)
    label = models.CharField(max_length=250, null=True)
    file = models.FileField(upload_to="users-profiles/attachments/", null=True)
    remarks = models.TextField(blank=True, null=True)

    def __str__(self) -> str:
        return f'{self.label}'


class CounsellorTimeTable(DefaultModel):
    date = models.DateField(null=True)
    start_time = models.TimeField()
    end_time = models.TimeField()
    counsellor = models.ForeignKey(CounsellorProfile, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.date} -> {self.start_time} to {self.end_time}"

    class Meta:
        ordering = ['date']

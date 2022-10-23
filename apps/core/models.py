from django.db import models

from django.contrib.auth.models import AbstractBaseUser, BaseUserManager


class Role(models.Model):
    title = models.CharField(max_length=45, unique=True)
    hierarchy = models.PositiveSmallIntegerField()

    def __str__(self):
        return self.title


class UserManager(BaseUserManager):

    def create_user(self, email, password=None, **kwargs):
        """Create and return a `User` with an email, phone number and password."""

        if email is None:
            raise TypeError('Users must have an email.')

        user = self.model(email=self.normalize_email(email))
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, email, password):
        """
        Create and return a `User` with superuser (admin) permissions.
        """
        if password is None:
            raise TypeError('Superusers must have a password.')
        if email is None:
            raise TypeError('Superusers must have an email.')

        user = self.create_user(email, password)
        user.is_admin = True
        user.is_staff = True
        user.is_active = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser):
    email = models.EmailField(
        db_index=True, unique=True,  null=True, blank=True)
    is_active = models.BooleanField("Email Verified", default=False)
    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)
    is_suspended = models.BooleanField("Account Suspended", default=False)
    enrv = models.BooleanField("Email needs Re Verification ", default=False)
    created_at = models.DateField(auto_now_add=True, null=True)
    last_updated_at = models.DateField(auto_now=True, null=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = UserManager()

    class Meta:
        ordering = ['id']

    def __str__(self):
        return f"{self.email}"

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def get_user_role(self):
        return self.userrole.user_role

    @property
    def get_role_hierarchy(self):
        role = self.get_user_role
        return role.hierarchy

    @property
    def get_role_title(self):
        return self.get_user_role.title

    @property
    def get_profile_image(self):
        if self.userdetail.profile_image:
            return self.userdetail.profile_image.url
        return None
        

class UserRole(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    user_role = models.ForeignKey(Role, on_delete=models.CASCADE)

    def __str__(self):
        return f'User - {self.user.email} => Role - {self.user_role.title}'

    @property
    def get_role_title(self):
        return self.user_role.title

    @property
    def total_cousellor_user(self):
        qs= UserRole.objects.filter(user_role__title='Counsellor').values('user_role').count()
        print('qs = ', qs)
        return qs

    @property
    def total_customer_user(self):
        return UserRole.objects.filter(user_role__title='Customer').count()

    @property
    def total_business_user(self):
        return UserRole.objects.filter(user_role__title='Business').count()

    @property
    def total_admin_user(self):
        return UserRole.objects.filter(user_role__title='Admin').count()
    

class UserDetail(models.Model):
    GENDER_CHOICES = (
        ('male', 'Male'),
        ('female', 'Female'),
        ('other', 'Others'),
    )

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=300, blank=True, null=True)
    bio = models.TextField(blank=True, null=True)
    profile_image = models.ImageField(upload_to='accounts/profile_image/', blank=True, null=True)
    gender = models.CharField(max_length=30, choices=GENDER_CHOICES, blank=True, null=True)
    date_of_birth = models.DateField(blank=True, null=True)
    contact_number = models.CharField(max_length=30, blank=True, null=True)
    erv_code = models.CharField(
        "Email Re-verification Code", max_length=6, blank=True, null=True)
    reset_code = models.CharField("Password Reset Code", max_length=6, blank=True, null=True)

    def __str__(self):
        return f'{self.id}. Details for {self.user.email}'


class DefaultModel(models.Model):
    created_date = models.DateTimeField(
        ("Created Date"), auto_now_add=True, editable=False)
    created_by = models.ForeignKey(
        User, on_delete=models.SET_NULL, null=True, blank=True,  related_name='%(class)s_created', verbose_name="Created By")
    last_modified_date = models.DateTimeField(
        ("Last Modified Date"), auto_now=True, editable=True)
    last_modified_by = models.ForeignKey(
        User, on_delete=models.SET_NULL, null=True, blank=True, related_name='%(class)s_modified', verbose_name="Last Modified By")

    class Meta:
        abstract = True

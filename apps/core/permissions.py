from rest_framework.permissions import BasePermission

from django.contrib.auth import get_user_model

User = get_user_model()


class CustomBasePermission(BasePermission):
    message = 'User does not have the access yet!'

    def has_access(self, current_user, view):
        return True

    def has_permission(self, request, view):
        # print(request.user)
        current_user = request.user
        if current_user and current_user.is_active and not current_user.is_suspended:
            return self.has_access(current_user, view)
        return False

    def has_object_permission(self, request, view, obj):
        return self.has_permission(request, view)


class IsSuperUser(CustomBasePermission):
    message = "Only Admin users can access this!"

    def has_access(self, current_user, view):
        return current_user.is_admin


class IsLoggedInUser(BasePermission):
    def has_permission(self, request, view):
        # print(request.user)
        current_user = request.user
        if current_user:
            return True
        return False


class IsClient(CustomBasePermission):
    message = "Only Clients can access this!"

    def has_access(self, current_user, view):
        return current_user.get_role_hierarchy == 1

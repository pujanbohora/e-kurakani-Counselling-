from rest_framework import viewsets
from rest_framework.permissions import AllowAny
from rest_framework import generics, status
from rest_framework.response import Response

from apps.profiles.models import CounsellorProfile
from .serializer import *



class CategoryViewSet(viewsets.ModelViewSet):
    serializer_class = CreateCategorySerializer
    queryset = Category.objects.all()
    def get_permissions(self):
        if self.action in ('retrieve', list):
            self.permission_classes = [AllowAny]
        else:
            self.permission_classes = [AllowAny]
            # self.permission_classes = [IsSuperUser]
        return super(CategoryViewSet, self).get_permissions()

    def get_serializer_class(self):
        if self.action == 'retrieve':
            return CategorySerializer
        return super().get_serializer_class()

    def list(self, request):
        tree = Category.objects.filter(level=0)
        serializer = CategoryTreeSerializer(tree, many=True, context={'request': request})
        return Response(serializer.data)    


class ListCategoryCounsellors(generics.ListAPIView):
    serializer_class = CategoryCounsellorSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        category_id = self.kwargs['category_id']
        qs = Category.objects.filter(id=category_id)
        if qs.exists():
            return qs[0] 
        return None
    
    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        if queryset is not None:
            serialzied = CategoryCounsellorSerializer(queryset, context={'request': request})
            return Response(serialzied.data, status=status.HTTP_200_OK)
        return Response({"error": "No category found"}, status=status.HTTP_400_BAD_REQUEST)


class ListSubCategoryView(generics.ListAPIView):
    serializer_class = CategoryTreeSerializer
    permission_classes = [AllowAny]
    queryset = Category.objects.filter(level=1)


from statistics import mode
from django.db import models

from apps.core.models import DefaultModel
from mptt.models import MPTTModel, TreeForeignKey

class Category(MPTTModel, DefaultModel):
    name = models.CharField(max_length=100, unique = True)
    parent = TreeForeignKey('self',
                            on_delete = models.CASCADE,
                            null=True,
                            blank=True,
                            related_name='children')
    image = models.ImageField(upload_to="category/image", null=True)

    class MPTTMeta:
        order_insertion_by = ['name']

    def __str__(self):
        if self.parent:
            parent = self.parent.name + " -> "
        else:
            parent = ""
        return "{}{}".format(parent, self.name)    

    @property
    def get_parent(self):
        return self.parent  
          



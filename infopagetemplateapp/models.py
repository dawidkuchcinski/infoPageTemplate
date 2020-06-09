from django.db import models

# Create your models here.

class Banner(models.Model):
    ban_name = models.CharField(max_length=255, default='banne_name')
    ban_placeholder = models.CharField(max_length=3, default='pl1')
    ban_img = models.ImageField(upload_to='',max_length=100)

    def __str__(self):
        return self.ban_name
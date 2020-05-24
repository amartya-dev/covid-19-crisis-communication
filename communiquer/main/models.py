from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

STATE_CHOICES = (("Andhra Pradesh", "Andhra Pradesh"), ("Arunachal Pradesh ", "Arunachal Pradesh "), ("Assam", "Assam"),
                 ("Bihar", "Bihar"), ("Chhattisgarh", "Chhattisgarh"), ("Goa", "Goa"), ("Gujarat", "Gujarat"),
                 ("Haryana", "Haryana"), ("Himachal Pradesh", "Himachal Pradesh"),
                 ("Jammu and Kashmir", "Jammu and Kashmir"), ("Jharkhand", "Jharkhand"), ("Karnataka", "Karnataka"),
                 ("Kerala", "Kerala"), ("Madhya Pradesh", "Madhya Pradesh"), ("Maharashtra", "Maharashtra"),
                 ("Manipur", "Manipur"), ("Meghalaya", "Meghalaya"), ("Mizoram", "Mizoram"), ("Nagaland", "Nagaland"),
                 ("Odisha", "Odisha"), ("Punjab", "Punjab"), ("Rajasthan", "Rajasthan"), ("Sikkim", "Sikkim"),
                 ("Tamil Nadu", "Tamil Nadu"), ("Telangana", "Telangana"), ("Tripura", "Tripura"),
                 ("Uttar Pradesh", "Uttar Pradesh"), ("Uttarakhand", "Uttarakhand"), ("West Bengal", "West Bengal"),
                 ("Andaman and Nicobar Islands", "Andaman and Nicobar Islands"), ("Chandigarh", "Chandigarh"),
                 ("Dadra and Nagar Haveli", "Dadra and Nagar Haveli"), ("Daman and Diu", "Daman and Diu"),
                 ("Lakshadweep", "Lakshadweep"),
                 ("National Capital Territory of Delhi", "National Capital Territory of Delhi"),
                 ("Puducherry", "Puducherry"))


class Address(models.Model):
    street_address = models.CharField(max_length=250)
    locality = models.CharField(max_length=250)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=250,
                             choices=STATE_CHOICES)
    pin_code = models.IntegerField()


class Profile(models.Model):
    PROFILE_TYPES = (
        ('user', 'User'),
        ('authorities', 'Authorities'),
        ('vendor', 'Vendor')
    )
    user = models.OneToOneField(
        to=User,
        on_delete=models.CASCADE
    )
    address = models.ForeignKey(
        to=Address,
        on_delete=models.CASCADE
    )
    profile_type = models.CharField(
        max_length=20,
        choices=PROFILE_TYPES
    )


class CheckupRequest(models.Model):
    user = models.ForeignKey(
        to=User,
        on_delete=models.CASCADE
    )
    date = models.DateField()
    time = models.TimeField()


class DeliveryRequest(models.Model):
    user = models.ForeignKey(
        to=User,
        on_delete=models.CASCADE
    )
    vendor = models.ForeignKey(
        to=User,
        on_delete=models.CASCADE,
        related_name='vendor'
    )
    details = models.TextField()

from django.contrib import admin

from main.models import Profile, Address, CheckupRequest, DeliveryRequest


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ["user", "profile_type", "address"]
    list_editable = ["profile_type"]


@admin.register(Address)
class AddressAdmin(admin.ModelAdmin):
    list_display = ["street_address", "city", "pin_code"]


@admin.register(CheckupRequest)
class CheckupRequestAdmin(admin.ModelAdmin):
    list_display = ["user", "date", "time"]


@admin.register(DeliveryRequest)
class DeliveryRequestAdmin(admin.ModelAdmin):
    list_display = ["user", "vendor", "details"]

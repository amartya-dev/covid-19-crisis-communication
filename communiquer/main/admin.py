from django.contrib import admin

from main.models import Profile, Address


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ["user", "profile_type", "address"]
    list_editable = ["profile_type"]


@admin.register(Address)
class AddressAdmin(admin.ModelAdmin):
    list_display = ["street_address", "city", "pin_code"]

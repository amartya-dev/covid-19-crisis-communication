from main.models import Profile, Address
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

    class Meta:
        model = User
        fields = ('username', 'first_name', 'last_name', 'email', 'password')
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['username', 'email']
            )
        ]


class AddressSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        address = Address.objects.create_user(**validated_data)
        return address

    class Meta:
        model = Address
        fields = ('street_address', 'locality', 'city', 'pin_code')


class ProfileSerializer(serializers.ModelSerializer):
    user = UserSerializer(required=True)
    address = AddressSerializer(required=True)

    class Meta:
        model = Profile
        fields = ('user', 'address', 'profile_type')

    def create(self, validated_data):
        user_data = validated_data.pop('user')
        address_data = validated_data.pop('address')
        user = UserSerializer.create(UserSerializer(), validated_data=user_data)
        address = AddressSerializer.create(AddressSerializer(), validated_data=address_data)
        profile, created = Profile.objects.update_or_create(user=user,
                                                            address=address,
                                                            profile_type=validated_data.pop("profile_type")
                                                            )
        return profile

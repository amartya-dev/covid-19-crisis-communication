from django.urls import path
from apis.views import UserProfileCreateView

app_name = 'api'
urlpatterns = [
    path('users/', UserProfileCreateView.as_view(), name='users'),
]

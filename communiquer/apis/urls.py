from django.urls import path
from apis.views import UserProfileCreateView, BotCommunicateView, \
    StartSessionView

app_name = 'api'
urlpatterns = [
    path('users/', UserProfileCreateView.as_view(), name='users'),
    path('chat/', BotCommunicateView.as_view(), name='communicate'),
    path('create_session/', StartSessionView.as_view(), name='start_session')
]

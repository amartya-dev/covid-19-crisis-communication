from django.urls import path
from apis.views import UserProfileCreateView, BotCommunicateView, \
    StartSessionView, GetVendorsView, DeliveryRequestView, CheckupRequestView, GetStateDataView

app_name = 'api'
urlpatterns = [
    path('users/', UserProfileCreateView.as_view(), name='users'),
    path('chat/', BotCommunicateView.as_view(), name='communicate'),
    path('create_session/', StartSessionView.as_view(), name='start_session'),
    path('get_vendors/', GetVendorsView.as_view(), name='get_vendors'),
    path('delivery_request/', DeliveryRequestView.as_view(), name='delivery_request'),
    path('checkup_request/', CheckupRequestView.as_view(), name='checkup_request'),
    path('get_states/', GetStateDataView.as_view(), name="state_data")
]

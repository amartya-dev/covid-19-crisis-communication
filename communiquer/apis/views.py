import os
import pickle
from ibm_watson import AssistantV2
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from django.shortcuts import get_object_or_404
from django.contrib.auth.models import User
from django.http import Http404


from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser, IsAuthenticated


from apis.serializers import ProfileSerializer
from main.models import Profile, DeliveryRequest, CheckupRequest
from main.getstatecount import getStateCaseCount

VERSION = os.environ.get('watson_version', '2020-04-01')
SERVICE_URL = os.environ.get('watson_service_url', 'https://abc.com/')
API_KEY = os.environ.get('watson_api_key', '123')
ASSISTANT_ID = os.environ.get("watson_assistant_id", "123")

# Set up authenticator here itself
authenticator = IAMAuthenticator(f"{API_KEY}")
assistant = AssistantV2(
    version=f"{VERSION}",
    authenticator=authenticator
)

assistant.set_service_url(f"{SERVICE_URL}")


class UserProfileCreateView(APIView):
    permission_classes = [IsAdminUser]

    def get(self, format=None):
        profiles = Profile.objects.all()
        serializer = ProfileSerializer(profiles, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = ProfileSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            serializer.error_messages, status=status.HTTP_400_BAD_REQUEST
        )


class StartSessionView(APIView):
    permission_classes = [IsAdminUser]

    def post(self, request):
        response = assistant.create_session(
            assistant_id=f"{ASSISTANT_ID}"
        ).get_result()
        if response["session_id"]:
            return Response(
                {
                    "session_id": response["session_id"]
                },
                status=status.HTTP_200_OK
            )
        return Response(
            {
                "message": "Could not create session"
            },
            status=status.HTTP_400_BAD_REQUEST
        )


class BotCommunicateView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        message = request.data["message"]
        session_id = request.data["session_id"]
        try:
            print(request.user.username)
            print(request.auth.key)
            userProfile = get_object_or_404(Profile, user=request.user)
            pinCode = userProfile.address.pin_code
            ofile = open("pincode.dat", "rb")
            pinCodeMapping = pickle.load(ofile)
            district = pinCodeMapping[pinCode]
            state = userProfile.address.state
            context_to_send = {
                'skills': {
                    'main skill': {
                        'user_defined': {
                            'userlocation': district,
                            'state': state,
                            'accesstoken': request.auth.key
                        }
                    }
                }
            }
            print(context_to_send)
        except Http404:
            print ("HTTP 404 error")
            context_to_send = {}
        response = assistant.message(
            assistant_id=f"{ASSISTANT_ID}",
            session_id=f"{session_id}",
            input={
                'message_type': 'text',
                'text':f'{message}'
            },
            context=context_to_send
        ).get_result()
        print(response)
        response_messages = ""
        options = []
        for message in response["output"]["generic"]:
            if "text" in message:
                response_messages += message["text"] + "\n"
            elif "options" in message:
                response_messages += message["title"] + "\n"
                for option in message["options"]:
                    options.append(option)
        return Response(
            {
                "response": response_messages,
                "options": options
            },
            status=status.HTTP_200_OK
        )


class GetVendorsView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):
        userProfile = get_object_or_404(Profile, user=request.user)
        users = Profile.objects.filter(
            address__pin_code=userProfile.address.pin_code
        ).filter(profile_type='vendor')
        vendorList = []
        for user in users:
            vendorList.append({
                "username": user.user.username,
                "displayName": user.user.first_name
            })
        return Response(
            {
                "vendors_available": vendorList
            },
            status=status.HTTP_200_OK
        )


class DeliveryRequestView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):
        vendorSelected = get_object_or_404(User, username=request.data["vendor"])

        try:
            existing = get_object_or_404(DeliveryRequest, user=request.user, vendor=vendorSelected)
            return Response(
                {
                    "message": "Already Registered request",
                    "request_id": existing.id
                },
                status=status.HTTP_200_OK
            )
        except Http404:
            items = request.data["items"]
            d = DeliveryRequest.objects.create(
                user=request.user,
                vendor=vendorSelected,
                details=items
            )
            return Response(
                {
                    "message": "Your request is registered",
                    "request_id": d.id
                },
                status=status.HTTP_201_CREATED
            )


class CheckupRequestView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):
        print(request.data)
        try:
            exist = get_object_or_404(CheckupRequest, user=request.user)
            res = {
                "message": "Appointment already set",
                "date": str(exist.date),
                "time": str(exist.time)
            }
        except Http404:
            CheckupRequest.objects.create(
                user=request.user,
                date=request.data["date"],
                time=request.data["time"]
            )
            res = {
                "message": "Succesful",
                "date": request.data["data"],
                "time": request.data["time"]
            }
        return Response(
            res,
            status=status.HTTP_200_OK
        )


class GetStateDataView(APIView):

    permission_classes = [IsAuthenticated]

    def post(self, request):
        stateSelected = request.data["state"].lower()
        casesDict = getStateCaseCount(stateSelected)

        return Response(
            casesDict,
            status=status.HTTP_200_OK
        )

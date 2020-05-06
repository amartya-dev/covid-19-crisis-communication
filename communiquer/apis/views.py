from apis.serializers import ProfileSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser


class UserProfileCreateView(APIView):
    permission_classes = [IsAdminUser]

    def post(self, request):
        serializer = ProfileSerializer(data=request.POST)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            serializer.error_messages, status=status.HTTP_400_BAD_REQUEST
        )

from rest_framework.generics import ListAPIView
from .models import Food
from .serializers import FoodSerializer
from rest_framework.permissions import AllowAny

class FoodListView(ListAPIView):
    queryset = Food.objects.all()
    serializer_class = FoodSerializer
    permission_classes = [AllowAny]

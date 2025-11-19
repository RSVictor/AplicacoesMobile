from rest_framework.generics import CreateAPIView
from .models import Order
from .serializers import OrderSerializer

class CreateOrderView(CreateAPIView):
    queryset = Order
    serializer_class = OrderSerializer

from django.db import models
from users.models import User
from food.models import Food

class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    items = models.ManyToManyField(Food)
    total = models.DecimalField(max_digits=6, decimal_places=2)
    address = models.CharField(max_length=200)

    created_at = models.DateTimeField(auto_now_add=True)

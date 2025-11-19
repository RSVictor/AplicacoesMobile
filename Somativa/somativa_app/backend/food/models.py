from django.db import models

class Food(models.Model):
    CATEGORY_CHOICES = [
        ('lanche', 'Lanche'),
        ('pizza', 'Pizza'),
    ]

    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=6, decimal_places=2)
    category = models.CharField(max_length=20, choices=CATEGORY_CHOICES)

    def __str__(self):
        return self.name

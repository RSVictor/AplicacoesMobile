from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import get_user_model, authenticate

User = get_user_model()

class RegisterView(APIView):
    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')

        if not email or not password:
            return Response({"error": "Email e senha são obrigatórios."},
                            status=status.HTTP_400_BAD_REQUEST)

        if User.objects.filter(email=email).exists():
            return Response({"error": "Email já cadastrado."},
                            status=status.HTTP_400_BAD_REQUEST)

        # Criação do usuário
        user = User.objects.create_user(
            username=email.split('@')[0],  # username opcional
            email=email,
            password=password
        )

        return Response({"message": "Cadastro realizado com sucesso!"}, status=status.HTTP_201_CREATED)

class LoginView(APIView):
    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')

        if not email or not password:
            return Response({"error": "Email e senha são obrigatórios."}, status=status.HTTP_400_BAD_REQUEST)

        # Usando o authenticate corretamente
        user = authenticate(request, username=email, password=password)
        if user is not None:
            # Aqui você pode gerar token ou apenas retornar sucesso
            return Response({"message": "Login realizado com sucesso!"}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "Email ou senha incorretos."}, status=status.HTTP_401_UNAUTHORIZED)

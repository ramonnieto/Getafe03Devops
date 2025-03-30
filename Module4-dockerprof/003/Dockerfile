# Usar Alpine como imagen base
FROM alpine:latest

# Instalar dependencias básicas
RUN apk add --no-cache python3 py3-pip bash

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos necesarios
COPY requirements.txt .
COPY app.py .

# Crear un entorno virtual y activarlo
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instalar dependencias de Python dentro del entorno virtual
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto 5000
EXPOSE 5000

# Comando para iniciar la aplicación
CMD ["python", "app.py"]

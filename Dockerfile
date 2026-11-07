# 1. Imagen base oficial de Python 3.12, version liviana
FROM python:3.12-slim

# 2. Carpeta de trabajo dentro del contenedor
WORKDIR /app

# 3. Primero solo requirements.txt: si el codigo cambia pero las dependencias
#    no, Docker reutiliza esta capa (CACHED) y no vuelve a instalar nada.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Solo las carpetas que necesita la app
COPY app/ app/
COPY frontend/ frontend/
COPY models/ models/

# 5. Puerto en el que escucha uvicorn (documentacion; se publica con -p)
EXPOSE 8000

# 6. Arranque. 0.0.0.0 para aceptar conexiones desde fuera del contenedor.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
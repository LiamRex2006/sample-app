#!/bin/bash

# Paso 1: Crear directorios temporales
mkdir -p tempdir/templates tempdir/static

# Paso 2: Copiar archivos del sitio web y el script Python al directorio temporal
cp sample_app.py tempdir/
cp -r templates/* tempdir/templates/
cp -r static/* tempdir/static/

# Paso 3: Crear el archivo Dockerfile
echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/sample_app.py" >> tempdir/Dockerfile

# Paso 4: Construir el contenedor Docker
cd tempdir
docker build -t sampleapp .

# Paso 5: Ejecutar el contenedor Docker
docker run -t -d -p 5050:5050 --name samplerunning sampleapp

# Paso 6: Verificar que el contenedor está corriendo
docker ps -a


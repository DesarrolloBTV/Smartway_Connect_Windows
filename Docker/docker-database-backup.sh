#!/bin/bash

# Comprobar si se han proporcionado los argumentos necesarios
if [ $# -ne 5 ]; then
    echo "Uso: $0 <nombre_del_contenedor> <usuario_mysql> <contraseña_mysql> <nombre_de_la_base_de_datos> <ruta_de_salida>"
    exit 1
fi

CONTAINER_NAME=$1
MYSQL_USER=$2
MYSQL_PASSWORD=$3
DB_NAME=$4
OUTPUT_PATH=$5

# Crear la ruta de salida si no existe
mkdir -p "$OUTPUT_PATH"

# Realizar el dump de la base de datos
docker exec ${CONTAINER_NAME} mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${DB_NAME} > "${OUTPUT_PATH}/${DB_NAME}_$(date +%Y%m%d_%H%M%S).sql"

if [ $? -eq 0 ]; then
    echo "Dump realizado correctamente. Archivo generado en ${OUTPUT_PATH}/${DB_NAME}_$(date +%Y%m%d_%H%M%S).sql"
else
    echo "Error al realizar el dump de la base de datos"
fi


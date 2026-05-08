# 🛰️ Telemetry, Tracking and Control System

Este proyecto es un **Dashboard de Monitoreo de Telemetría** desarrollado como Trabajo Práctico para la materia de Computación. El sistema permite visualizar en tiempo real los valores promedio de distintos sensores distribuidos en estaciones geográficas, utilizando una interfaz profesional inspirada en centros de control aeroespaciales (estilo EUMETSAT).

## 🚀 Características
- **Visualización de Datos:** Gráficos dinámicos mediante Chart.js para análisis de telemetría.
- **Diseño Profesional:** Interfaz limpia y técnica construida con Bootstrap 5 y FontAwesome.
- **Base de Datos Relacional:** Gestión integral de estaciones, sensores y mediciones.
- **Cálculo Automático:** Procesamiento de promedios "al vuelo" mediante consultas SQL optimizadas.

## 🛠️ Tecnologías Utilizadas
- **Backend:** PHP 8.x
- **Base de Datos:** MySQL / MariaDB
- **Frontend:** HTML5, CSS3 (Custom Styles), Bootstrap 5
- **Gráficos:** Chart.js
- **Iconografía:** FontAwesome 6

## 📋 Estructura de la Base de Datos
El sistema se basa en un modelo lógico de tres entidades principales:
1.  **Estaciones:** Registro de ubicación geográfica (Lat/Long) y nombre.
2.  **Sensores:** Tipos de dispositivos (Temperatura, Humedad, Presión, etc.) vinculados a estaciones.
3.  **Mediciones:** Registro histórico de valores con marca de tiempo (Fecha/Hora).

## 🔧 Instalación y Configuración

1.  **Clonar o descargar** los archivos en la carpeta `htdocs` de tu servidor local (XAMPP/WAMP).
2.  **Importar la base de datos:**
    - Abrir HeidiSQL o phpMyAdmin.
    - Crear una base de datos llamada `SistemaMonitoreo`.
    - Ejecutar el archivo `.sql` incluido en este repositorio para crear las tablas y cargar los datos de prueba.
3.  **Configurar la conexión:**
    - Revisar el archivo `conexion.php` y ajustar las credenciales de acceso (host, usuario, contraseña) según tu entorno local.
4.  **Ejecutar:**
    - Iniciar los módulos Apache y MySQL en XAMPP.
    - Acceder desde el navegador a `localhost/nombre-de-tu-carpeta/index.php`.

---
*Desarrollado para el Trabajo Práctico de Computación - 2024*
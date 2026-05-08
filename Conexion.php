<?php
$host = "localhost";
$user = "root"; // Usuario por defecto de XAMPP
$pass = "";     // Contraseña por defecto (vacía)
$db   = "SistemaMonitoreo"; // El nombre que le pusimos a la base

$conexion = mysqli_connect($host, $user, $pass, $db);

if (!$conexion) {
    die("Error al conectar: " . mysqli_connect_error());
}
?>
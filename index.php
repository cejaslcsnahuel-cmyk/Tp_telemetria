<?php include 'conexion.php'; ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Telemetry & Control System | EUMETSAT Style</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body { 
            background-color: #f4f7f9; 
            font-family: 'Roboto', sans-serif; 
            color: #33475b;
        }
        /* Navbar institucional */
        .navbar { background-color: #004b7a; border-bottom: 4px solid #00d4ff; }
        .navbar-brand { font-weight: 700; color: white !important; letter-spacing: 1px; }
        
        /* Sección Hero */
        .hero-section {
            background: linear-gradient(rgba(0, 75, 122, 0.8), rgba(0, 75, 122, 0.8)), 
                        url('https://www.eumetsat.int/sites/default/files/styles/hero_image/public/2020-06/telemetry_tracking_control_hero.jpg'); /* Imagen de backup */
            background-size: cover;
            background-position: center;
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
        }

        /* Tarjetas de Datos */
        .card {
            border: none;
            border-radius: 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .card:hover { transform: translateY(-5px); }
        .card-header { 
            background-color: white; 
            border-bottom: 2px solid #f0f2f5; 
            font-weight: 700; 
            color: #004b7a;
            text-transform: uppercase;
            font-size: 0.85rem;
        }
        
        .stat-icon { font-size: 2rem; color: #00d4ff; margin-bottom: 15px; }
        
        .table thead { background-color: #004b7a; color: white; }
        .text-primary-eum { color: #004b7a; }
        .btn-eum { background-color: #00d4ff; color: #004b7a; font-weight: 700; border: none; border-radius: 0; }
        .btn-eum:hover { background-color: #00b8e6; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fa-solid fa-satellite-dish me-2"></i> TELEMETRY SYSTEM</a>
    </div>
</nav>

<section class="hero-section text-center">
    <div class="container">
        <h1 class="display-4 fw-bold">Telemetry, Tracking and Control</h1>
        <p class="lead">Monitoring infrastructure for environmental data and station status</p>
        <button class="btn btn-eum px-4 py-2 mt-3">SISTEMA OPERATIVO</button>
    </div>
</section>

<div class="container">
    <div class="row text-center mb-5">
        <div class="col-md-4">
            <div class="card p-4">
                <i class="fa-solid fa-tower-broadcast stat-icon"></i>
                <h6>ESTACIONES</h6>
                <?php $r = mysqli_query($conexion, "SELECT COUNT(*) as t FROM estacion"); $d = mysqli_fetch_assoc($r); ?>
                <h2 class="fw-bold"><?php echo $d['t']; ?></h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-4">
                <i class="fa-solid fa-microchip stat-icon"></i>
                <h6>SENSORES ACTIVOS</h6>
                <?php $r = mysqli_query($conexion, "SELECT COUNT(*) as t FROM sensor"); $d = mysqli_fetch_assoc($r); ?>
                <h2 class="fw-bold"><?php echo $d['t']; ?></h2>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-4">
                <i class="fa-solid fa-database stat-icon"></i>
                <h6>REGISTROS TOTALES</h6>
                <?php $r = mysqli_query($conexion, "SELECT COUNT(*) as t FROM medicion"); $d = mysqli_fetch_assoc($r); ?>
                <h2 class="fw-bold"><?php echo $d['t']; ?></h2>
            </div>
        </div>
    </div>

    <div class="row mb-5">
        <div class="col-lg-8">
            <div class="card h-100">
                <div class="card-header">Data Visualization | Averages</div>
                <div class="card-body">
                    <canvas id="telemetryChart"></canvas>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header">Mission Status</div>
                <div class="card-body">
                    <p class="small text-muted">Current status of the ground segment and telemetry processing units.</p>
                    <div class="d-flex align-items-center mb-3">
                        <div class="spinner-grow text-success spinner-grow-sm me-2"></div>
                        <span>Ground Station Link: <strong>Stable</strong></span>
                    </div>
                    <hr>
                    <p class="small fw-bold mb-1">Last Update:</p>
                    <p class="small"><?php echo date('d M Y - H:i:s'); ?> UTC</p>
                </div>
            </div>
        </div>
    </div>

    <div class="card mb-5">
        <div class="card-header">Detailed Telemetry Report</div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped mb-0">
                    <thead>
                        <tr>
                            <th>Location</th>
                            <th>Subsystem</th>
                            <th>Avg. Value</th>
                            <th>Unit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $sql = "SELECT e.nombre, s.tipo, s.unidad, AVG(m.valor) as promedio 
                                FROM estacion e
                                JOIN sensor s ON e.id_estacion = s.id_estacion
                                JOIN medicion m ON s.id_sensor = m.id_sensor
                                GROUP BY e.id_estacion, s.id_sensor";
                        $res = mysqli_query($conexion, $sql);
                        $labels = []; $data = [];

                        while ($f = mysqli_fetch_assoc($res)) {
                            $labels[] = $f['nombre'] . " - " . $f['tipo'];
                            $data[] = $f['promedio'];
                            echo "<tr>
                                    <td class='fw-bold text-primary-eum'>{$f['nombre']}</td>
                                    <td><span class='badge bg-light text-dark border'>{$f['tipo']}</span></td>
                                    <td>" . number_format($f['promedio'], 2) . "</td>
                                    <td class='text-muted'>{$f['unidad']}</td>
                                  </tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white text-center py-4">
    <p class="small mb-0">© <?php echo date('Y'); ?> Telemetry Control Center | Developed for Technical Assignment</p>
</footer>

<script>
    const ctx = document.getElementById('telemetryChart');
    new Chart(ctx, {
        type: 'line', // Cambiamos a línea para un look más "telemetría"
        data: {
            labels: <?php echo json_encode($labels); ?>,
            datasets: [{
                label: 'Mean Telemetry Value',
                data: <?php echo json_encode($data); ?>,
                backgroundColor: 'rgba(0, 75, 122, 0.1)',
                borderColor: '#00d4ff',
                borderWidth: 3,
                pointBackgroundColor: '#004b7a',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: {
                y: { grid: { color: '#f0f2f5' } },
                x: { grid: { display: false } }
            }
        }
    });
</script>

</body>
</html>
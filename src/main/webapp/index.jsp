<!doctype html>
<html lang="en">
<head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Dashboard — Java 21 WAR</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
                body { background:#f8f9fa; }
                .card-metric { min-height:100px }
                .chart-card { height:360px }
                .small-muted { font-size:0.85rem; color:#6c757d }
        </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Sample WAR Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav" aria-controls="nav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="nav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="hello">Hello Servlet</a></li>
            </ul>
        </div>
    </div>
</nav>

<main class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h1 class="h3 mb-0">Overview</h1>
            <div class="small-muted">Quick status of the application</div>
        </div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="card shadow-sm card-metric">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-0">Users</h5>
                            <div class="fs-4 fw-bold">1,248</div>
                            <div class="small-muted">Active this week</div>
                        </div>
                        <div class="text-primary">
                            <svg width="36" height="36" fill="currentColor" class="bi bi-people" viewBox="0 0 16 16"><path d="M13 7c0 1-1 1-1 1H4s-1 0-1-1 1-3 5-3 5 2 5 3z"/><path fill-rule="evenodd" d="M5.216 14A2.238 2.238 0 0 1 3 12V9.5C3 8.12 4.12 7 5.5 7h5C12.88 7 14 8.12 14 9.5V12c0 .927-.67 1.708-1.58 1.966C10.9 14.548 8.523 15 8 15s-2.9-.452-4.42-.034z"/></svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card shadow-sm card-metric">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-0">Requests</h5>
                            <div class="fs-4 fw-bold">8,423</div>
                            <div class="small-muted">This month</div>
                        </div>
                        <div class="text-success">
                            <svg width="36" height="36" fill="currentColor" class="bi bi-graph-up" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M0 0h1v15h15v1H0V0z"/><path d="M10 2l3 4 2-3v8H0V9l6-3 4 3 0-7z"/></svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card shadow-sm card-metric">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-0">Errors</h5>
                            <div class="fs-4 fw-bold text-danger">12</div>
                            <div class="small-muted">Last 24h</div>
                        </div>
                        <div class="text-danger">
                            <svg width="36" height="36" fill="currentColor" class="bi bi-exclamation-triangle" viewBox="0 0 16 16"><path d="M7.938 2.016a.13.13 0 0 1 .125 0l6.857 3.94c.12.07.12.24 0 .31L8.063 10.206a.13.13 0 0 1-.125 0L1.082 6.267a.18.18 0 0 1 0-.31L7.94 2.016z"/></svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="card shadow-sm card-metric">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-0">Uptime</h5>
                            <div class="fs-4 fw-bold">99.97%</div>
                            <div class="small-muted">Last 30 days</div>
                        </div>
                        <div class="text-warning">
                            <svg width="36" height="36" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16"><path d="M8 3.5a.5.5 0 0 1 .5.5v4l2.5 1.5a.5.5 0 0 1-.5.866L8 9V4a.5.5 0 0 1 .5-.5z"/></svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-8">
            <div class="card shadow-sm chart-card">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Traffic (last 7 days)</h5>
                    <canvas id="trafficChart" class="flex-fill"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card shadow-sm chart-card">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Platform Share</h5>
                    <canvas id="platformChart" class="flex-fill"></canvas>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3 mt-3">
        <div class="col-12">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Recent Requests</h5>
                    <div class="table-responsive">
                        <table class="table table-sm table-hover">
                            <thead>
                                <tr><th>Time</th><th>Path</th><th>Status</th><th>Duration</th></tr>
                            </thead>
                            <tbody>
                                <tr><td>10:12</td><td>/hello</td><td><span class="badge bg-success">200</span></td><td>34ms</td></tr>
                                <tr><td>09:58</td><td>/api/data</td><td><span class="badge bg-danger">500</span></td><td>120ms</td></tr>
                                <tr><td>09:45</td><td>/login</td><td><span class="badge bg-success">302</span></td><td>22ms</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</main>

<footer class="text-center small text-muted py-3">
    Built with Java 21 • Sample WAR • Visual demo
</footer>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const trafficCtx = document.getElementById('trafficChart');
    new Chart(trafficCtx, {
        type: 'line',
        data: {
            labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
            datasets: [{
                label: 'Requests',
                data: [1200, 1500, 1700, 1300, 1800, 2200, 2000],
                borderColor: 'rgb(13,110,253)',
                backgroundColor: 'rgba(13,110,253,0.08)',
                tension: 0.25,
                pointRadius: 3
            }]
        },
        options: { responsive:true, maintainAspectRatio:false }
    });

    const platformCtx = document.getElementById('platformChart');
    new Chart(platformCtx, {
        type: 'doughnut',
        data: {
            labels: ['Web','Mobile','API'],
            datasets: [{ data: [62, 25, 13], backgroundColor: ['#0d6efd','#198754','#ffc107'] }]
        },
        options: { responsive:true, maintainAspectRatio:false }
    });
</script>

</body>
</html>

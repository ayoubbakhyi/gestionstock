<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alertes — Gestion de Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand fs-4" href="dashboard">Gestion de Stock</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#alertsNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="alertsNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="dashboard">Tableau de bord</a></li>
                <li class="nav-item"><a class="nav-link" href="products">Produits</a></li>
                <li class="nav-item"><a class="nav-link" href="categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link active" href="alerts">Alertes</a></li>
                <li class="nav-item"><a class="nav-link" href="logs">Logs</a></li>
            </ul>
            <a href="logout" class="btn btn-outline-danger btn-sm fw-semibold">Deconnexion</a>
        </div>
    </div>
</nav>

<main class="container py-4 py-lg-5 fade-in">
    <div class="card fade-in delay-1">
        <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h1 class="h4 mb-1 fw-bold text-primary">Alertes stock</h1>
                    <p class="text-body-secondary mb-0">Produits avec un stock inferieur a 5.</p>
                </div>
                <span class="badge bg-danger-subtle text-danger border border-danger-subtle fs-6 px-3 py-2">Seuil critique</span>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th class="text-secondary fw-semibold">#</th>
                        <th class="text-secondary fw-semibold">Nom</th>
                        <th class="text-secondary fw-semibold">Categorie</th>
                        <th class="text-secondary fw-semibold">Quantite</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty lowStock}">
                            <tr><td colspan="4" class="text-center text-success py-4">Aucune alerte, tous les stocks sont suffisants.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${lowStock}">
                                <tr>
                                    <td>${p.id}</td>
                                    <td>${p.name}</td>
                                    <td>${empty p.categoryName ? '—' : p.categoryName}</td>
                                    <td><span class="badge text-bg-danger">${p.quantity}</span></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

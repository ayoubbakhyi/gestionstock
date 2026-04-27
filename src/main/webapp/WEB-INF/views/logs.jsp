<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Logs — Gestion de Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand fs-4" href="dashboard">Gestion de Stock</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#logsNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="logsNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="dashboard">Tableau de bord</a></li>
                <li class="nav-item"><a class="nav-link" href="products">Produits</a></li>
                <li class="nav-item"><a class="nav-link" href="categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link" href="alerts">Alertes</a></li>
                <li class="nav-item"><a class="nav-link active" href="logs">Logs</a></li>
            </ul>
            <a href="logout" class="btn btn-outline-danger btn-sm fw-semibold">Deconnexion</a>
        </div>
    </div>
</nav>

<main class="container py-4 py-lg-5 fade-in">
    <div class="card fade-in delay-1">
        <div class="card-body p-4">
            <div class="mb-4">
                <h1 class="h4 mb-1 fw-bold text-primary">Historique des actions</h1>
                <p class="text-body-secondary mb-0">Suivi des operations effectuees dans l'application.</p>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th class="text-secondary fw-semibold">#</th>
                        <th class="text-secondary fw-semibold">Date / Heure</th>
                        <th class="text-secondary fw-semibold">Utilisateur</th>
                        <th class="text-secondary fw-semibold">Action</th>
                        <th class="text-secondary fw-semibold">URL</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty logs}">
                            <tr><td colspan="5" class="text-center text-body-secondary py-4">Aucune action enregistree.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="log" items="${logs}">
                                <tr>
                                    <td>${log.id}</td>
                                    <td>${log.createdAt}</td>
                                    <td>${log.username}</td>
                                    <td>${log.action}</td>
                                    <td><code>${log.url}</code></td>
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

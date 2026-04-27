<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tableau de bord — Gestion de Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand fs-4" href="dashboard">Gestion de Stock</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" href="dashboard">Tableau de bord</a></li>
                <li class="nav-item"><a class="nav-link" href="products">Produits</a></li>
                <li class="nav-item"><a class="nav-link" href="categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link" href="alerts">Alertes</a></li>
                <li class="nav-item"><a class="nav-link" href="logs">Logs</a></li>
            </ul>
            <div class="d-flex align-items-center gap-3">
                <span class="small text-secondary fw-medium">Utilisateurs actifs : <strong class="text-primary">${applicationScope.activeUsers}</strong></span>
                <a href="logout" class="btn btn-outline-danger btn-sm fw-semibold">Deconnexion</a>
            </div>
        </div>
    </div>
</nav>

<main class="container py-4 py-lg-5 fade-in">
    <div class="row g-4 mb-4">
        <div class="col-md-6 fade-in delay-1">
            <div class="card h-100 hover-elevate">
                <div class="card-body d-flex flex-column justify-content-center align-items-center py-5">
                    <p class="text-secondary fw-bold text-uppercase tracking-wider mb-2">Produits</p>
                    <div class="display-3 fw-bold gradient-text">${productCount}</div>
                </div>
            </div>
        </div>
        <div class="col-md-6 fade-in delay-2">
            <div class="card h-100 hover-elevate">
                <div class="card-body d-flex flex-column justify-content-center align-items-center py-5">
                    <p class="text-secondary fw-bold text-uppercase tracking-wider mb-2">Categories</p>
                    <div class="display-3 fw-bold gradient-text">${categoryCount}</div>
                </div>
            </div>
        </div>
    </div>

    <div class="card fade-in delay-3">
        <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="h5 mb-0 fw-bold text-primary">10 derniers produits ajoutes</h2>
                <a href="products" class="btn btn-primary btn-sm px-3">Voir tous les produits</a>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th class="text-secondary fw-semibold">#</th>
                        <th class="text-secondary fw-semibold">Nom</th>
                        <th class="text-secondary fw-semibold">Categorie</th>
                        <th class="text-secondary fw-semibold">Quantite</th>
                        <th class="text-secondary fw-semibold">Prix</th>
                        <th class="text-secondary fw-semibold">Ajoute le</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty latestProducts}">
                            <tr><td colspan="6" class="text-center text-body-secondary py-5">Aucun produit pour l'instant.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${latestProducts}">
                                <tr>
                                    <td class="fw-medium">${p.id}</td>
                                    <td class="fw-semibold text-dark">${p.name}</td>
                                    <td>
                                        <span class="badge bg-light text-dark border">${empty p.categoryName ? '—' : p.categoryName}</span>
                                    </td>
                                    <td>
                                        <span class="badge ${p.quantity > 10 ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'}">${p.quantity}</span>
                                    </td>
                                    <td class="fw-semibold">${p.price} €</td>
                                    <td class="text-secondary small">${p.createdAt}</td>
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

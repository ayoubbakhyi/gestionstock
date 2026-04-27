<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Categories — Gestion de Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand fs-4" href="dashboard">Gestion de Stock</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#categoriesNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="categoriesNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="dashboard">Tableau de bord</a></li>
                <li class="nav-item"><a class="nav-link" href="products">Produits</a></li>
                <li class="nav-item"><a class="nav-link active" href="categories">Categories</a></li>
                <li class="nav-item"><a class="nav-link" href="alerts">Alertes</a></li>
                <li class="nav-item"><a class="nav-link" href="logs">Logs</a></li>
            </ul>
            <a href="logout" class="btn btn-outline-danger btn-sm fw-semibold">Deconnexion</a>
        </div>
    </div>
</nav>

<main class="container py-4 py-lg-5 fade-in">
    <div class="card fade-in delay-1">
        <div class="card-body p-4">
            <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3 mb-4">
                <div>
                    <h1 class="h4 mb-1 fw-bold text-primary">Categories</h1>
                    <p class="text-body-secondary mb-0">Organisez le catalogue par famille de produits.</p>
                </div>
                <div class="d-flex flex-column flex-sm-row gap-2 w-100 w-lg-auto">
                    <form method="get" action="categories" class="d-flex gap-2 flex-grow-1">
                        <input type="text" name="q" value="${q}" class="form-control" placeholder="Rechercher une categorie…">
                        <button type="submit" class="btn btn-outline-primary">Rechercher</button>
                    </form>
                    <div class="d-flex gap-2">
                        <c:if test="${not empty q}">
                            <a href="categories" class="btn btn-outline-secondary">Effacer</a>
                        </c:if>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">Ajouter</button>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Nom</th>
                        <th class="text-end">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty categories}">
                            <tr><td colspan="3" class="text-center text-body-secondary py-4">Aucune categorie trouvee.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cat" items="${categories}">
                                <tr>
                                    <td>${cat.id}</td>
                                    <td>${cat.name}</td>
                                    <td>
                                        <div class="d-flex justify-content-end gap-2">
                                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                                data-id="${cat.id}"
                                                data-name="<c:out value='${cat.name}'/>"
                                                onclick="openEditFromButton(this)">
                                                Modifier
                                            </button>
                                            <form method="post" action="categories" onsubmit="return confirm('Supprimer ?')">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${cat.id}">
                                                <button type="submit" class="btn btn-outline-danger btn-sm">Supprimer</button>
                                            </form>
                                        </div>
                                    </td>
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

<div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="categories">
                <div class="modal-header">
                    <h2 class="modal-title fs-5">Ajouter une categorie</h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <label class="form-label" for="addCategoryName">Nom</label>
                    <input id="addCategoryName" type="text" name="name" class="form-control" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Ajouter</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="categories">
                <div class="modal-header">
                    <h2 class="modal-title fs-5">Modifier la categorie</h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" id="editId">
                    <label class="form-label" for="editName">Nom</label>
                    <input type="text" name="name" id="editName" class="form-control" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Enregistrer</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openEditFromButton(button) {
        document.getElementById('editId').value = button.dataset.id;
        document.getElementById('editName').value = button.dataset.name;
        bootstrap.Modal.getOrCreateInstance(document.getElementById('editModal')).show();
    }
</script>
</body>
</html>

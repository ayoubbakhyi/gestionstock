<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Produits — Gestion de Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light sticky-top">
    <div class="container">
        <a class="navbar-brand fs-4" href="dashboard">Gestion de Stock</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#productsNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="productsNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="dashboard">Tableau de bord</a></li>
                <li class="nav-item"><a class="nav-link active" href="products">Produits</a></li>
                <li class="nav-item"><a class="nav-link" href="categories">Categories</a></li>
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
                    <h1 class="h4 mb-1 fw-bold text-primary">Produits</h1>
                    <p class="text-body-secondary mb-0">Consultez, ajoutez et mettez a jour le stock.</p>
                </div>
                <div class="d-flex flex-column flex-sm-row gap-2 w-100 w-lg-auto">
                    <form method="get" action="products" class="d-flex gap-2 flex-grow-1">
                        <input type="text" name="q" value="${q}" class="form-control" placeholder="Rechercher un produit…">
                        <button type="submit" class="btn btn-outline-primary">Rechercher</button>
                    </form>
                    <div class="d-flex gap-2">
                        <c:if test="${not empty q}">
                            <a href="products" class="btn btn-outline-secondary">Effacer</a>
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
                        <th>Categorie</th>
                        <th>Quantite</th>
                        <th>Prix</th>
                        <th class="text-end">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty products}">
                            <tr><td colspan="6" class="text-center text-body-secondary py-4">Aucun produit trouve.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td>${p.id}</td>
                                    <td>${p.name}</td>
                                    <td>${empty p.categoryName ? '—' : p.categoryName}</td>
                                    <td>${p.quantity}</td>
                                    <td>${p.price} €</td>
                                    <td>
                                        <div class="d-flex justify-content-end gap-2">
                                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                                data-id="${p.id}"
                                                data-name="<c:out value='${p.name}'/>"
                                                data-quantity="${p.quantity}"
                                                data-price="${p.price}"
                                                data-category-id="${p.categoryId}"
                                                onclick="openEditFromButton(this)">
                                                Modifier
                                            </button>
                                            <form method="post" action="products" onsubmit="return confirm('Supprimer ?')">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${p.id}">
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
            <form method="post" action="products">
                <div class="modal-header">
                    <h2 class="modal-title fs-5">Ajouter un produit</h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label class="form-label" for="addProductName">Nom</label>
                        <input id="addProductName" type="text" name="name" class="form-control" required>
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <label class="form-label" for="addProductQuantity">Quantite</label>
                            <input id="addProductQuantity" type="number" name="quantity" class="form-control" value="0" min="0" required>
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label" for="addProductPrice">Prix (€)</label>
                            <input id="addProductPrice" type="number" name="price" class="form-control" value="0" step="0.01" min="0" required>
                        </div>
                    </div>
                    <div class="mt-3">
                        <label class="form-label" for="addProductCategory">Categorie</label>
                        <select id="addProductCategory" name="categoryId" class="form-select">
                            <option value="0">— Aucune —</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
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
            <form method="post" action="products">
                <div class="modal-header">
                    <h2 class="modal-title fs-5">Modifier le produit</h2>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" id="editId">
                    <div class="mb-3">
                        <label class="form-label" for="editName">Nom</label>
                        <input type="text" name="name" id="editName" class="form-control" required>
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-6">
                            <label class="form-label" for="editQuantity">Quantite</label>
                            <input type="number" name="quantity" id="editQuantity" class="form-control" min="0" required>
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label" for="editPrice">Prix (€)</label>
                            <input type="number" name="price" id="editPrice" class="form-control" step="0.01" min="0" required>
                        </div>
                    </div>
                    <div class="mt-3">
                        <label class="form-label" for="editCategory">Categorie</label>
                        <select name="categoryId" id="editCategory" class="form-select">
                            <option value="0">— Aucune —</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
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
        document.getElementById('editQuantity').value = button.dataset.quantity;
        document.getElementById('editPrice').value = button.dataset.price;
        document.getElementById('editCategory').value = button.dataset.categoryId;
        bootstrap.Modal.getOrCreateInstance(document.getElementById('editModal')).show();
    }
</script>
</body>
</html>

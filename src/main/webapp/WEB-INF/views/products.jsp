<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Produits — Gestion de Stock</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: sans-serif; background: #f0f2f5; }

        header {
            background: #4f46e5; color: white;
            padding: 1rem 2rem;
            display: flex; justify-content: space-between; align-items: center;
        }
        header a { color: white; text-decoration: none; font-size: .9rem; opacity: .85; }
        header a:hover { opacity: 1; }

        main { padding: 2rem; max-width: 1100px; margin: 0 auto; }

        .toolbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; gap: 1rem; }
        .toolbar form { display: flex; gap: .5rem; }
        input[type=text], input[type=number], select {
            padding: .55rem .75rem; border: 1px solid #ccc; border-radius: 4px; font-size: .9rem;
        }
        button, .btn {
            padding: .55rem 1rem; border: none; border-radius: 4px;
            font-size: .9rem; cursor: pointer;
        }
        .btn-primary { background: #4f46e5; color: white; }
        .btn-primary:hover { background: #4338ca; }
        .btn-danger { background: #ef4444; color: white; }
        .btn-danger:hover { background: #dc2626; }
        .btn-secondary { background: #e5e7eb; color: #333; }
        .btn-secondary:hover { background: #d1d5db; }

        table { width: 100%; border-collapse: collapse; background: white;
                border-radius: 8px; overflow: hidden;
                box-shadow: 0 2px 8px rgba(0,0,0,.08); }
        th { background: #4f46e5; color: white; padding: .75rem 1rem; text-align: left; font-size: .85rem; }
        td { padding: .75rem 1rem; font-size: .9rem; border-bottom: 1px solid #f0f0f0; }
        tr:last-child td { border-bottom: none; }
        .empty { text-align: center; color: #aaa; padding: 2rem; }

        /* Modal */
        .modal-bg { display: none; position: fixed; inset: 0; background: rgba(0,0,0,.4); justify-content: center; align-items: center; z-index: 10; }
        .modal-bg.open { display: flex; }
        .modal { background: white; border-radius: 8px; padding: 1.5rem; width: 400px; }
        .modal h3 { margin-bottom: 1rem; }
        .modal label { display: block; margin: .75rem 0 .25rem; font-size: .85rem; color: #555; }
        .modal input, .modal select { width: 100%; }
        .modal-footer { display: flex; justify-content: flex-end; gap: .5rem; margin-top: 1.25rem; }
    </style>
</head>
<body>

<header>
    <span><strong>Gestion de Stock</strong> — Produits</span>
    <div style="display:flex;gap:1.5rem">
        <a href="dashboard">← Tableau de bord</a>
        <a href="logout">Déconnexion</a>
    </div>
</header>

<main>
    <div class="toolbar">
        <!-- Search -->
        <form method="get" action="products">
            <input type="text" name="q" value="${q}" placeholder="Rechercher un produit…" style="width:220px" />
            <button type="submit" class="btn-primary">Rechercher</button>
            <c:if test="${not empty q}">
                <a href="products" class="btn btn-secondary">Effacer</a>
            </c:if>
        </form>
        <!-- Add button -->
        <button class="btn btn-primary" onclick="openAdd()">+ Ajouter</button>
    </div>

    <table>
        <thead>
            <tr>
                <th>#</th><th>Nom</th><th>Catégorie</th><th>Quantité</th><th>Prix</th><th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty products}">
                    <tr><td colspan="6" class="empty">Aucun produit trouvé.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.name}</td>
                            <td>${empty p.categoryName ? '—' : p.categoryName}</td>
                            <td>${p.quantity}</td>
                            <td>${p.price} €</td>
                            <td style="display:flex;gap:.5rem">
                                <button class="btn btn-secondary"
                                    onclick="openEdit(${p.id},'${p.name}',${p.quantity},${p.price},${p.categoryId})">
                                    Modifier
                                </button>
                                <form method="post" action="products" onsubmit="return confirm('Supprimer ?')">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="id" value="${p.id}"/>
                                    <button type="submit" class="btn btn-danger">Supprimer</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</main>

<!-- Add Modal -->
<div id="addModal" class="modal-bg">
    <div class="modal">
        <h3>Ajouter un produit</h3>
        <form method="post" action="products">
            <input type="hidden" name="action" value="add"/>
            <label>Nom</label>
            <input type="text" name="name" required/>
            <label>Quantité</label>
            <input type="number" name="quantity" value="0" min="0" required/>
            <label>Prix (€)</label>
            <input type="number" name="price" value="0" step="0.01" min="0" required/>
            <label>Catégorie</label>
            <select name="categoryId">
                <option value="0">— Aucune —</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
            </select>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModals()">Annuler</button>
                <button type="submit" class="btn btn-primary">Ajouter</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Modal -->
<div id="editModal" class="modal-bg">
    <div class="modal">
        <h3>Modifier le produit</h3>
        <form method="post" action="products">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="id" id="editId"/>
            <label>Nom</label>
            <input type="text" name="name" id="editName" required/>
            <label>Quantité</label>
            <input type="number" name="quantity" id="editQuantity" min="0" required/>
            <label>Prix (€)</label>
            <input type="number" name="price" id="editPrice" step="0.01" min="0" required/>
            <label>Catégorie</label>
            <select name="categoryId" id="editCategory">
                <option value="0">— Aucune —</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
            </select>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModals()">Annuler</button>
                <button type="submit" class="btn btn-primary">Enregistrer</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openAdd() { document.getElementById('addModal').classList.add('open'); }
    function openEdit(id, name, qty, price, catId) {
        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editQuantity').value = qty;
        document.getElementById('editPrice').value = price;
        document.getElementById('editCategory').value = catId;
        document.getElementById('editModal').classList.add('open');
    }
    function closeModals() {
        document.querySelectorAll('.modal-bg').forEach(m => m.classList.remove('open'));
    }
</script>
</body>
</html>

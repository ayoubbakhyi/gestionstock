<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de bord — Gestion de Stock</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: sans-serif; background: #f0f2f5; }

        header {
            background: #4f46e5; color: white;
            padding: 1rem 2rem;
            display: flex; justify-content: space-between; align-items: center;
        }
        header h1 { font-size: 1.2rem; }
        header span { font-size: .9rem; opacity: .85; }

        main { padding: 2rem; max-width: 1100px; margin: 0 auto; }

        .cards { display: flex; gap: 1.5rem; margin-bottom: 2rem; }
        .card {
            background: white; border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,.08);
            padding: 1.5rem; flex: 1; text-align: center;
        }
        .card .label { font-size: .85rem; color: #888; margin-bottom: .5rem; }
        .card .value { font-size: 2.5rem; font-weight: 700; color: #4f46e5; }

        h2 { margin-bottom: 1rem; font-size: 1.1rem; color: #333; }
        table { width: 100%; border-collapse: collapse; background: white;
                border-radius: 8px; overflow: hidden;
                box-shadow: 0 2px 8px rgba(0,0,0,.08); }
        th { background: #4f46e5; color: white; padding: .75rem 1rem; text-align: left; font-size: .85rem; }
        td { padding: .75rem 1rem; font-size: .9rem; border-bottom: 1px solid #f0f0f0; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #fafafa; }
        .empty { text-align: center; color: #aaa; padding: 2rem; }
    </style>
</head>
<body>

<header>
    <h1>Gestion de Stock</h1>
    <nav style="display:flex;gap:1.5rem;align-items:center">
        <a href="products" style="color:white;text-decoration:none;font-size:.9rem">Produits</a>
        <a href="categories" style="color:white;text-decoration:none;font-size:.9rem">Catégories</a>
        <a href="alerts" style="color:white;text-decoration:none;font-size:.9rem">Alertes</a>
        <a href="logs" style="color:white;text-decoration:none;font-size:.9rem">Logs</a>
        <span style="font-size:.85rem;opacity:.75">Utilisateurs actifs : <strong>${applicationScope.activeUsers}</strong></span>
        <a href="logout" style="color:white;text-decoration:none;font-size:.9rem;opacity:.85">Déconnexion</a>
    </nav>
</header>

<main>
    <div class="cards">
        <div class="card">
            <div class="label">Produits</div>
            <div class="value">${productCount}</div>
        </div>
        <div class="card">
            <div class="label">Catégories</div>
            <div class="value">${categoryCount}</div>
        </div>
    </div>

    <h2>10 derniers produits ajoutés</h2>
    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Nom</th>
                <th>Catégorie</th>
                <th>Quantité</th>
                <th>Prix</th>
                <th>Ajouté le</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty latestProducts}">
                    <tr><td colspan="6" class="empty">Aucun produit pour l'instant.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${latestProducts}">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.name}</td>
                            <td>${empty p.categoryName ? '—' : p.categoryName}</td>
                            <td>${p.quantity}</td>
                            <td>${p.price} €</td>
                            <td>${p.createdAt}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</main>

</body>
</html>

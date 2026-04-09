<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Alertes — Gestion de Stock</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: sans-serif; background: #f0f2f5; }
        header {
            background: #4f46e5; color: white;
            padding: 1rem 2rem;
            display: flex; justify-content: space-between; align-items: center;
        }
        header div { display: flex; gap: 1.5rem; }
        header a { color: white; text-decoration: none; font-size: .9rem; opacity: .85; }
        header a:hover { opacity: 1; }
        main { padding: 2rem; max-width: 800px; margin: 0 auto; }
        h2 { margin-bottom: 1.25rem; font-size: 1.1rem; color: #333; }
        table { width: 100%; border-collapse: collapse; background: white;
                border-radius: 8px; overflow: hidden;
                box-shadow: 0 2px 8px rgba(0,0,0,.08); }
        th { background: #ef4444; color: white; padding: .75rem 1rem; text-align: left; font-size: .85rem; }
        td { padding: .75rem 1rem; font-size: .9rem; border-bottom: 1px solid #f0f0f0; }
        tr:last-child td { border-bottom: none; }
        .qty { color: #ef4444; font-weight: 700; }
        .empty { text-align: center; color: #16a34a; padding: 2rem; font-weight: 500; }
    </style>
</head>
<body>

<header>
    <span><strong>Gestion de Stock</strong> — Alertes stock</span>
    <div>
        <a href="dashboard">← Tableau de bord</a>
        <a href="logout">Déconnexion</a>
    </div>
</header>

<main>
    <h2>Produits avec stock inférieur à 5</h2>
    <table>
        <thead>
            <tr><th>#</th><th>Nom</th><th>Catégorie</th><th>Quantité</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty lowStock}">
                    <tr><td colspan="4" class="empty">Aucune alerte — tous les stocks sont suffisants.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${lowStock}">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.name}</td>
                            <td>${empty p.categoryName ? '—' : p.categoryName}</td>
                            <td class="qty">${p.quantity}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</main>

</body>
</html>

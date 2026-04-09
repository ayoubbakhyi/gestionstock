<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Logs — Gestion de Stock</title>
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
        main { padding: 2rem; max-width: 1000px; margin: 0 auto; }
        h2 { margin-bottom: 1.25rem; font-size: 1.1rem; color: #333; }
        table { width: 100%; border-collapse: collapse; background: white;
                border-radius: 8px; overflow: hidden;
                box-shadow: 0 2px 8px rgba(0,0,0,.08); }
        th { background: #4f46e5; color: white; padding: .75rem 1rem; text-align: left; font-size: .85rem; }
        td { padding: .75rem 1rem; font-size: .85rem; border-bottom: 1px solid #f0f0f0; color: #444; }
        tr:last-child td { border-bottom: none; }
        .empty { text-align: center; color: #aaa; padding: 2rem; }
    </style>
</head>
<body>

<header>
    <span><strong>Gestion de Stock</strong> — Logs</span>
    <div>
        <a href="dashboard">← Tableau de bord</a>
        <a href="logout">Déconnexion</a>
    </div>
</header>

<main>
    <h2>Historique des actions</h2>
    <table>
        <thead>
            <tr><th>#</th><th>Date / Heure</th><th>Utilisateur</th><th>Action</th><th>URL</th></tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty logs}">
                    <tr><td colspan="5" class="empty">Aucune action enregistrée.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="log" items="${logs}">
                        <tr>
                            <td>${log.id}</td>
                            <td>${log.createdAt}</td>
                            <td>${log.username}</td>
                            <td>${log.action}</td>
                            <td>${log.url}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</main>

</body>
</html>

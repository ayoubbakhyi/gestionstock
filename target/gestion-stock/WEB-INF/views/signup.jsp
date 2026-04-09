<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription — Gestion de Stock</title>
    <style>
        body { font-family: sans-serif; display: flex; justify-content: center; padding-top: 80px; background: #f0f2f5; }
        .card { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,.1); width: 360px; }
        h2 { margin-top: 0; }
        label { display: block; margin: 1rem 0 .3rem; font-size: .9rem; color: #555; }
        input { width: 100%; padding: .6rem; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 1rem; }
        button { margin-top: 1.5rem; width: 100%; padding: .75rem; background: #4f46e5; color: white; border: none; border-radius: 4px; font-size: 1rem; cursor: pointer; }
        button:hover { background: #4338ca; }
        .error { color: red; margin-top: .5rem; font-size: .9rem; }
    </style>
</head>
<body>
<div class="card">
    <h2>Créer un compte</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form method="post" action="signup">
        <label>Nom</label>
        <input type="text" name="name" placeholder="Votre nom" />

        <label>Email</label>
        <input type="email" name="email" placeholder="email@exemple.com" />

        <label>Mot de passe</label>
        <input type="password" name="password" placeholder="••••••••" />

        <button type="submit">S'inscrire</button>
    </form>
</div>
</body>
</html>

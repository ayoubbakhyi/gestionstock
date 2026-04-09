<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription réussie</title>
    <style>
        body { font-family: sans-serif; display: flex; justify-content: center; padding-top: 80px; background: #f0f2f5; }
        .card { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,.1); width: 360px; text-align: center; }
        h2 { color: #16a34a; }
        a { display: inline-block; margin-top: 1rem; color: #4f46e5; }
    </style>
</head>
<body>
<div class="card">
    <h2>Inscription réussie !</h2>
    <p>Bienvenue, <strong>${name}</strong>. Votre compte a été créé.</p>
    <a href="login">Se connecter</a>
</div>
</body>
</html>

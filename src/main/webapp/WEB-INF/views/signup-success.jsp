<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inscription reussie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-bg">
<div class="auth-content fade-in">
    <div class="container min-vh-100 d-flex align-items-center justify-content-center py-5">
        <div class="card glass-card border-0 text-center w-100" style="max-width: 420px;">
            <div class="card-body p-4 p-md-5">
                <div class="display-6 text-success mb-3 fade-in delay-1">&#10003;</div>
                <h1 class="h3 mb-3 fw-bold fade-in delay-1">Inscription reussie</h1>
                <p class="text-body-secondary mb-4 fade-in delay-2">Bienvenue, <strong class="text-primary">${name}</strong>. Votre compte a ete cree.</p>
                <a href="login" class="btn btn-primary px-4 py-2 fade-in delay-3">Se connecter</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>

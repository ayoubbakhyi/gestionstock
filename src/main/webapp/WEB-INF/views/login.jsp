<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Connexion — Gestion de Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-bg">
<div class="auth-content fade-in">
    <div class="container min-vh-100 d-flex align-items-center justify-content-center py-5">
        <div class="card glass-card border-0 w-100" style="max-width: 420px;">
            <div class="card-body p-4 p-md-5">
                <div class="text-center mb-4">
                    <h1 class="h3 mb-1 fw-bold text-primary">Connexion</h1>
                    <p class="text-body-secondary mb-0">Accedez a votre espace de gestion.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">${error}</div>
                </c:if>

                <form method="post" action="login" class="vstack gap-3">
                    <div>
                        <label for="email" class="form-label text-secondary fw-semibold">Email</label>
                        <input id="email" type="email" name="email" class="form-control" placeholder="email@exemple.com" required>
                    </div>

                    <div>
                        <label for="password" class="form-label text-secondary fw-semibold">Mot de passe</label>
                        <input id="password" type="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mt-2 py-2">Se connecter</button>
                </form>

                <p class="text-center text-body-secondary mt-4 mb-0">
                    Pas encore de compte ? <a href="signup" class="text-decoration-none fw-semibold">S'inscrire</a>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>

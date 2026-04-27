<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inscription — Gestion de Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-bg">
<div class="auth-content fade-in">
    <div class="container min-vh-100 d-flex align-items-center justify-content-center py-5">
        <div class="card glass-card border-0 w-100" style="max-width: 460px;">
            <div class="card-body p-4 p-md-5">
                <div class="text-center mb-4">
                    <h1 class="h3 mb-1 fw-bold text-primary">Creer un compte</h1>
                    <p class="text-body-secondary mb-0">Initialisez votre acces a l'application.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">${error}</div>
                </c:if>

                <form method="post" action="signup" class="vstack gap-3">
                    <div>
                        <label for="name" class="form-label text-secondary fw-semibold">Nom</label>
                        <input id="name" type="text" name="name" class="form-control" placeholder="Votre nom" required>
                    </div>

                    <div>
                        <label for="signupEmail" class="form-label text-secondary fw-semibold">Email</label>
                        <input id="signupEmail" type="email" name="email" class="form-control" placeholder="email@exemple.com" required>
                    </div>

                    <div>
                        <label for="signupPassword" class="form-label text-secondary fw-semibold">Mot de passe</label>
                        <input id="signupPassword" type="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mt-2 py-2">S'inscrire</button>
                </form>

                <p class="text-center text-body-secondary mt-4 mb-0">
                    Deja inscrit ? <a href="login" class="text-decoration-none fw-semibold">Se connecter</a>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>

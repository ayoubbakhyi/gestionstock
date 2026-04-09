# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Gestion de Stock** — A Java EE inventory management web application built with Maven, Jakarta EE (Servlets + JSP), and deployed on a Jakarta-compatible server (e.g., Tomcat 10+).

## Functional Requirements

The application must implement all of the following:

1. **MVC pattern** — strict separation between Presentation (JSP), Business (Service), and Data Access (DAO) layers.
2. **CRUD operations** — Create, Read, Update, Delete on all main entities via JDBC.
3. **Keyword search** — search functionality via a text input field on listing pages.
4. **Authentication** — HTTP session-based login; all protected pages must be inaccessible without an active session.
5. **Logger Filter** — a `jakarta.servlet.Filter` that logs every request to a log file with: timestamp, username, action performed, requested URL.
6. **Active user count** — use an `HttpSessionListener` to track and display the number of currently active sessions.
7. **User management module** — add, delete, and change password for application users.
8. **CSS framework** — use a CSS framework (e.g., Bootstrap) for the UI.

**Mandatory technologies:** Servlets, JSP with JSTL and EL, Maven.

## Build & Run Commands

```bash
# Compile and package as WAR
mvn clean package

# Run tests
mvn test

# Run a single test class
mvn test -Dtest=NomDeLaClasseTest

# Skip tests during build
mvn clean package -DskipTests

# Deploy to embedded Tomcat (if tomcat7/tomcat10 plugin configured)
mvn tomcat10:run
```

Deploy the generated `target/gestion-stock.war` to a Tomcat 10+ server (required for `jakarta.*` namespace).

## Architecture

This is a classic MVC web application using the Servlet + JSP pattern:

- **Controllers** (`src/main/java/.../servlet/`) — named `*Controller` (extend `HttpServlet`): handle HTTP requests, call service/DAO layer, forward to JSP views.
- **JSP** (`src/main/webapp/WEB-INF/views/`) — act as Views: render HTML using data set as request attributes by Servlets.
- **Service layer** (`src/main/java/.../service/`) — business logic, called by Servlets.
- **DAO layer** (`src/main/java/.../dao/`) — database access using JDBC, called by Services.
- **Model/Entity classes** (`src/main/java/.../model/`) — POJOs representing domain objects (Produit, Categorie, Fournisseur, Stock, etc.).
- **Filters** (`src/main/java/.../filter/`) — cross-cutting concerns such as authentication checks.

### Request flow

```
Browser → Servlet (Controller) → Service → DAO → Database
                ↓
           JSP (View) ← request attributes set by Servlet
```

### Key configuration files

- `pom.xml` — Maven dependencies and build config (Jakarta EE API, JSTL, JDBC driver, WAR packaging).
- `src/main/webapp/WEB-INF/web.xml` — Servlet mappings and filter declarations.
- `src/main/resources/db.properties` or context params in `web.xml` — database connection config.

## Jakarta EE Conventions

- Use `jakarta.*` imports (not `javax.*`) — this project targets Jakarta EE 9+.
- Servlet URL mappings are defined via `@WebServlet` annotations or `web.xml`.
- JSTL tags use `<%@ taglib uri="jakarta.tags.core" prefix="c" %>`.
- JSPs should be placed under `WEB-INF/views/` so they are not directly accessible by URL.

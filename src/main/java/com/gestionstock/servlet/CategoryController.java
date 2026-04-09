package com.gestionstock.servlet;

import com.gestionstock.dao.CategoryDAO;
import com.gestionstock.dao.LogDAO;
import com.gestionstock.model.Category;
import com.gestionstock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/categories")
public class CategoryController extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final LogDAO logDAO = new LogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String keyword = request.getParameter("q");
            if (keyword != null && !keyword.isBlank()) {
                request.setAttribute("categories", categoryDAO.search(keyword));
                request.setAttribute("q", keyword);
            } else {
                request.setAttribute("categories", categoryDAO.findAll());
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String username = ((User) request.getSession().getAttribute("loggedUser")).getName();
        String url = request.getRequestURI();
        try {
            switch (action) {
                case "add" -> {
                    Category c = new Category(request.getParameter("name"));
                    categoryDAO.insert(c);
                    logDAO.insert(username, "Ajout catégorie : " + c.getName(), url);
                }
                case "edit" -> {
                    Category c = new Category(request.getParameter("name"));
                    c.setId(Integer.parseInt(request.getParameter("id")));
                    categoryDAO.update(c);
                    logDAO.insert(username, "Modification catégorie : " + c.getName(), url);
                }
                case "delete" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    categoryDAO.delete(id);
                    logDAO.insert(username, "Suppression catégorie ID : " + id, url);
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/categories");
    }
}

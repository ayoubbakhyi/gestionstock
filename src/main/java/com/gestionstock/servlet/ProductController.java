package com.gestionstock.servlet;

import com.gestionstock.dao.CategoryDAO;
import com.gestionstock.dao.LogDAO;
import com.gestionstock.dao.ProductDAO;
import com.gestionstock.model.Product;
import com.gestionstock.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/products")
public class ProductController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final LogDAO logDAO = new LogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String keyword = request.getParameter("q");
            if (keyword != null && !keyword.isBlank()) {
                request.setAttribute("products", productDAO.search(keyword));
                request.setAttribute("q", keyword);
            } else {
                request.setAttribute("products", productDAO.findAll());
            }
            request.setAttribute("categories", categoryDAO.findAll());
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(request, response);
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
                    Product p = new Product();
                    p.setName(request.getParameter("name"));
                    p.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                    p.setPrice(Double.parseDouble(request.getParameter("price")));
                    p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                    productDAO.insert(p);
                    logDAO.insert(username, "Ajout produit : " + p.getName(), url);
                }
                case "edit" -> {
                    Product p = new Product();
                    p.setId(Integer.parseInt(request.getParameter("id")));
                    p.setName(request.getParameter("name"));
                    p.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                    p.setPrice(Double.parseDouble(request.getParameter("price")));
                    p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                    productDAO.update(p);
                    logDAO.insert(username, "Modification produit : " + p.getName(), url);
                }
                case "delete" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    productDAO.delete(id);
                    logDAO.insert(username, "Suppression produit ID : " + id, url);
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/products");
    }
}

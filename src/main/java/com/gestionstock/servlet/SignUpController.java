package com.gestionstock.servlet;

import com.gestionstock.dao.UserDAO;
import com.gestionstock.model.User;
import com.gestionstock.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpController extends HttpServlet {

    @Override
    public void init() {
        DBConnection.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = new User(
            request.getParameter("name"),
            request.getParameter("email"),
            request.getParameter("password")
        );

        try {
            new UserDAO().insert(user);
            request.setAttribute("name", user.getName());
            request.getRequestDispatcher("/WEB-INF/views/signup-success.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/signup.jsp").forward(request, response);
        }
    }
}

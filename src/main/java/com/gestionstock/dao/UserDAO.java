package com.gestionstock.dao;

import com.gestionstock.model.User;
import com.gestionstock.util.DBConnection;
import com.gestionstock.util.PasswordUtils;

import java.sql.*;

public class UserDAO {

    public void insert(User user) throws SQLException {
        if (existsByEmail(user.getEmail())) {
            throw new SQLException("Un compte existe deja pour cet email.");
        }

        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, normalizeEmail(user.getEmail()));
            ps.setString(3, PasswordUtils.hash(user.getPassword()));
            ps.executeUpdate();
        }
    }

    public User findByEmailAndPassword(String email, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizeEmail(email));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (PasswordUtils.verify(password, storedPassword)) {
                    return mapUser(rs);
                }

                if (!PasswordUtils.isHashed(storedPassword) && storedPassword.equals(password)) {
                    upgradePassword(rs.getInt("id"), password);
                    return mapUser(rs);
                }
            }
        }
        return null;
    }

    private boolean existsByEmail(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizeEmail(email));
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    private void upgradePassword(int userId, String rawPassword) throws SQLException {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, PasswordUtils.hash(rawPassword));
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User(rs.getString("name"), rs.getString("email"), rs.getString("password"));
        user.setId(rs.getInt("id"));
        return user;
    }

    private String normalizeEmail(String email) {
        return email == null ? null : email.trim().toLowerCase();
    }
}

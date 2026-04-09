package com.gestionstock.dao;

import com.gestionstock.model.Category;
import com.gestionstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public int count() throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM categories")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public List<Category> findAll() throws SQLException {
        List<Category> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM categories ORDER BY name")) {
            while (rs.next()) {
                Category c = new Category(rs.getString("name"));
                c.setId(rs.getInt("id"));
                list.add(c);
            }
        }
        return list;
    }

    public List<Category> search(String keyword) throws SQLException {
        List<Category> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM categories WHERE name LIKE ? ORDER BY name")) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getString("name"));
                c.setId(rs.getInt("id"));
                list.add(c);
            }
        }
        return list;
    }

    public void insert(Category c) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO categories (name) VALUES (?)")) {
            ps.setString(1, c.getName());
            ps.executeUpdate();
        }
    }

    public void update(Category c) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE categories SET name=? WHERE id=?")) {
            ps.setString(1, c.getName());
            ps.setInt(2, c.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM categories WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}

package com.gestionstock.dao;

import com.gestionstock.model.Product;
import com.gestionstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Product fromRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setQuantity(rs.getInt("quantity"));
        p.setPrice(rs.getDouble("price"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setCategoryName(rs.getString("category_name"));
        p.setCreatedAt(rs.getString("created_at"));
        return p;
    }

    private static final String SELECT_BASE = """
        SELECT p.id, p.name, p.quantity, p.price, p.category_id, p.created_at,
               c.name AS category_name
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.id
    """;

    public int count() throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM products")) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public List<Product> findAll() throws SQLException {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SELECT_BASE + " ORDER BY p.id DESC")) {
            while (rs.next()) list.add(fromRow(rs));
        }
        return list;
    }

    public List<Product> search(String keyword) throws SQLException {
        String sql = SELECT_BASE + " WHERE p.name LIKE ? ORDER BY p.id DESC";
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(fromRow(rs));
        }
        return list;
    }

    public List<Product> findLatest(int limit) throws SQLException {
        String sql = SELECT_BASE + " ORDER BY p.id DESC LIMIT ?";
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(fromRow(rs));
        }
        return list;
    }

    public void insert(Product p) throws SQLException {
        String sql = "INSERT INTO products (name, quantity, price, category_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, p.getQuantity());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getCategoryId());
            ps.executeUpdate();
        }
    }

    public void update(Product p) throws SQLException {
        String sql = "UPDATE products SET name=?, quantity=?, price=?, category_id=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setInt(2, p.getQuantity());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getCategoryId());
            ps.setInt(5, p.getId());
            ps.executeUpdate();
        }
    }

    public List<Product> findLowStock(int threshold) throws SQLException {
        String sql = SELECT_BASE + " WHERE p.quantity < ? ORDER BY p.quantity ASC";
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, threshold);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(fromRow(rs));
        }
        return list;
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}

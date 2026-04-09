package com.gestionstock.dao;

import com.gestionstock.model.Log;
import com.gestionstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LogDAO {

    public void insert(String username, String action, String url) {
        String sql = "INSERT INTO logs (username, action, url) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, action);
            ps.setString(3, url);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Log> findAll() throws SQLException {
        List<Log> list = new ArrayList<>();
        String sql = "SELECT * FROM logs ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Log log = new Log();
                log.setId(rs.getInt("id"));
                log.setUsername(rs.getString("username"));
                log.setAction(rs.getString("action"));
                log.setUrl(rs.getString("url"));
                log.setCreatedAt(rs.getString("created_at"));
                list.add(log);
            }
        }
        return list;
    }
}

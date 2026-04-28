package com.gestionstock.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import org.sqlite.SQLiteDataSource;

public class DBConnection {

    private static final String DB_PATH = "/home/ayoub/Documents/project-school/gestion-stock.db";
    private static final String URL = "jdbc:sqlite:" + DB_PATH;

    public static Connection getConnection() throws SQLException {
        SQLiteDataSource ds = new SQLiteDataSource();
        ds.setUrl(URL);
        return ds.getConnection();
    }

    public static void init() {
        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS users (
                    id       INTEGER PRIMARY KEY AUTOINCREMENT,
                    name     TEXT NOT NULL,
                    email    TEXT NOT NULL,
                    password TEXT NOT NULL
                )
            """);
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS categories (
                    id   INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL
                )
            """);
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS products (
                    id          INTEGER PRIMARY KEY AUTOINCREMENT,
                    name        TEXT NOT NULL,
                    quantity    INTEGER NOT NULL DEFAULT 0,
                    price       REAL NOT NULL DEFAULT 0,
                    category_id INTEGER REFERENCES categories(id),
                    created_at  TEXT DEFAULT (datetime('now'))
                )
            """);
            stmt.execute("""
                CREATE TABLE IF NOT EXISTS logs (
                    id         INTEGER PRIMARY KEY AUTOINCREMENT,
                    username   TEXT NOT NULL,
                    action     TEXT NOT NULL,
                    url        TEXT NOT NULL,
                    created_at TEXT DEFAULT (datetime('now'))
                )
            """);
            stmt.execute("CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)");
        } catch (SQLException e) {
            throw new RuntimeException("DB init failed", e);
        }
    }
}

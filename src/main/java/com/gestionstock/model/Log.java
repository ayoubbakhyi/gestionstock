package com.gestionstock.model;

public class Log {
    private int id;
    private String username;
    private String action;
    private String url;
    private String createdAt;

    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getAction() { return action; }
    public String getUrl() { return url; }
    public String getCreatedAt() { return createdAt; }

    public void setId(int id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setAction(String action) { this.action = action; }
    public void setUrl(String url) { this.url = url; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}

package com.gestionstock.listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class SessionCounterListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        int count = getCount(event) + 1;
        event.getSession().getServletContext().setAttribute("activeUsers", count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        int count = Math.max(0, getCount(event) - 1);
        event.getSession().getServletContext().setAttribute("activeUsers", count);
    }

    private int getCount(HttpSessionEvent event) {
        Object val = event.getSession().getServletContext().getAttribute("activeUsers");
        return val == null ? 0 : (int) val;
    }
}

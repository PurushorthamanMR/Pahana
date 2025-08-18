/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.models;

/**
 *
 * @author pruso
 */
public class HelpSection {
    private int helpId;
    private String title;
    private String content;
    private UserRole role;
    private String createdAt;
    private String updatedAt;
    
    public HelpSection() {}
    
    public HelpSection(int helpId, String title, String content) {
        this.helpId = helpId;
        this.title = title;
        this.content = content;
    }
    
    public HelpSection(int helpId, String title, String content, UserRole role) {
        this.helpId = helpId;
        this.title = title;
        this.content = content;
        this.role = role;
    }
    
    public int getHelpId() {
        return helpId;
    }
    
    public void setHelpId(int helpId) {
        this.helpId = helpId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public UserRole getRole() {
        return role;
    }
    
    public void setRole(UserRole role) {
        this.role = role;
    }
    
    public String getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "HelpSection{" + "helpId=" + helpId + ", title=" + title + ", role=" + role + '}';
    }
} 
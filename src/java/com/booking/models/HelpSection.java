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
    
    public HelpSection() {}
    
    public HelpSection(int helpId, String title, String content) {
        this.helpId = helpId;
        this.title = title;
        this.content = content;
    }
    
    // Getters and Setters
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
    
    @Override
    public String toString() {
        return "HelpSection{" + "helpId=" + helpId + ", title=" + title + '}';
    }
} 
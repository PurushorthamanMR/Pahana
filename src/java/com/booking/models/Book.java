/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.models;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author pruso
 */
public class Book {
    private int bookId;
    private String title;
    private String description;
    private BigDecimal pricePerUnit;
    private int stockQuantity;
    private BookCategory category;
    private User createdBy;
    private Timestamp createdAt;
    
    public Book() {}
    
    public Book(int bookId, String title, String description, BigDecimal pricePerUnit, int stockQuantity, BookCategory category) {
        this.bookId = bookId;
        this.title = title;
        this.description = description;
        this.pricePerUnit = pricePerUnit;
        this.stockQuantity = stockQuantity;
        this.category = category;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public BigDecimal getPricePerUnit() {
        return pricePerUnit;
    }
    
    public void setPricePerUnit(BigDecimal pricePerUnit) {
        this.pricePerUnit = pricePerUnit;
    }
    
    public int getStockQuantity() {
        return stockQuantity;
    }
    
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    public BookCategory getCategory() {
        return category;
    }
    
    public void setCategory(BookCategory category) {
        this.category = category;
    }
    
    public User getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Book{" + "bookId=" + bookId + ", title=" + title + ", pricePerUnit=" + pricePerUnit + ", stockQuantity=" + stockQuantity + ", category=" + category + '}';
    }
} 
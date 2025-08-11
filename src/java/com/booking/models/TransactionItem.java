/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.models;

import java.math.BigDecimal;
/**
 *
 * @author pruso
 */
public class TransactionItem {
    private int transactionItemId;
    private Transaction transaction;
    private Book book;
    private int quantity;
    private BigDecimal price;
    
    public TransactionItem() {}
    
    public TransactionItem(int transactionItemId, Transaction transaction, Book book, int quantity, BigDecimal price) {
        this.transactionItemId = transactionItemId;
        this.transaction = transaction;
        this.book = book;
        this.quantity = quantity;
        this.price = price;
    }
    
    // Getters and Setters
    public int getTransactionItemId() {
        return transactionItemId;
    }
    
    public void setTransactionItemId(int transactionItemId) {
        this.transactionItemId = transactionItemId;
    }
    
    public Transaction getTransaction() {
        return transaction;
    }
    
    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }
    
    public Book getBook() {
        return book;
    }
    
    public void setBook(Book book) {
        this.book = book;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    @Override
    public String toString() {
        return "TransactionItem{" + "transactionItemId=" + transactionItemId + ", book=" + book + ", quantity=" + quantity + ", price=" + price + '}';
    }
} 
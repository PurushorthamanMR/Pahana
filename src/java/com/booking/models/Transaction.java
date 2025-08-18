/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.models;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author pruso
 */
public class Transaction {
    private int transactionId;
    private Customer customer;
    private BigDecimal totalAmount;
    private User createdBy;
    private Timestamp createdAt;
    private List<TransactionItem> items;
    
    public Transaction() {}
    
    public Transaction(int transactionId, Customer customer, BigDecimal totalAmount) {
        this.transactionId = transactionId;
        this.customer = customer;
        this.totalAmount = totalAmount;
    }
    
    public int getTransactionId() {
        return transactionId;
    }
    
    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }
    
    public Customer getCustomer() {
        return customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
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
    
    public List<TransactionItem> getItems() {
        return items;
    }
    
    public void setItems(List<TransactionItem> items) {
        this.items = items;
    }
    
    @Override
    public String toString() {
        return "Transaction{" + "transactionId=" + transactionId + ", customer=" + customer + ", totalAmount=" + totalAmount + '}';
    }
} 
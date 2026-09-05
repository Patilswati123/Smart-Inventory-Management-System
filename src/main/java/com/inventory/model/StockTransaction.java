package com.inventory.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * StockTransaction Model - Represents a stock-in or stock-out transaction record
 */
public class StockTransaction implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int productId;
    private String productCode;
    private String productName;
    private String transactionType; // 'IN' or 'OUT'
    private int quantity;
    private String remarks;
    private Timestamp transactionDate;

    public StockTransaction() {
    }

    public StockTransaction(int productId, String transactionType, int quantity, String remarks) {
        this.productId = productId;
        this.transactionType = transactionType;
        this.quantity = quantity;
        this.remarks = remarks;
    }

    public StockTransaction(int id, int productId, String productCode, String productName, String transactionType,
            int quantity, String remarks, Timestamp transactionDate) {
        this.id = id;
        this.productId = productId;
        this.productCode = productCode;
        this.productName = productName;
        this.transactionType = transactionType;
        this.quantity = quantity;
        this.remarks = remarks;
        this.transactionDate = transactionDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Timestamp getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Timestamp transactionDate) {
        this.transactionDate = transactionDate;
    }

    public boolean isStockIn() {
        return "IN".equalsIgnoreCase(this.transactionType);
    }

    @Override
    public String toString() {
        return "StockTransaction [id=" + id + ", productId=" + productId + ", transactionType=" + transactionType
                + ", quantity=" + quantity + ", transactionDate=" + transactionDate + "]";
    }
}

package com.inventory.model;

import java.io.Serializable;

/**
 * Product Model - Represents an inventory product item
 */
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String code;
    private String name;
    private String category;
    private double price;
    private int quantity;
    private int minStockLevel;

    public Product() {
    }

    public Product(String code, String name, String category, double price, int quantity, int minStockLevel) {
        this.code = code;
        this.name = name;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
        this.minStockLevel = minStockLevel;
    }

    public Product(int id, String code, String name, String category, double price, int quantity, int minStockLevel) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
        this.minStockLevel = minStockLevel;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getMinStockLevel() {
        return minStockLevel;
    }

    public void setMinStockLevel(int minStockLevel) {
        this.minStockLevel = minStockLevel;
    }

    /**
     * Checks whether this product has low stock based on minimum threshold.
     */
    public boolean isLowStock() {
        return this.quantity <= this.minStockLevel;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", code=" + code + ", name=" + name + ", category=" + category + ", price="
                + price + ", quantity=" + quantity + ", minStockLevel=" + minStockLevel + "]";
    }
}

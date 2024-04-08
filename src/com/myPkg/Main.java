package com.myPkg;

import java.util.Scanner;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Main {
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/grocery_management";
    static final String USER = "root";
    static final String PASS = "password";

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();

            Scanner scanner = new Scanner(System.in);

            while (true) {
                System.out.println("\n***** Grocery Management System *****");
                System.out.println("1. Add Product");
                System.out.println("2. Add Category");
                System.out.println("3. Assign Product to Category");
                System.out.println("4. Add Supplier");
                System.out.println("5. Place Order");
                System.out.println("6. Display All Products");
                System.out.println("7. Display All Categories");
                System.out.println("8. Display All Products with Categories");
                System.out.println("9. Display Products in a Category");
                System.out.println("10. Display All Suppliers");
                System.out.println("11. Display Orders by Supplier");
                System.out.println("12. Exit");
                System.out.print("Enter your choice: ");

                int choice = scanner.nextInt();
                scanner.nextLine(); // Consume newline

                switch (choice) {
                    case 1:
                        addProduct(conn, scanner);
                        break;
                    case 2:
                        addCategory(conn, scanner);
                        break;
                    case 3:
                        assignProductToCategory(conn, scanner);
                        break;
                    case 4:
                        addSupplier(conn, scanner);
                        break;
                    case 5:
                        placeOrder(conn, scanner);
                        break;
                    case 6:
                        displayAllProducts(conn);
                        break;
                    case 7:
                        displayAllCategories(conn);
                        break;
                    case 8:
                    	displayProductsWithCategories(conn);
                    	break;
                    case 9:
                        System.out.print("Enter category ID: ");
                        int categoryId = scanner.nextInt();
                        displayProductsInCategory(conn, categoryId);
                        break;
                    case 10:
                        displayAllSuppliers(conn);
                        break;
                    case 11:
                        System.out.print("Enter supplier ID: ");
                        int supplierId = scanner.nextInt();
                        displayOrdersBySupplier(conn, supplierId);
                        break;
                    case 12:
                        System.out.println("Exiting...");
                        return;
                    default:
                        System.out.println("Invalid choice! Please enter a valid option.");
                }
            }

        } catch (SQLException | ClassNotFoundException se) {
            se.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

    static void addProduct(Connection conn, Scanner scanner) throws SQLException {
        System.out.print("Enter name of the product: ");
        String name = scanner.nextLine();
        System.out.print("Enter price: ");
        double price = scanner.nextDouble();
        
        String sql = "INSERT INTO products (name, price) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setDouble(2, price);
        pstmt.executeUpdate();
        System.out.println("Product added successfully.");
    }

    static void addCategory(Connection conn, Scanner scanner) throws SQLException {
        System.out.print("Enter name of the category: ");
        String name = scanner.nextLine();
        
        String sql = "INSERT INTO categories (name) VALUES (?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.executeUpdate();
        System.out.println("Category added successfully.");
    }

    static void assignProductToCategory(Connection conn, Scanner scanner) throws SQLException {
        System.out.print("Enter product ID: ");
        int productId = scanner.nextInt();
        System.out.print("Enter category ID: ");
        int categoryId = scanner.nextInt();

        String sql = "INSERT INTO product_categories (product_id, category_id) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, productId);
        pstmt.setInt(2, categoryId);
        pstmt.executeUpdate();
        System.out.println("Product assigned to category successfully.");
    }

    static void addSupplier(Connection conn, Scanner scanner) throws SQLException {
        System.out.print("Enter name of the supplier: ");
        String name = scanner.nextLine();
        System.out.print("Enter contact details: ");
        String contact = scanner.nextLine();

        String sql = "INSERT INTO suppliers (name, contact) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, contact);
        pstmt.executeUpdate();
        System.out.println("Supplier added successfully.");
    }

    static void placeOrder(Connection conn, Scanner scanner) throws SQLException {
        System.out.print("Enter supplier ID: ");
        int supplierId = scanner.nextInt();
        System.out.print("Enter order date (YYYY-MM-DD): ");
        String orderDate = scanner.next();

        String sql = "INSERT INTO orders (supplier_id, order_date) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setInt(1, supplierId);
        pstmt.setDate(2, Date.valueOf(orderDate));
        pstmt.executeUpdate();
        
        ResultSet generatedKeys = pstmt.getGeneratedKeys();
        int orderId = -1;
        if (generatedKeys.next()) {
            orderId = generatedKeys.getInt(1);
        }

        if (orderId != -1) {
            System.out.println("Order placed successfully. Order ID: " + orderId);

            while (true) {
                System.out.print("Enter product ID (0 to finish): ");
                int productId = scanner.nextInt();
                if (productId == 0) break;
                System.out.print("Enter quantity: ");
                int quantity = scanner.nextInt();

                String orderItemSql = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement orderItemPstmt = conn.prepareStatement(orderItemSql);
                orderItemPstmt.setInt(1, orderId);
                orderItemPstmt.setInt(2, productId);
                orderItemPstmt.setInt(3, quantity);
                orderItemPstmt.executeUpdate();
                System.out.println("Product added to order.");
            }
        } else {
            System.out.println("Failed to place order.");
        }
    }

    static void displayAllProducts(Connection conn) throws SQLException {
        String sql = "SELECT * FROM products";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        System.out.println("\nAll Products:");
        System.out.printf("%-5s %-35s %-10s\n", "ID", "Name", "Price");
        System.out.println("---------------------------------------------------------");
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            double price = rs.getDouble("price");
            System.out.printf("%-5d %-35s %-10.2f\n", id, name, price);
        }

        rs.close();
        stmt.close();
    }


    static void displayAllCategories(Connection conn) throws SQLException {
        String sql = "SELECT * FROM categories";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        System.out.println("\nAll Categories:");
        System.out.printf("%-5s %-20s\n", "ID", "Name");
        System.out.println("----------------------------");
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            System.out.printf("%-5d %-20s\n", id, name);
        }

        rs.close();
        stmt.close();
    }
    
    static void displayProductsWithCategories(Connection conn) throws SQLException {
        String sql = "SELECT p.name AS product_name, c.name AS category_name " +
                     "FROM products p " +
                     "JOIN product_categories pc ON p.id = pc.product_id " +
                     "JOIN categories c ON pc.category_id = c.id";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        System.out.println("\nProducts with Categories:");
        System.out.printf("%-35s %-30s\n", "Product Name", "Category Name");
        System.out.println("--------------------------------------------------------------");
        while (rs.next()) {
            String productName = rs.getString("product_name");
            String categoryName = rs.getString("category_name");
            System.out.printf("%-35s %-30s\n", productName, categoryName);
        }

        rs.close();
        stmt.close();
    }


    static void displayProductsInCategory(Connection conn, int categoryId) throws SQLException {
        String sql = "SELECT p.* FROM products p JOIN product_categories pc ON p.id = pc.product_id WHERE pc.category_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, categoryId);
        ResultSet rs = pstmt.executeQuery();

        System.out.println("\nProducts in Category " + categoryId + ":");
        System.out.printf("%-5s %-35s %-10s\n", "ID", "Name", "Price");
        System.out.println("--------------------------------------------------------------");
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            double price = rs.getDouble("price");
            System.out.printf("%-5d %-35s %-10.2f\n", id, name, price);
        }

        rs.close();
        pstmt.close();
    }


    static void displayAllSuppliers(Connection conn) throws SQLException {
        String sql = "SELECT * FROM suppliers";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        System.out.println("\nAll Suppliers:");
        System.out.printf("%-5s %-20s %-20s\n", "ID", "Name", "Contact");
        System.out.println("---------------------------------------------------------");
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String contact = rs.getString("contact");
            System.out.printf("%-5d %-20s %-20s\n", id, name, contact);
        }

        rs.close();
        stmt.close();
    }


    static void displayOrdersBySupplier(Connection conn, int supplierId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE supplier_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, supplierId);
        ResultSet rs = pstmt.executeQuery();

        System.out.println("\nOrders by Supplier " + supplierId + ":");
        System.out.printf("%-10s %-12s %-20s\n", "Order ID", "Supplier ID", "Order Date");
        System.out.println("---------------------------------------------");
        while (rs.next()) {
            int orderId = rs.getInt("id");
            int supplierID = rs.getInt("supplier_id");
            Date orderDate = rs.getDate("order_date");
            System.out.printf("%-10d %-12d %-20s\n", orderId, supplierID, orderDate);
        }

        rs.close();
        pstmt.close();
    }

}


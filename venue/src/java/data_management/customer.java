/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data_management;

import java.util.*;
import java.sql.*;
/**
 *
 * @author ccslearner
 */
public class customer {
    //variable
    public int customer_id;
    public String first_name;
    public String last_name;
    public int mobile_no;
    public String address;
    public String birthday;
    
    public customer(){}
    
    public int register_customer(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_app?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            System.out.println("Connection Success");
            
            // get new ID
            PreparedStatement stmt = conn.prepareStatement("SELECT COALESCE(MAX(customer_id), 0) + 1 AS ID FROM customer;");
            ResultSet rslt = stmt.executeQuery();
            while(rslt.next()){
                customer_id = rslt.getInt("ID");
            }
            //insert values
            stmt = conn.prepareStatement("INSERT INTO customer (customer_id, first_name, last_name, mobile_no, address, birthday)"
                    + " VALUE(?,?,?,?,?,?)");
            stmt.setInt(1,customer_id);
            stmt.setString(2,first_name);
            stmt.setString(3,last_name);
            stmt.setInt(4, mobile_no);
            stmt.setString(5, address);
            stmt.setString(6, birthday);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            System.out.println("Hi");
            
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
        return 1;
    }
    
    public int update_customer(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_app?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            System.out.println("Connection Success");
            
            PreparedStatement stmt = conn.prepareStatement("UPDATE customer "
                    + "SET first_name = ?, last_name = ?, mobile_no = ?, address = ?, birthday = ? "
                    + "WHERE customer_id=?");
            stmt.setString(1, first_name);
            stmt.setString(2, last_name);
            stmt.setInt(3, mobile_no);
            stmt.setString(4, address);
            stmt.setString(5, birthday);
            stmt.setInt(6, customer_id);
            int x = stmt.executeUpdate();
            
            stmt.close();
            conn.close();
            
            System.out.println("Hi");
            if(x == 0){
                return 0;
            }
            
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
        return 1;
    }
    
    public int delete_customer(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_app?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            System.out.println("Connection Success");
            
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM customer WHERE customer_id = ?");
            stmt.setInt(1, customer_id);
            
            int x = stmt.executeUpdate();   
            stmt.close();
            conn.close();
            if(x == 0){
                return 0;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
        return 1;
    }
    
    public int search_customer(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_app?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            System.out.println("Connection Success");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM customer WHERE customer_id = ?");
            stmt.setInt(1, customer_id);
            
            ResultSet rs = stmt.executeQuery();   
            
            // 7. Get the results
            if(rs.next()) {
                first_name = rs.getString("first_name");
                last_name = rs.getString("last_name");
                mobile_no = rs.getInt("mobile_no");
                address = rs.getString("address");
                birthday = rs.getString("birthday");
                
                rs.close();
                stmt.close();
                conn.close();
                return 1;
            } else {
                rs.close();
                stmt.close();
                conn.close();
                return 0;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public static void main(String[] args){
    }
}
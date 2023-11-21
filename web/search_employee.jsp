<%-- 
    Document   : filteremployee
    Created on : 11 18, 23, 1:02:00 AM
    Author     : ccslearner
--%>

<%@ page import="java.util.List, data_management.employee, java.util.Date" %>
<%@ page import="java.io.*, java.sql.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search and Filter Employee Information</title>
    <link rel="stylesheet" href="style.css">
    </head>
    <body>

    <% 
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String birthdayString = request.getParameter("birthday");
        String ageString = request.getParameter("age");
        Integer age = null;

        if (ageString != null && !ageString.isEmpty()) {
            try {
                age = Integer.parseInt(ageString);
            } catch (NumberFormatException e) {
                // Handle the case where ageString is not a valid integer
                e.printStackTrace();
            }
        }

        String position = request.getParameter("position");
        String salaryString = request.getParameter("salary");
        Double salary = null;

        if (salaryString != null && !salaryString.isEmpty()) {
            try {
                salary = Double.parseDouble(salaryString);
            } catch (NumberFormatException e) {
                // Handle the case where salaryString is not a valid double
                e.printStackTrace();
            }
        }

        // You need to parse the Date from the String
        Date birthday = null;
        if (birthdayString != null && !birthdayString.isEmpty()) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            try {
                birthday = dateFormat.parse(birthdayString);
            } catch (java.text.ParseException e) {
                e.printStackTrace();
            }
        }
        
        
        Integer vendorId = null;
        String vendorIdString = request.getParameter("vendorId");

        if (vendorIdString != null && !vendorIdString.isEmpty()) {
            try {
                vendorId = Integer.parseInt(vendorIdString);
            } catch (NumberFormatException e) {
                // Handle the case where vendorIdString is not a valid integer
                e.printStackTrace();
            }
        }
        
        employee employeeInstance = new employee();

        List<employee> searchResults = employeeInstance.searchEmployees(firstName, lastName, gender, birthday, age, position, salary, vendorId);

        if (searchResults.isEmpty()) {
    %>
        <header>
            <h1>No results found.</h1>
        </header>
    <%
        } else {
    %>
         <header>
            <h1>Search Successful</h1>
        </header>   
        <table border="2">
                <tr>
                    <th>Employee ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Gender</th>
                    <th>Birthday</th>
                    <th>Age</th>
                    <th>Position</th>
                    <th>Salary</th>
                    <th>Mobile Number</th>
                    <th>Vendor ID</th>
                </tr>

                <% for (employee emp : searchResults) { %>
                    <tr>
                        <td><%= emp.employeeId %></td>
                        <td><%= emp.firstName %></td>
                        <td><%= emp.lastName %></td>
                        <td><%= emp.gender %></td>
                        <td><%= emp.birthday %></td>
                        <td><%= emp.age %></td>
                        <td><%= emp.position %></td>
                        <td><%= emp.salary %></td>
                        <td><%= emp.mobileNo %></td>
                        <td><%= emp.vendorId %></td>
                    </tr>
                <% } %>
            </table>
    <%
        }
    %>

    <form action="search_employee.html">
            <input type="submit" value="Search Again">
    </form>
    <form action="employee.html">
            <input type="submit" value="Return to Employee">
    </form>
</body>
</html>
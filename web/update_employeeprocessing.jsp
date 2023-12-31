<%-- 
    Document   : updateemployee.jsp
    Created on : 11 14, 23, 11:08:00 PM
    Author     : ccslearner
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, data_management.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Employee Information</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
        <jsp:useBean id="E" class="data_management.employee" scope="session" />

        <% 
            // Receive the values from addemployee.html
            String v_employee_id = request.getParameter("employee_id");
            String v_first_name = request.getParameter("first_name");
            String v_last_name = request.getParameter("last_name");
            String v_gender = request.getParameter("gender");
            String v_birthday = request.getParameter("birthday");
            String v_age = request.getParameter("age");
            String v_position = request.getParameter("position");
            String v_salary = request.getParameter("salary");
            String v_mobile_no = request.getParameter("mobile_no");
            String v_vendor_id = request.getParameter("vendor_id");


            try {

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date birthday = dateFormat.parse(v_birthday);

                    // Instantiate an object of the employee class
                    data_management.employee employeeObj = new data_management.employee();

                    // Set values in the JavaBean
                    employeeObj.employeeId = Integer.parseInt(v_employee_id);
                    employeeObj.firstName = v_first_name;
                    employeeObj.lastName = v_last_name;
                    employeeObj.gender = v_gender;
                    employeeObj.birthday = birthday;
                    employeeObj.age = Integer.parseInt(v_age);
                    employeeObj.position = v_position;
                    employeeObj.salary = Double.parseDouble(v_salary);
                    employeeObj.mobileNo = Integer.parseInt(v_mobile_no);
                    employeeObj.vendorId = Integer.parseInt(v_vendor_id);


                    // Call the addEmployee method
                    boolean res = employeeObj.updateEmployee();
                    if(res){
            %>
            <header>
                <h1>Update Successfully</h1>
            </header>
            <%
                    }else{
            %>
            <header>
                <h1>Update Failed</h1>
            </header>
            <%
                    }
                                
                }catch(Exception e){
            %>
            <header>
                <h1>Missing Fields</h1>
            </header>   
            <%
                }
            %>
            <form action="employee.html">
                <input type="submit" value="Return to Employee Information Menu">
            </form>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ include file="AdminHeader.jsp" %>
    <%@page import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">

.tableFixHead{
	overflow-y: auto;
}
.tableFixHead thead th {
        position: sticky;
        top: 0;
      
        color:white;
      }
    .tableFixHead   table {
        border-collapse: collapse;
        width: 80%;
      }
      
.tableFixHead th,td {
        padding: 8px 16px;
                border: 1px solid #ccc;
        
      }
</style>

</head>

<body class="backgroundimg" style="background-image:url(emptybg.jpg);">

 <%if(session.getAttribute("user")!=null){ %> 
<div class="tableFixHead">
<table  style="width: 100%; border: 1px solid black; margin-left: 0%;margin-top:20px;margin-right: 0%; text-align:center">
                <thead>
                    <tr style="background-color: #660066; text-align:center; ">
                        <th>Username</th>
                       <th>Item Id</th>
                       <th>Item Name</th>	
                       <th> Weight</th>
                        <th>Category</th>					
                        <th>Price Per Unit</th>
                        
                        <th>Quantity</th>
                    </tr>
        <%
        try {
        	double total=0; 
        	String offer="";
        	Class.forName("com.mysql.jdbc.Driver");
        	Connection connect = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/BillingSystem", "root", "123456");
        	Statement statement = connect.createStatement();
        	int id=Integer.parseInt(request.getParameter("admintransferid"));
        	ResultSet resultSet=statement
					.executeQuery("SELECT sum(price),offerapplied FROM orders where orderId="+id+";");
        	if(resultSet.next()){
        		total=resultSet.getDouble(1);
				offer=resultSet.getString(2);
        	} 
        	resultSet=statement
					.executeQuery("SELECT orders.username,orders.orderId,item.itemname,item.Weight,item.category,item.price,orders.quantity FROM orders  join item on item.itemId=orders.itemId and orders.orderId="+request.getParameter("admintransferid")+";");
			while(resultSet.next()) {
		
		
			
        %>
         
                    <tr style="text-align:center;">
                        <td><% out.print(resultSet.getString(1)); %></td>
                        
                        
                       <td> <%out.print(resultSet.getInt(2)); %> </td>
                 
                        <td><% out.print(resultSet.getString(3)); %> </td>
                        
                        <td><%out.print(resultSet.getString(4));%> </td>             
                        <td><%out.print(resultSet.getString(5));%> </td>  
                         <td><%out.print(resultSet.getDouble(6));%> </td>     
                         <td><%out.print(resultSet.getInt(7));%> </td>             
                                                                 
                            
                        </tr>
                 
                                    <%}%>
                                      </table>
                                      </div>
                                    <table style="float:right;margin-top:50px;margin-right:50px;width:25%">
		<tr>
		<td style="font-weight:bold;  background-color: #660033 ;color:white;">Offer Applied</td>
		<td> <%out.print(offer);%></td>
		</tr>
		<tr>
		<td style="font-weight:bold;  background-color: #660033 ;color:white;">Total</td>
		<td><%out.print(total);%></td>
		</tr>
		
		</table>
			
        <%}
		 catch (Exception e) {			// TODO Auto-generated catch block
			e.printStackTrace();
		}%>
		                     
		                       
<%}
 else{
		request.setAttribute("message", "LOGIN EXPERIED");

request.getRequestDispatcher("/index.jsp").forward(request,response);}
%>
</body>
</html>
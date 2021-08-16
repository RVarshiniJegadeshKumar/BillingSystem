<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@ include file="UserHeader.jsp" %>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
th td{
border: 1px solid #ccc;

}
</style>
</head>
<body>
<%if(session.getAttribute("user")!=null){ %>
<div class="tableFixHead">
<table  style="width: 100%; border: 1px solid black; margin-left: 0%;  margin-top: 20px;margin-right: 0%; text-align:center">
                <thead>
                    <tr style="background-color: #ff6600; " >
                       <th>Item Id</th>
                       <th>Item Name</th>	
                                              <th>Weight</th>	
                      
                        <th>Category</th>					
                        <th>Price</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
       
        <%
        try {
        	double total=0; 
        	String offer="";
        	Class.forName("com.mysql.jdbc.Driver");
        	Connection connect = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/BillingSystem", "root", "123456");
        	Statement statement = connect.createStatement();
        	ResultSet resultSet=statement
					.executeQuery("SELECT sum(orders.price),orders.offerapplied FROM orders where orders.orderId="+request.getParameter("usertansferid")+";");
        	if(resultSet.next()){
        		total=resultSet.getDouble(1);
				offer=resultSet.getString(2);
        	}
        	resultSet=statement
			.executeQuery("SELECT item.itemId,item.itemname,item.category,item.price,orders.quantity,item.Weight FROM orders JOIN  item on item.itemId=orders.itemId and orders.username='"+session.getAttribute("user")+"' and orders.orderId="+request.getParameter("usertansferid")+";");
			while(resultSet.next()) {
				
		
			
        %>         

                    <tr>
                    	<td><% out.print(resultSet.getInt(1)); %></td>
                    	
                        <td><% out.print(resultSet.getString(2)); %></td>
                        <td><% out.print(resultSet.getString(6)); %></td>
                      	
                       <td > <%out.print(resultSet.getString(3)); %> </td>
                      
                        <td ><% out.print(resultSet.getDouble(4)); %> </td>
                       
                       
                        <td ><%out.print(resultSet.getString(5));}%> </td>             
                               
                        </tr>
                      
                    
                                  
		</table>
		<table style="border-style: solid;    border-color:black;float:right;margin-top:50px;margin-right:50px;width:25%">
		<tr >
		<th >Offer Applied</th>
		<td> <%out.print(offer);%></td>
		</tr>
		<tr>
		<th>Total</th>
		<td><%out.print(total);%></td>
		</tr>
		
		</table>
		</div>
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
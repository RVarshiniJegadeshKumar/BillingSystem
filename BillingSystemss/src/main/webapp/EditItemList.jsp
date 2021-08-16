<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="AdminHeader.jsp"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
.backgroundimg{
background-image:url(edititem.jpeg);
 background-repeat: no-repeat;
  background-size: cover;
    height: 100%; 

}
label{
font-weight:bold;	
}
.buttonedit{
border-radius: 12px;
 background-color: #000099;
 color:white;
 font-weight:bold;
}
</style>
<body class="backgroundimg">
	<form action="AdminServlet" method="post">
	<div style=" width: 100%;height: 70%; position:fixed;margin-left:350px; margin-bottom:300px;margin-right:300px;margin-top:50px;">
		<div style="margin-left:150px;">			<h3 class="alret">${message}</h3>
		</div>
		<table style=" border-style: solid;border-color: #86592d; border-spacing: 10px;margin-left: 10%;">

			<%
			int id = Integer.parseInt(request.getParameter("transferid"));

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/BillingSystem", "root", "123456");
				Statement statement = connect.createStatement();
				ResultSet resultSet = statement.executeQuery("SELECT *  from item where itemId=" + id + ";");
				if (resultSet.next()) {
			%>
			<tr>
				<td><label for="transferid">Item Id</label></td>
				<td><input id="transferid" name="transferid"
					value=<%out.print(id);%> class="form-control input-md" readonly
					type="number"></td>
			</tr>
			<tr>
				<td><label for="itemName">Item Name</label></td>
				<td><input id="itemName" name="itemName"
					value=<%out.print(resultSet.getString(2));%> type="text"></td>
			</tr>
				<tr>
				<td><label for="itemWeight">Weight</label></td>
				<td><input id="itemWeight" name="itemWeight"
					value=<%out.print(resultSet.getString(7));%> type="text"></td>
			</tr>
			<tr>

				<td><label for="availableQuantity">Available Quantity</label></td>

				<td><input id="availableQuantity" name="availableQuantity"
					value=<%out.print(resultSet.getInt(5));%> type="text"></td>
			</tr>
			<tr>
				<td><label for="category">Item Category</label></td>
				<td>
				 <select name="category" id="category">
				   <option value=" <%out.print(resultSet.getString(3));%>"><%out.print(resultSet.getString(3));%></option>
				   <%if(!(resultSet.getString(3)).equals("Perfume")){ %>
      <option value="Perfume">Perfume</option><%} %>
       <%if(!(resultSet.getString(3)).equals("Shampoo")){ %>
      <option value="Shampoo">Shampoo</option><%} %>
       <%if(!(resultSet.getString(3)).equals("Soap")){ %>
        <option value="Soap">Soap</option><%} %>
         <%if(!(resultSet.getString(3)).equals("Oil")){ %>
      <option value="Oil">Oil</option><%} %>
               <%if(!(resultSet.getString(3)).equals("Powder")){ %>
      
      <option value="Powder">Powder</option><%} %>
               <%if(!(resultSet.getString(3)).equals("Conditioner")){ %>
      
						<option value="Conditioner">Face Wash</option><%} %>
						  <%if(!(resultSet.getString(3)).equals("Face Wash")){ %>
      
						<option value="Face Washr">Conditioner</option><%} %>
						  <%if(!(resultSet.getString(3)).equals("Body Wash")){ %>
      
						<option value="Body Wash">Body Wash</option><%} %>
   
  </select>
				
					</td>
			</tr>
			<tr>
				<td><label for="price">Price Per Unit</label></td>
				<td><input id="price" name="price"
					value=<%out.print(resultSet.getDouble(4));%> type="text"></td>
			</tr>
			<tr>
				<td><label for="itemOffer">Offer</label></td>
				<td>
				  <select name="itemOffer" id="itemOffer">
      <option value="<%out.print(resultSet.getString(6));%>"><%out.print(resultSet.getString(6));%></option>
      <% if(!((resultSet.getString(6)).equals("No"))){%>
            <option value="No">No</option><%}else{ %>
      <option value="Yes">Yes</option><%} %>
      </select>
					</td>
			</tr>
			<tr>
				<td><input class="buttonedit" type="submit" id="submit" name="submit"
					value="EDIT ITEM" class="btn btn-primary"></td>
				<td style="font-weight:bold;"><a href="AllItems.jsp">Abort Edit</a></td>
			</tr>
			<tr>
				<td colspan="2">
					<h3>${message}</h3>
				</td>
			</tr>


			<%
			}
			} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}
			%>
		</table>
		</div>
	</form>
</body>
</html>
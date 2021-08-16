<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="AdminHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
label{
font-weight:bold;
}
.buttonadd{
border-radius: 12px;
 background-color: #ff4dd2;
}
.buttonadd:focus{
 background-color:#cc0099;
} 


</style>
<meta charset="ISO-8859-1">
<title>Add Item</title>
</head>
<body class="backgroundimg">
	<%
	if (session.getAttribute("user") != null) {
	%>
	<form action="AdminServlet" method="post">
	<div>
	
		<div style=" width:100%;position: fixed;margin-left:350px;margin-right:300px;margin-top:50px;">
		<div style="margin-left:150px;">			<h3 class="alret">${message}</h3>
		</div>
		<table style=" border-style: solid;border-color: #86592d; border-spacing: 10px;margin-left: 10%;">

			<tr>
				<td><label for="product_name">ITEM NAME</label></td>
				<td><input id="itemName" name="itemName"
					placeholder="ITEM NAME" required
					type="text"></td>
			</tr>
			<tr>
				<td ><label for="itemWeight">WEIGHT</label></td>
				<td><input id="itemWeight" name="itemWeight" placeholder="ITEM WEIGHT"  type="text"></td>
			</tr>
			<tr>
				<td ><label   for="category">SELECT CATEGORY   </label></td>
				<td><select name="category" id="category" style="border-radius: 12px;">
						<option value="Perfume">Perfume</option>
						<option value="Shampoo">Shampoo</option>
						<option value="Soap">Soap</option>
						<option value="Powder">Powder</option>
						<option value="Conditioner">Conditioner</option>
						<option value="Oil">Oil</option>
						<option value="Face Wash">Face Wash</option>
						<option value="Body Wash">Body Wash</option>

				</select></td>
			</tr>
			<tr>
				<td ><label for="price">PRICE PER UNIT</label></td>
				<td><input id="price" name="price" placeholder="PRICE PER UNIT"
					required type=number></td>
			</tr>

			<tr>
				<td ><label for="availableQuantity">AVAILABLE QUANTITY</label></td>
				<td><input id="availableQuantity" name="availableQuantity"
					placeholder="AVAILABLE QUANTITY" required type="text"></td>
			</tr>
			<tr>
				<td ><label for="itemOffer">OFFER AVAILABLE</label></td>
				<td><select name="itemOffer" id="itemOffer" style="border-radius: 12px;">
						<option value="Yes">Yes</option>
						<option value="No">No</option>


				</select></td>
			</tr>
			<tr>
				<td > <input class="buttonadd" type="submit" id="submit" name="submit"
					value="ADD ITEM" class="btn btn-primary"></td>
			
			
			<td  style="text-align:center">
			<a href="AdminOperation.jsp">ABORT ADD PRODUCT</a>
			</td>
		</tr>			

		</table>
</div>

</div>
	</form>
	<%
	} else {
	request.setAttribute("message", "LOGIN EXPERIED");

	request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	%>
</body>
<br>
<br>
<br>




</html>
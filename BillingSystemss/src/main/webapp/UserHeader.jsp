
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ include file="Footer.jsp"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<meta charset="utf-8">
<meta name="robots" content="noindex, nofollow">

<title>Shopping Cart</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>
	<table style="width: 100%; background-color: DodgerBlue;">
		<tr>
		</tr>
		<tr>
		</tr>
		<tr>
		</tr>
		<tr>

			<th style="color: white;">ABC Shopping Site</th>



			<th><a style="color: white;" href="Home.jsp">Home</a></th>


			<th><a style="color: white;" href="UserOperation.jsp">Product
					List</a></th>

			<th><a style="color: white;" href="Orders.jsp"> My orders </a></th>

			<th><a style="color: white;" href="UserCart.jsp">Cart ></a></th>

			<th><a style="color: white;" href="Logout.jsp">Logout >>></a></th>

			<th>
			<form action="SearchUser.jsp">
			<input id="searchbar" type="text"  name="search"
				aria-label="Small"  style="margin-top: 12px; height: 25px;"
				placeholder="Search..."  onkeyup="displaySearch(this.id)"> 
				<button type="submit" style="height: 25px;">
				<i class="fa fa-search"></i>
				</button></form>
			

				</th>
			<th><a style="color: white;" href="UserCart.jsp">
					<i class="fa fa-shopping-cart"></i> Cart

			</a></th>


		</tr>
		<tr>
		<tr>
	</tr>
	<tr>
	</tr>
	<tr>
	</tr>
	<tr>
	</tr>
		</tr>
		<tr>
		</tr>
		<tr>
		</tr>
		<tr>
		</tr>
	</table>
</body>
</html>

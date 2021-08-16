<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="UserHeader.jsp"%>

<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.buttonquantity{
	background-color:  	rgb(184,134,11,0.5);
	border-radius: 8px;
  border: none;
  color: white;
  text-align: center;
  display: inline-block;
  font-size: 12px;
  margin: 4px 2px;
}

.buttonConfirm {
	background-color: #ff8000;
	border-radius: 12px;
	border: none;
	color: white;
	padding: 10px;
	text-align: center;
	display: inline-block;
	font-size: 16px;
	margin-top: 15px;
	cursor: pointer;
	box-shadow: 0 9px #999;
}
</style>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
let textboxId;
let buttonId;
let check=0;
let quantityUser;
function increment(itemId,itemprice,total) {
	document.getElementById("quantity" + itemId).stepUp();
	let p=document.getElementById("quantity" + itemId).value;
console.log(total);
	let updatedprice=p*itemprice;
	document.getElementById("price"+itemId).innerHTML=updatedprice;
	document.getElementById("cartTotal").innerHTML=total+itemprice;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let text = this.responseText;
			document.getElementById("Result").innerHTML = text;

		}
	};
	xhttp.open("POST", "UserItemServlet?userSelectedItemId=" + itemId
			+ "&process=add", true);
	xhttp.send();
	
}
function decrement(itemId,itemprice,total) {
	document.getElementById("quantity" + itemId).stepDown();
	let updatedprice=document.getElementById("quantity" + itemId).value*itemprice;
	document.getElementById("price"+itemId).innerHTML=updatedprice;
	if(document.getElementById("quantity" + itemId).value>1){
	document.getElementById("cartTotal").innerHTML=total-itemprice;}
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let text = this.responseText;
			document.getElementById("Result").innerHTML = text;

		}
	};
	xhttp.open("POST", "UserItemServlet?userSelectedItemId=" + itemId
			+ "&process=sub&reqFrom=cart", true);
	xhttp.send();
}
function cickFunction(clicked,price) {
	  var xhttp = new XMLHttpRequest();
	  var cartquantity="";
	if(clicked!=("Confirm")){
		console.log();
		
			  let txt="Yes";
			  if (confirm("Are you sure to delete item from cart!")) {
			    txt = "Yes";
			  } else {
			    txt = "No";
			  }
			  if(txt=="Yes"){
		let row=document.getElementById(clicked).parentNode.parentNode.rowIndex;
		
		document.getElementById("cartTable").deleteRow(row);
		let t=document.getElementById("cartTotal").innerHTML;
		console.log(t);
		console.log(price);

		t=t-price;
		console.log(t);
		document.getElementById("cartTotal").innerHTML=t;
		t=0;
			  }
			  else{
				  clicked="";
			  }
	}
	else{
		let t=0;
		var quantity = document.getElementsByTagName("input");
		
		  for(var i = 1; i < quantity.length; i++){
			  cartquantity=cartquantity+quantity[i].value+" ";
		    console.log(quantity[i].value);
		  }
		check=1;
	
	}
	  xhttp.onreadystatechange = function() {
	    if (this.readyState == 4 && this.status == 200) {
	      let r = this.responseText;
	        if(r=="Order placed successfully"&&check==1){
	        	document.getElementById("cartTotal").innerHTML=0.0;
	    		var table = document.getElementById("cartTable");

	    		while (table.rows.length-3 > 1) {
	    		  table.deleteRow(1);
	    		}		
		       }
		        document.getElementById("Result").innerHTML=r;
		    }
	    
	  };
	 
	  let button=clicked;
	  xhttp.open("POST", "UserOrderServlet?userCartDel="+button+"&userquantity="+cartquantity, true);
	  xhttp.send();
	}
</script>
</head>
<body>
	<%
	if (session.getAttribute("user") != null) {
	%>

	<p id="Result" style="text-align: center"></p>

	<h1 style="text-align: center; color: #ff0000;">ABC Shopping CART</h1>
	<h3 style="text-align: center;">${message }</h3>
	<div>
		<table id="cartTable"
			style="width: 80%; border: 1px solid black; margin-left: 10%; margin-right: 10%;">
			<thead>
				<tr style="background-color: #ffaa00; padding: 8px 16px;">
					<th scope="col">Item ID</th>
					<th scope="col">Product</th>
					<th scope="col">Weight</th>
					<th scope="col" class="text-center">Quantity</th>
					<th scope="col" class="text-right">Price</th>
					<th>Remove From Cart</th>
				</tr>
			</thead>
			<tr>
				<td></td>

			</tr>
			<tbody
				style="text-align: center; border-spacing: 15px; padding: 8px 16px;">
				<%
				int count = 0;
				double total = 0;

				try {
					Class.forName("com.mysql.jdbc.Driver");
					Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/BillingSystem", "root", "123456");
					Statement statement = connect.createStatement();
					ResultSet resultSet = statement.executeQuery(
							"SELECT sum(cart.total) fROM cart  where cart.username='"+ session.getAttribute("user") + "';");
					if(resultSet.next()){
						total=resultSet.getDouble(1);
					}
					
					resultSet = statement.executeQuery(
					"SELECT cart.itemId,item.itemname,cart.quantity,item.availablequantity,cart.total,item.Weight,item.price FROM cart JOIN item ON item.itemId = cart.itemId where cart.username='"
							+ session.getAttribute("user") + "';");
					while (resultSet.next()) {
						count++;
				%>
				<tr>
					<td>
						<%
						out.print(resultSet.getInt(1));
						%>
					</td>
					<td>
						<%
						out.print(resultSet.getString(2));
						%>
					</td>
					<td>
						<%
						out.print(resultSet.getString(6));
						%>
					</td>


					<td><button class="buttonquantity"
							onclick="increment(this.value,<% out.print(resultSet.getDouble(7)); %>,<%out.print(resultSet.getInt(5));%>)"
							value="<%out.print(resultSet.getInt(1));%>">+</button>
						<input style="text-align: center; width: 50px;"
						id=<%out.print("quantity" + resultSet.getInt(1));%> type=number
						min=1 max=<%out.print(resultSet.getInt(3)+resultSet.getInt(4)); %> maxlength="2" size="5" readonly value=<%out.print(resultSet.getInt(3)); %>>
						<button class="buttonquantity" onclick="decrement(this.value,<% out.print(resultSet.getDouble(7)); %>,<%out.print(total);%>)"
							value="<%out.print(resultSet.getInt(1));%>">-</button></td>
					<td id=<%out.print("price"+resultSet.getInt(1)); %>>
						<%
						out.print(resultSet.getInt(5));
						int itemprice = (resultSet.getInt(5));
						;
						%>
					</td>
					<td><button id=<%out.print(resultSet.getInt(1));%>
							name=submit value=<%out.print(resultSet.getInt(1));%>
							onclick="cickFunction(this.value,<%out.print(itemprice);%>)">
							<i class="fa fa-trash"></i>
						</button></td>
				</tr>
				<%
				}
				%>
			</tbody>


			<tfoot>
				<tr style="text-align: center;">
					<td colspan="3"></td>
					<td style="background-color: #ffaa00;">Offer</td>
					<td style="background-color: #ffaa00;">
						<%
						String offer = "Yes";
						resultSet = statement
								.executeQuery("Select * from orders where username='" + (String) session.getAttribute("user") + "';");
						if (resultSet.next()) {
							offer = "No";
							out.print("No");
						} else {
							out.print("Yes");

						}
						%>
					</td>
				</tr>
				<tr style="text-align: center;">
					<td colspan="3"></td>

					<%
					%>
					<td style="background-color: #ffaa00;">Total</td>
					<td id="cartTotal" style="background-color: #ffaa00;">
						<%
						
							out.print((total));
						
						%>
					
				</tr>
				<tr>
					<td colspan="3"></td>
				</tr>
		</table>
		<div style="margin-left: 500px;">
			<button class="buttonConfirm" name="submit" type="submit"
				value="Conitnue Shopping"
				onclick="location.href ='UserOperation.jsp'">Continue
				Shopping</button>
			<button class="buttonConfirm" id="Confirm" name="submit"
				value="Confirm"
				onclick="cickFunction(this.id,<%out.print(total);%>)">Confirm</button>
		</div>
	</div>
	<%
	} catch (SQLException e) {
	e.printStackTrace();
	}
	%>


	<%
	} else {
	request.setAttribute("message", "LOGIN EXPERIED");

	request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	%>
</body>
</html>
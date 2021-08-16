<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ include file="UserHeader.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
<link rel="stylesheet" href="ProductList.css">
</head>
<body onload="getItemList(1,'<% String search=request.getParameter("search");out.print(search);%>')">
	
	<h3> Search result for
		<%
	out.print(search);
	
	%></h3>	
	
<%
	if (session.getAttribute("user") != null) {
	%>
	<p id="Result" style="text-align:center">
	</p>
	<div>
					<span style="margin-left: 450px; font-weight: bold;">Number
						Of Products Per Page</span> <select id="itemsPerPage"
						onchange="itemsPerPage()" class="dropdown">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>

				</div>
				<div   class="tableFixHead" Style="margin-top: 20px;">
			<table id="itemTable" 
						style="width: 100%;height:250p; border: 1px solid black; margin-left: 0%; margin-right: 0%; text-align: center;">
						<thead>
			<tr>
				<th scope="col"><h3>ID</h3></th>
								<th scope="col"><h3>Name</h3></th>
								<th scope="col"><h3>Weight</h3></th>
								<th scope="col"><h3>Category</h3></th>
								<th scope="col"><h3>Price</h3></th>
								<th><h3>Add to cart</h3></th>
			</tr>
		</thead>
		<tbody id="tbody">
			</tbody>
      </table>
     
      <div id="page" style="float: right;">
					<button class="buttonpage" id="pagePrev" onclick="prevPage()">Previous</button>
					<button class="buttonpage" id="pageNext" onclick="nextPage()">Next</button>
				</div>

			</div>

      <br>
      <br>
      <br>
   	<%
	} else {
	request.setAttribute("message", "LOGIN EXPERIED");

	request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	%>  

</body>
<script>
let itemList=[];
var current_page = 1;
var recordsPerPage = document.getElementById("itemsPerPage").value;
function itemsPerPage() {
	recordsPerPage = document.getElementById("itemsPerPage").value;
	getItemList(current_page);
}

function prevPage() {
	if (current_page > 1) {
		current_page--;
		getItemList(current_page);
	}
}

function nextPage() {
	current_page++;
	getItemList(current_page);

}

function changePage(page) {

	document.getElementById("tbody").innerHTML = "";
	var j = 0
	for (var i = 0; i < itemList.length; i++) {
		document.getElementById("tbody").innerHTML += itemList[i];

	}

	if (page == 1) {
		document.getElementById("pagePrev").disabled = true;
	} else {
		document.getElementById("pagePrev").disabled = false;
	}

};
function numPages() {
	return Math.ceil(itemList.length / recordsPerPage);
}
function getItemList(currentpage,search) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let t = this.responseText;
			if (t.length == 0) {
				current_page--;
				document.getElementById("pageNext").disabled = true;
			} else {
				document.getElementById("pageNext").disabled = false;
				let list = [];
				list = (t.split("]"));
				itemList = list;
				changePage(currentpage);
			}

		}
	}

	let button = -2;
	xhttp.open("POST", "UserItemServlet?userSelectedItemId=" + button
			+ "&currentPage=" + current_page + "&recordsPerPage="
			+ recordsPerPage+"&search="+search, true);
	xhttp.send();

};
function display(clicked) {
	var xhttp = new XMLHttpRequest();
	console.log(clicked);
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let text = this.responseText;
			if (text == "Unable to add to cart") {
				document.getElementById(clicked).innerHTML = "Out of Stock";
			}
			document.getElementById("Result").innerHTML = text;

		}
	};

	xhttp.open("POST", "UserItemServlet?userSelectedItemId=" + clicked,
			true);
	xhttp.send();
}
function increment(itemId) {
	document.getElementById("quantity" + itemId).stepUp();
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
function decrement(itemId) {
	document.getElementById("quantity" + itemId).stepDown();
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let text = this.responseText;
			document.getElementById("Result").innerHTML = text;

		}
	};
	xhttp.open("POST", "UserItemServlet?userSelectedItemId=" + itemId
			+ "&process=sub&reqFrom=useroperation", true);
	xhttp.send();
}

</script>
</html>
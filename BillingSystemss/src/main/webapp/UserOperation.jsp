<%@page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ include file="Footer.jsp"%>
<!DOCTYPE html>
<html>
<head>

<style>
</style>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="ProductList.css">

</head>
<body onload="getItemList(1)">

	<table
		style="width: 100%; background-color: DodgerBlue; margin-bottom: 0px;">

		<tr>

			<th style="color: white;">ABC Shopping Site</th>



			<th><a style="color: white;" href="Home.jsp">Home</a></th>


			<th><a style="color: white;" href="UserOperation.jsp">Product
					List</a></th>

			<th><a style="color: white;" href="Orders.jsp"> My orders </a></th>

			<th><a style="color: white;" href="UserCart.jsp">Cart </a></th>

			<th><a style="color: white;" href="Logout.jsp">Logout >>></a></th>

			<th>
				<form action="SearchUser.jsp">
					<input id="searchbar" type="text" name="search" aria-label="Small"
						placeholder="Search..." onkeyup="displaySearch()"
						style="margin-top: 12px; height: 25px;">
					<button type="submit" style="height: 25px;">
						<i class="fa fa-search"></i>
					</button>
				</form>


			</th>
			<th><a style="color: white;" href="UserCart.jsp"> <i
					class="fa fa-shopping-cart"></i> Cart

			</a></th>


		</tr>

	</table>
	<%
	if (session.getAttribute("user") != null) {
	%>
	<div>


		<div
			style="height: 100%; width: 25%; position: fixed; margin-top: 10px; left: 0;">
			<div class="menu" style="height: 65%">
				<div>
				<label for="filter">Filter Products by
					<button onclick="filter()" id="filter" class="filterbutton">
						<i class="fa fa-filter"></i>
					</button></label>
					<div class="sub">
						<button class="buttonSplit">SKIN CARE PRODUCTS</button>
						<div style="margin-top: 5px;">
							<label class="container">Soap <input type="checkbox"
								value="Soap" name="poducts"> <span class="checkmark"></span>
							</label> <label class="container">Body Wash <input
								value="Body Wash" name="poducts" type="checkbox"> <span
								class="checkmark"></span>
							</label> <label class="container">Perfume <input value="Perfume"
								name="poducts" type="checkbox"> <span class="checkmark"></span>
							</label><label class="container">Show All Skin Care Product <input
								value="All Skin" name="poducts" type="checkbox"
								checked="checked"> <span class="checkmark"></span>
							</label>

						</div>
						<div>
							<button class="buttonSplit">HAIR CARE PRODUCTS</button>
							<div style="margin-top: 5px;">
								<label class="container">Shampoo <input type="checkbox"
									value="Shampoo" name="poducts"> <span class="checkmark"></span>
								</label> <label class="container">Conditioner <input
									type="checkbox" value="Conditioner" name="poducts"> <span
									class="checkmark"></span>
								</label> <label class="container">Oil <input type="checkbox"
									value="Oil" name="poducts"> <span class="checkmark"></span>
								</label> <label class="container">Show All Hair Care Product <input
									type="checkbox" value="All Hair" name="poducts"
									checked="checked"> <span class="checkmark"></span>
								</label>
							</div>

							<div>
								<button class="buttonSplit">FACE CARE PRODUCTS</button>
								<div style="margin-top: 5px;">
									<label class="container">Face Wash <input
										type="checkbox" value="Face Wash" name="poducts"> <span
										class="checkmark"></span>
									</label> <label class="container">Powder <input type="checkbox"
										value="Powder" name="poducts"> <span class="checkmark"></span>
									</label> <label class="container">Show All Face Care Product <input
										type="checkbox" checked="checked" value="All Face"
										name="poducts"> <span class="checkmark"></span>

									</label>

								</div>

							</div>
							<div>
								<label for="pricerange">Price Range<br>
							  <input id="pricerange" name="pricerange" type="range" min="1" max="500" value="300" onchange="showrangevalue()"><span style="color:white;font-weight:bold;left:10px;" id="rangevalue"></span></label>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="height: 100%; width: 75%; position: fixed; right: 25;">
		<p id="Result" style="text-align: center"></p>

		<div>
			<span style="margin-left: 500px; font-weight: bold;">Number Of
				Products Per Page</span> <select id="itemsPerPage"
				onchange="itemsPerPage()" class="dropdown">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>

		</div>
		<div class="tableFixHead" Style="margin-top: 5px;height:260px;">

			<table id="itemTable"
				style="width: 80%; border: 1px solid black; margin-left: 20%; margin-right: 0%; text-align: center;">
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
				<tbody id="tbody" style="overflow-y: auto;">

					<%
					int pageCount = 1;
					%>
				</tbody>

			</table>
		</div>
		<div id="page" style="float: right;">
			<button class="buttonpage" id="pagePrev" onclick="prevPage()">Previous</button>
			<button class="buttonpage" id="pageNext" onclick="nextPage()">Next</button>
		</div>

	</div>
	
	</div>
	<%
	} else {
	request.setAttribute("message", "LOGIN EXPERIED");

	request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	%>

</body>
<script type="text/javascript">
	var current_page = 1;
	var recordsPerPage = document.getElementById("itemsPerPage").value;
	var itemList = [];
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
		filter();
		showrangevalue();
	};
	function numPages() {
		return Math.ceil(itemList.length / recordsPerPage);
	}
	function getItemList(currentpage) {
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

		let button = -1;
		xhttp.open("POST", "UserItemServlet?userSelectedItemId=" + button
				+ "&currentPage=" + current_page + "&recordsPerPage="
				+ recordsPerPage, true);
		xhttp.send();

	};
	function filter(){
		 var productcheckboxes = document.querySelectorAll('input[name="poducts"]:checked');
		 let products = [];
		 productcheckboxes.forEach((checkbox) => {
			 if(checkbox.value=="All Hair"){
				 products.push("oil");
				 products.push("conditioner");
				 products.push("shampoo");
			 }
			 else  if(checkbox.value=="All Face"){
				 products.push("powder");
				 products.push("face wash");
			 } 
			 else  if(checkbox.value=="All Skin"){
				 products.push("soap");
				 products.push("body wash");
				 products.push("perfume");

			 }
			 else{
				 products.push(checkbox.value);

			 }
		 });
		
		 let list = document.getElementById("tbody").getElementsByTagName("tr");
		 let result=[];
		 console.log(list);
		 for(let j=0;j<products.length;j++){
		 for (i = 0; i < list.length; i++) {
				if ( (((list[i].cells[3]).innerHTML.toLowerCase().includes(products[j].toLowerCase())))) {
					let flag=0;
					for(let k=0;k<result.length;k++){
						 if(result[k]==(list[i])){
							 flag=1;
						 }}
					 if(flag==0){
						 result.push((list[i]));
					 }
			}
		 }
		 }
		 let price=document.getElementById("pricerange").value;
		 price=price*1.0;
		 for(let j=0;j<list.length;j++){
			 let flag=0;
		 for(let i=0;i<result.length;i++){
		 	if(result[i]==list[j]&&(result[i].cells[4].innerText<=price)){
		 		flag=1;
		 	}
		 }
		 if(flag==0){
			 list[j].style.display = "none";
			} else {
				list[j].style.display = "";
				
			}
		 }
			
		 
	}
	function displaySearch() {
		let input = document.getElementById('searchbar').value
		input = input.toLowerCase();
		let list = document.getElementById("tbody").getElementsByTagName("tr");
		for (i = 0; i < list.length; i++) {
			if (!(list[i].cells[1]).innerHTML.toLowerCase().includes(input)
					&& ((!(list[i].cells[3]).innerHTML.toLowerCase().includes(
							input)))) {
				list[i].style.display = "none";
			} else {
				list[i].style.display = "";
			}
		}
	}

	let textboxId;
	let buttonId;
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
	function showrangevalue(){
		let pricevalue=document.getElementById("pricerange").value;
		document.getElementById("rangevalue").innerHTML=pricevalue;
	}
	
</script>

</html>
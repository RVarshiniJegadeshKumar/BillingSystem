<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ include file="AdminHeader.jsp" %>
    <%@page import="java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="AdminDesign.css">
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>
<style type="text/css">
.dropdownPageNo{ 
 padding: 4px;
  border: 1px solid transparent;
color:white;  
magin-right:100px;

}

.dropdownsort{
 padding: 4px;

  border: 1px solid transparent;
color:#660033;  
magin-right:100px;
border-radius: 4px;

}
.searchbutton{
color:white;
background-color: #ff3333;
}

</style>
</head>
<script type="text/javascript">
var current_page = 1;
var recordsPerPage = document.getElementById("ordersPerPage").value;
var orderList = [];
var sort;
 function sortPage(){
	sort= document.getElementById("sortPage").value;
	getOrderList(current_page);	
}
function ordersPerPage() {
	recordsPerPage = document.getElementById("ordersPerPage").value;
	getOrderList(current_page);
}

function prevPage() {
	if (current_page > 1) {
		current_page--;
		getOrderList(current_page);
	}
}

function nextPage() {
	current_page++;
	getOrderList(current_page);

}

function changePage(page) {

	document.getElementById("tbody").innerHTML = "";
	var j = 0
	for (var i = 0; i < orderList.length; i++) {
		document.getElementById("tbody").innerHTML += orderList[i];

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
function getOrderList(currentpage) {
	var xhttp = new XMLHttpRequest();
	recordsPerPage = document.getElementById("ordersPerPage").value;
	sort= document.getElementById("sortPage").value;
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
				orderList = list;
				console.log(recordsPerPage);
				changePage(currentpage);
			}

		}
	}

	let button = -1;
	xhttp.open("POST", "AdminServlet?submit=showorders&admincurrentPage=" + current_page + "&adminrecordsPerPage="
 				+ recordsPerPage+"&sort="+sort, true);
	xhttp.send();

};
function displaySearch(){
	let input = document.getElementById('searchbar').value
	input = input.toLowerCase();
	let list = document.getElementById("tbody").getElementsByTagName("tr");
	for (i = 0; i < list.length; i++) {
		if (!(list[i].cells[1]).innerHTML.toLowerCase().includes(input)) {
			list[i].style.display = "none";
		} else {
			list[i].style.display = "";
		}
	}
	
}

</script>
<body onload="getOrderList(1)"  class="backgroundimg" style="background-image:url(emptybg.jpg);">
 <%if(session.getAttribute("user")!=null){ %> 
 <div style="margin-top:10px;">
 <div>
 <div>
 			<label for="sortPage" style="font-weight: bold;float:left;margin-left:100px;color: #660033">Sort Page By
			 <select id="sortPage"
				onchange="sortPage()" style="background-color: #ff3333;"  class="dropdownsort" >
				<option value="ordersId">Orders ID</option>
				<option value="TotalInc">Total Ascending</option>
				<option value="TotalDec">Total Descending</option>
				<option value="username">Username</option>
			</select></label>

		</div>
		<div>

			<label for="ordersPerPage" style="float:right;margin-right:100px;font-weight: bold;">Number Of
				Products Per Page <select id="ordersPerPage"
				onchange="ordersPerPage()" style="	background-color: #ff3333;" class="dropdownPageNo">
				<option value="10">10</option>
				<option value="15">20</option>
				<option value="25">25</option>
				<option value="30">30</option>
				<option value="40">40</option>
			</select></label>

		</div>
		<div>
		<span style="margin-left:100px;"><input id="searchbar" type="text"  name="search"
				placeholder="Search Customer name " onkeyup="displaySearch()"><button class="searchbutton" onclick="displaySearch()"> <i class="fa fa-search"></i></button></span>
		</div>
		</div>
		</div>
		<div   class="tableFixHead" Style="margin-top: 10px;height:400px;">
<table style="width: 80%;margin-left: 10%; margin-right: 10%; text-align:center;">
<thead style="background-color:#ff6666; text-align:center; ">
                    <tr >
                        <th>Order ID</th>
                        <th>Customer Username</th>
                        <th>Total No. of Items</th>	
                        <th>Offer Applied</th>					
                        <th>Net Amount</th>
                        <th>View Details</th>
                    </tr>
      </thead>
        <tbody id="tbody" >
     

                   </tbody>
                    </table>
                    </div>
                    <div id="page" style="margin-left:800px;">
			<button class="buttonpage" style="background-color:#ff3333;" id="pagePrev" onclick="prevPage()">Previous</button>
			<button class="buttonpage"  style="background-color:#ff3333;" id="pageNext" onclick="nextPage()">Next</button>
			<div>
		</div>
                    
 <%} else{
		request.setAttribute("message", "LOGIN EXPERIED");

request.getRequestDispatcher("/index.jsp").forward(request,response);}
%>   

</body>
</html>
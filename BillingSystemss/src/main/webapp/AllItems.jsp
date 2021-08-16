    <%@ include file="AdminHeader.jsp" %>
   
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
<script src='https://kit.fontawesome.com/a076d05399.js' ></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="AdminDesign.css">
<style>
h3
{
	color: yellow;
	text-align: center;
}
.input-icons i {
			position: absolute;
		}
		
		.input-icons {
			width: 10%;
			margin-bottom: 10px;
		}
		
		.icon {
			padding: 10px;
			min-width: 40px;
		}
</style>
</head>
<script>
var current_page = 1;
var recordsPerPage = 1;
var itemList = [];
let search;
var sort;
function sortPage(){
	sort= document.getElementById("sortPage").value;
	getAllProductList(current_page);	
}
function itemsPerPage() {
	recordsPerPage = document.getElementById("itemsPerPage").value;
	getAllProductList(current_page);
}

function prevPage() {
	if (current_page > 1) {
		current_page--;
		getAllProductList(current_page);
	}
}

function nextPage() {
	current_page++;
	getAllProductList(current_page);

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
function getAllProductList(currentpage) {
	 recordsPerPage = document.getElementById("itemsPerPage").value;
	  search=document.getElementById("searchbar").value;
		sort= document.getElementById("sortPage").value;

	var xhttp = new XMLHttpRequest();
	console.log(sort.length+"search");
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let t = this.responseText;
			if (t.length == 0) {
				current_page--;
				document.getElementById("pageNext").disabled = true;
				document.getElementById("tbody").innerHTML="";
				
			} else {
				document.getElementById("pageNext").disabled = false;
				let list = [];
				list = (t.split("]"));
				itemList = list;
				console.log(itemList.length);
				changePage(currentpage);

			}

		}
	}

	let button = -1;
	xhttp.open("POST", "AdminServlet?submit=showItemwithSearch&admincurrentPage=" + current_page + "&adminrecordsPerPage="
			+ recordsPerPage+"&allItemSearch="+search+"&sort="+sort, true);
	xhttp.send();

};

</script>
<body class="backgroundimg" style="background-image:url(emptybg.jpg);" onload="getAllProductList(1)">

 <%if(session.getAttribute("user")!=null){ %> 
       <h2>
         ${message}
         </h2> 
<div>      
				<div>
				<span style="font-weight: bold;margin-left:100px;">Sort By</span> <select id="sortPage"
						onchange="sortPage()"    style="background-color: black; color:white"
						 class="dropdown">
						<option value="All Items">All Items</option>
						<option value="Out Of Stock">Out Of Stock</option>
						<option value="In Stock">In Stock</option>
					</select>
				<span style="margin-left:100px;"><input id="searchbar" type="text"  name="search"
				placeholder="Search... " onkeyup="getAllProductList(1)"><button onclick="getAllProductList(1)" style="background-color:black;color:white;"> <i class="fa fa-search"></i></button> </span>
					
					<span style="font-weight: bold;margin-left:100px;">Number
						Of Products Per Page</span> <select id="itemsPerPage"
						onchange="itemsPerPage()"    style="background-color: black; color:white"
						 class="dropdown">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
					</select>

				</div>
				<div   class="tableFixHead" Style="margin-top: 20px;">
<table style="width: 80%;margin-left: 10%; margin-right: 10%; text-align:center;">
        <thead      style="background-color: #660033 ;">
          <tr >
       
        
         
          
            <th scope="col">ID</th>
            <th scope="col">Name</th>
                        <th scope="col">Weight</th>
            
            <th scope="col">Category</th>
            <th scope="col"><i class="fa fa-inr"></i> Price</th>
            <th>Quantity Available</th>
            <th>Offer Available</th>
            <th scope="col">Edit <i class='fas fa-pen-fancy'></i></th>
          </tr>
        </thead>
        <tbody id="tbody">
        
        </tbody >
      </table>
       </div>
       <div id="page" style="float: right; margin-right:100px;">
					<button class="buttonpage" style="	background-color:   rgb(102, 0, 51,0.7);"
					id="pagePrev" onclick="prevPage()">Previous</button>
					<button class="buttonpage" id="pageNext" style="	background-color:   rgb(102, 0, 51,0.7);" onclick="nextPage()">Next</button>
				</div>
         
        </div>
	<%}
 else{
		request.setAttribute("message", "LOGIN EXPERIED");

request.getRequestDispatcher("/index.jsp").forward(request,response);}
%>
 
      
     

</body>
</html>
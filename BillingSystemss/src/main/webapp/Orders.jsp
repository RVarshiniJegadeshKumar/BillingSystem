<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ include file="UserHeader.jsp" %>
<%@page import="java.sql.*"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="ProductList.css">

</head>
<script>
var current_page = 1;
var recordsPerPage = document.getElementById("ordersPerPage").value;

console.log(recordsPerPage);
var orderList=[];
function ordersPerPage(){
	getorderList(current_page);
}

function prevPage()
{
    if (current_page > 1) {
        current_page--;
        getorderList(current_page);
    }
}

function nextPage()
{
   
        current_page++;
        getorderList(current_page);
    
}
    
function changePage(page)
{
  
	document.getElementById("tbody").innerHTML = "";
 var j=0
    for (var i=0;i<orderList.length; i++) {
    	document.getElementById("tbody").innerHTML += orderList[i];
    	
    }
   

    if (page == 1) {
    	document.getElementById("pagePrev").disabled = true;
    } 
    else{
    	document.getElementById("pagePrev").disabled = false;
    }

   
};
function getorderList(currentpage){
	 recordsPerPage = document.getElementById("ordersPerPage").value;

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
		let t = this.responseText;
		let list=[];
		list=(t.split("]"));
		if(t==""){
			 current_page--;
				console.log(" current"+ current_page);

			document.getElementById("pageNext").disabled = true;
	    }else
	    	{
	    	document.getElementById("pageNext").disabled = false;
	    	orderList=list;
	    		changePage(currentpage);
	    	}
	
		
		}
	}

	let button = -1;
	xhttp.open("POST", "UserOrderServlet?userCartDel=OrderHistory&currentPage="+current_page+"&recordsPerPage="+recordsPerPage, true);
	xhttp.send();


};

</script>
<body onload="getorderList(1)">
<div>
<span style="margin-left: 500px; font-weight: bold;">Number
						Of Products Per Page</span>
<select id="ordersPerPage" onchange="ordersPerPage()" style="background-color: #ffd633;" class="dropdown">
		<option value="5">5</option>
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20">20</option>
	</select>
<%if(session.getAttribute("user")!=null){ %>
<div   class="tableFixHead" Style="margin-top: 10px;height:290px;">
<table style="width: 80%;margin-left: 10%; margin-right: 10%; text-align:center;">
<thead>
                    <tr style="background-color: #ffcc00;">
                        <th>Order ID</th>
                        <th>Customer Username</th>
                        <th>Total No. of Items</th>	
                        <th>Offer Applied</th>					
                        <th>Net Amount</th>
                        <th>View Details</th>
                    </tr>
                    </thead>
         <tbody id="tbody">
         </tbody>
      
                    </table>
                    
                   
                    	<div id="page"  style="float: right;margin-right: 10%;"><button id="pagePrev"  class="buttonpage" onclick="prevPage()">Previous</button><button id="pageNext" class="buttonpage" onclick="nextPage()">Next</button></div>
                  </div>
                   </div>
        <%
 } else{
		request.setAttribute("message", "LOGIN EXPERIED");

request.getRequestDispatcher("/index.jsp").forward(request,response);}
%>   

</body>
</html>
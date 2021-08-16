<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style>
h1
{
color:  #00b33c;
text-align: center;
font-size: 100px;
}
p {
  animation: color-change 1s infinite;
  font-weight:bold;
  text-align: center;
  font-size:30px;
}
.1{
}
.topPrducts{
text-align:center;
 font-weight:bold;
  font-size:30px;
}

@keyframes color-change {
  0% { color:   #ff0000; }
  50% { color:    #0000cc ; }
  100% { color:   #ff0000; }
}
</style>
<script type="text/javascript">
function getTop3Selling(){
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let text=this.responseText;
			let topList=text.split("]");
			console.log(topList);
			for(let i=0;i<3;i++){
				document.getElementById(i).innerHTML=topList[i];
			}
		}
	}
	xhttp.open("POST","AdminServlet?submit=top3selling",true);
	xhttp.send();
}
</script>
</head>
<body onload="getTop3Selling()" class="backgroundimg" style="background-image:url(emptybg.jpg);">
<% String user=request.getParameter("username");
session.setAttribute("user",user);  
%>
<h1 style="text-align:center;">welcome admin!</h1>
<div >
	<p>" Here.. your Top 3 Selling products... Stock up more.."</p>
	<div class="topPrducts"><div style="margin-right:200px;color: #ff6600;">
		<span id=0 onclick="location.href='AllItems.jsp'"> </span>
	</div>
	
	<div style="margin-right:100px ;color:white;">
	<span  id=1 onclick="location.href='AllItems.jsp'"> </span>
	</div>
	<div style="color: #004d1a">
	<span id=2 onclick="location.href='AllItems.jsp'"> </span>
	</div>
	</div>
</div>
</body>

</html>
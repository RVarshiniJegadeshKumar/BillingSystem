


<html lang="en">
<head>
<meta charset="utf-8">

<title>LoginPage</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
.login{
	border-style: solid;
	border-color:#000099;
	width:25%;
	margin-left:550px;
	margin-top:50px;
	
}
.backgroundimg{
background-image:url(edititem.jpeg);
 background-repeat: no-repeat;
  background-size: cover;
    height: 100%; 

}
.input-icons {
margin-left:10px;

}
label{
font-weight:bold;
margin-left:5px;
margin-top:20px;
}
button{
	border-radius: 6px;
	margin-left:50px;
	  padding: 10px;
  text-align: center;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
   background-color:#0000e6;
   color:white;
    box-shadow: 0 5px #999;

}
a{
	margin-left:50px;

}
.input-icons i {
			position: absolute;
			  color: white;
			  background: #0000e6;
			  padding: 8px;
			

}
.input-icons input{
  display: flex;
   padding: 6px;
   margin-left:29px;
   			  margin-top:5px;
   
   
}
h1{

text-align:center;
}
</style>

</head>
<body>
	<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>User</title>
</head>

<body class="backgroundimg">
	<%
	if (session.getAttribute("user") == null) {
	%>
	<div style="margin-top:100px">
	<h1>Start Shopping with ABC Shopping</h1>
	</div>


	<form class="" method="post" action="LoginServlet">
	<div class="login" >
	
	<label for="username" ">Username</label>
<div class="input-icons">
		<i class="fa fa-users fa"></i> <input type="text"  
			name="username" placeholder="Enter your Username" /><br>
			</div>
			 <label
			for="password" >Password</label><div  class="input-icons"><i class="fa fa-lock fa-lg"
			aria-hidden="true"></i> <input type="password"
			name="password" id="password" placeholder="Enter your Password" > <br>
			</div>
			<div>
			<button name="submit" id="submit" value="Admin Login">Admin</button><button name="submit" id="submit" value="Customer Login">User</button>
			</div><br>
			 <a 
			href="UserRegistration.jsp">New User ? Register Now!</a><br>
			<h4>${message}</h4> 
			</div>
	</form>



	<%
	} else {
	request.getRequestDispatcher("/AdminOperation.jsp").forward(request, response);
	}
	%>
</body>

</html>




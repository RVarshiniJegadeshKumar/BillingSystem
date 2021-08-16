<!DOCTYPE html>


<html lang="en">
    <head> 


		
		<title >User</title>
	</head>
	<body style=" background:url(https://i.ytimg.com/vi/4kfXjatgeEU/maxresdefault.jpg);">
	<%if(session.getAttribute("user")==null){ %>
	<p>
	</p>
	<form  method="post" action="LoginServlet">
						
	

	<table style="border:1px solid black;margin-left:auto;margin-right:auto;background-color:whitesmoke">
	<tr>
	</tr>
	<tr>
				<th><h4 style="color:blue;">Login </h4></th>
					</tr>
						

						
						

						<tr>
						<th>	<label style="color:blue;"> <b>Username</b></label></th>
						</tr><tr>
							<td></td>
									<td> <input type="text" class="form-control" name="username"   placeholder="Enter your Username"/></td>
							
						
</tr>
<tr>
						
							<th> <label style="color:blue;">Password</label></th>
							</tr><tr>
							<td></td>
						
								<td>
									<input type="password"  name="password" id="password"  placeholder="Enter your Password"/></td>
								</tr>	<tr> 
								</tr>
								<tr><td colspan="3" >
							<input type="submit" name="submit"   value="Customer Login" style=" width:50%; margin-left:25%   ; margin-right:25; background-color:blue;color:whitesmoke;" >
						</td>
						
							</tr>
							<tr>
													
						<td colspan="3" style="text-align:center ;">	<a href="UserRegistration.jsp" style="color:blue;">New User ? Register Now!</a></td></tr>
							<tr>
							<td colspan="3" style="text-align:center;color:whitesmoke" >${message }
					</td></tr>

				</table>
				
					</form>

    <%}else{
    	request.getRequestDispatcher("/UserOperation.jsp").forward(request,response);
    	}%>
    
   
	</body>

</html>

		
			
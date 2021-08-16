<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%session.setAttribute("user",null);
Cookie ck=new Cookie("name",null);  
ck.setValue(null);  
response.addCookie(ck);  
request.getRequestDispatcher("/index.jsp").forward(request,response);
ck.setMaxAge(0);

%>
</body>
</html>
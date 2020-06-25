<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

    <%
    	HttpSession hs = request.getSession();
    	
    	hs.setAttribute("user",""); 
    	
    	response.sendRedirect("index.jsp"); 	
    	
    %>




</head>
<body>

</body>
</html>
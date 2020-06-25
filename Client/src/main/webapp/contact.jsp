<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	    <%
    
    	// Get session obj
    	HttpSession hs = request.getSession();
    	
    	// Get the current user
    	String user = (String)hs.getAttribute("user");
    	
    	%>
    <title>S&Sneakers</title>
    <link rel=stylesheet type="text/css" href="./styles/style.css">
    <script src="./scripts/script.js"></script>
</head>   

<body>
    <div class= header-banner-container>
        	
        	
        	
            <nav>
                <ul>
  					<li class="menu-item"><a href="index.jsp">Home</a></li>
  					<li class="menu-item"><a href="shop.jsp">Shop</a></li>
  					<li class="menu-item"><a href="contact.jsp">Contact</a></li>
  					<% 
				    	if (user == null || user.equals(""))
				    	{
				    		// not log in
				    		out.print("<li class='menu-item'><a href='LoginPage.html'> please log in </a></li> ");
				    	}
				    	else
				    	{	
				    		// account info
				    		out.print("<li class='menu-item'><a>" + user + "  Welcome!" + "</a></li>");
				    		out.print("<li class='menu-item'><a class='menu-item' href='logout.jsp'> log out </a></li> ");
				    		out.print("<li class='menu-item'><a class='menu-item' href='account.jsp'> your account </a></li> ");
				    		
				    	}
				    %>
		  		</ul>
            </nav>
           
            </div>
            
            
            <div class="header-banner">
      		  <div class="banner-text-heading">&nbsp<br>S&Sneakers<br>contact</div>
		      
      		 
      	 <a href="cart.jsp">
                <div class=menu-item-cart-underline></div>
                <div class=menu-item-cart></div>
            </a>
   		</div> <!-- end of .header-banner -->
            
            
            <div id=header-banner-home>
            <div class="header-banner-text-home">
              
               
            </div>
            
        </div>
        
    </div>
    
    <div class=clearboth></div>
    
    
    
    <div class="feature1">
   		<div><span class="feature-text1">Contact</span></div>
	</div> 
    
    


<div class="bill">
    <h1>Email: tsh510105@gmail.com</h1>
    <h1>Phone: (306)7164639</h1>
</div>
    
 <div id="footer">
                <p>&#169 S&Sneakers</p>
                <p>PHOTOGRAPHY BY</p>
                <p>xxx-xxx Cres<br>SASKATOON. SK</p>
                <p>Google Image<br>Sneakers</p>
            </div>
	
    
   
    
</body>
    
</html>

<style>


textarea{
	background-color: lightgrey;
	width:80%;
}
	
input[type=text] {
  background-color: lightgrey;
}


input[type=text1] {
  background-color: lightgrey;
}

input[type=text], select {
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;

  
}

input[type=text1], select {
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
 
   
}

.bill{
margin-top:5vw;
margin-left:35vw;
}

</style>
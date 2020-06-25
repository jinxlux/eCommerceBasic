<!DOCTYPE html>
<html>
<head>
	    <%
    
    	// Get session obj
    	HttpSession hs = request.getSession();
    	
    	// Get the current user
    	String user = (String)hs.getAttribute("user");
    	
    	%>




	<meta charset="UTF-8">
    <title>S&Sneakers</title>
    <link rel=stylesheet type="text/css" href="./styles/style.css">
    <script type="text/javascript" src="js/jquery.min.js" ></script>
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
      		  <div class="banner-text-heading">&nbsp<br>S&Sneakers<br>&nbsp</div>
		      
      		 
      	 <a href="cart.jsp">
                <div class=menu-item-cart-underline></div>
                <div class=menu-item-cart></div>
            </a>
   		</div> <!-- end of .header-banner -->
            
            
            <div id=header-banner-home>
            <div class="header-banner-text-home">
              
               
           
        </div>
        </div>
        
   
    <div class=clearboth></div>
    
    
    
    <div class="feature1">
   		<div><span class="feature-text1">Popular Products</span></div>
	</div> 
    
    
    
    <div class=big-display-right>
		<span class=big-display-right-line-1>
			<p>Have a Nike Day- White</p>
		</span>
		<img class=display-right-img-l src="images/product1.jpeg">
		<span class=big-display-right-line-2>
			AIR FORCE 1
		</span>
		<span class=big-display-right-line-3>
			$110
		</span>
	</div>
	
	<div class=big-display-right>
		<span class=big-display-right-line-1>
			Nike's release lineup for Air Max Day 2019
		</span>
		<img class=display-right-img-l src="images/product2.jpeg">
		<span class=big-display-right-line-2>
			AIR MAX 97 
		</span>
		<span class=big-display-right-line-3>
			$190 
		</span>
	</div>
	
	
	<div class=big-display-right>
		<span class=big-display-right-line-1>
			Multi-Color designed by Tinker Hatfield
		</span>
		<img class=display-right-img-l src="images/product3.jpeg">
		<span class=big-display-right-line-2>
			AIR MAX 1 
		</span>
		<span class=big-display-right-line-3>
			$110
		</span>
	</div>
   
   
    <div id="footer">
                <p>&#169 S&Sneakers</p>
                <p>PHOTOGRAPHY BY</p>
                <p>xxx-xxx Cres<br>SASKATOON. SK</p>
                
                <p>Google Image<br>Sneakers</p>
            </div>
   
    
</body>
    
</html>

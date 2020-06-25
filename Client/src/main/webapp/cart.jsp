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
     <script type="text/javascript" src="js/jquery.min.js" ></script>
    <script src="./scripts/script.js"></script>
</head>   
	<script>
		
	   // setBilling info
	   function setBilling(){
		    var name="";
		    name= '<%=user %>';
		  	if (name == "null" || name == "" || name == null){
				return;
			}
			$.ajax({
				type: 'GET',
				url: 'webapi/users/user/billing/' + name,
				dataType: 'json',          
				cache : false,
				error:function(){alert('error!')},
				success: function(obj){	
					var str = " ";
					if (obj != null){
						$('#firstname').val(obj.firstname);
						$('#lastname').val(obj.lastname);
						$('#address').val(obj.address);
						$('#postal').val(obj.postal);
					}
				}	
			});
	   }
	   
	
	
	
		
	   // do check put shoes in checked 
	   function check(){
		    var name="";
		    name= '<%=user %>';
		  	if (name == "null" || name == "" || name == null){
				window.location.href="LoginPage.html";
				return;
		   	}

			var req2 = {};
			
			var req = {};
			
			req2.name = name;
			
			req.name = name;

			req.firstname = $('#firstname').val().trim();
			req.lastname = $('#lastname').val().trim();
			req.address = $('#address').val().trim();
			req.postal = $('#postal').val().trim();
			
	        if(req.firstname == "")
	        {
	        	alert("Firstname is required!");
	        	return;
	        }
	        
	        if(req.lastname == "")
	        {
	        	alert("Lastname is required!"); 
	        	return;
	        }
	        
	        if(req.address == "")
	        {
	        	alert("Address is required!"); 
	        	return;
	        }
	        
	        if(req.postal == "")
	        {
	        	alert("Postal code is required!");
	        	return;
	        }
		   
			$.ajax({
				type: 'PUT',
				url: 'webapi/users/user/check/' + req2.name,
				error:function(){alert('error!')},
				success: function(obj){	
					//alert('success!')
				}	
				});
			
			$.ajax({
				type: 'POST',
				url: 'webapi/users/user/billing',
				data: JSON.stringify(req), 
				contentType: "application/json",
				dataType: 'json',          
				cache : false,
				error:function(){alert('error!')},
				success: function(obj){	
					alert('Thank you for comfirming payment!');
					
				
				}	
			});
			
	   }
	   
	   
	   $(function(){
		   $("button").click(function(){
			   var value = $(this).attr("id");
			    var name="";
			    name= '<%=user %>';
			  	if (name == "null" || name == "" || name == null){
					window.location.href="LoginPage.html";
					return;
			   	}
			   
				var req = {};
				
				req.name = name;
				req.unchecked = value;
		    		$.ajax({
		    	type: 'PUT',
		    	url: 'webapi/users/user/unchecked/delete/' + req.unchecked, 
				data: JSON.stringify(req),
				contentType: "application/json",
				dataType: 'json',   
		    	error:function(){alert('error!')},
				success: function(obj){	
				    location.reload();
					
				}	
			});
		   });
	   })
	   
	   // add item cart
	   function addItemsTO(Itemum, item, items, itemID) {
		    var name="";
		    name= '<%=user %>';
		  	if (name == "null" || name == "" || name == null){
				window.location.href="LoginPage.html";
				return;
		   	}
		    var temp = document.createElement("div");
		    temp.innerHTML = itemName[itemID];
		    item.appendChild(temp);
		    temp = document.createElement("div");
		    temp.innerHTML = parseInt(Itemum);
		    item.appendChild(temp);
		    temp = document.createElement("div");
		    temp.innerHTML = parseInt(Itemum*itemPrice[itemID]);
		    item.appendChild(temp);
		    temp = document.createElement("button");
		    temp.innerHTML = "x";
		    temp.onclick = function() {
		    	   var ind = itemID+1;
				   var value = ind;
				    var name="";
				    name= '<%=user %>';
				   
					var req = {};
					
					req.name = name;
					req.unchecked = value;
			    		$.ajax({
			    	type: 'PUT',
			    	url: 'webapi/users/user/unchecked/delete/' + req.unchecked, 
					data: JSON.stringify(req),
					contentType: "application/json",
					dataType: 'json',   
			    	error:function(){alert('error!')},
					success: function(obj){	
					    location.reload();
					}	
				});
		    };
		    item.appendChild(temp);
		    items.appendChild(item);
}
	   
	    
	   	 // load page
		  function reload(){
			    var name="";
			    name= '<%=user %>';
			  	if (name == "null" || name == "" || name == null){
					window.location.href="LoginPage.html";
					return;
			   	}
				$.ajax({
					type: 'GET',
					url: 'webapi/users/user/uncheck/' + name,
					dataType: 'json',          
					cache : false,
					error:function(){alert('error!')},
					success: function(obj){	
						
						var str = "";
						for (var uncheck of obj){
							//console.log(uncheck.shoe);
							if (str == ""){
								str = str + uncheck.shoe;
							}
							else{
								str = str +"," + uncheck.shoe;
							}

						}
						split(str);
					}	
				});
		  }

	   
window.onload = function(){
	reload();

	   
}
	
	
	</script>

<body onpageshow="setBilling()">
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
      		  <div class="banner-text-heading">&nbsp<br>S&Sneakers<br>cart</div>
		      
      		 
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
   		<div><span class="feature-text1">cart</span></div>
	</div> 
    
    
      <div id="menu">
                <p><span id="span-two" style="width: 100%">ITEM</span></p>
                
                <div id="items">
                    <br>
                </div>
            </div>
            
            <div id="totalPrice">

                <P>TOTAL</P>
                <p id="to"></p>
                <script>TotalPrice();</script>
            </div>
            
<div class="feature1">
   			<div class="feature-text1">billing</div>
		</div> <!-- end of feature -->
		

<div class="bill">
    <ol>
      <input type="text11" name="FirstName" id="firstname" placeholder="FIRSTNAME">
     <input type="text22" name="LastName" id="lastname" placeholder="LASTNAME">
     <input type="text33" name="FirstName" id="address" placeholder="ADDRESS">
     <input type="text44" name="LastName"  id="postal"  placeholder="POSTCODE">

     </ol>
</div>



<div class="feature1">
   			<div class="feature-text1">PAYMENT</div>
		</div> <!-- end of feature -->
		
		
		
		

    <img class=wechat src="images/q1.png">
	
	<img class=alipay src="images/q2.png">
	
   	<button id=finish onclick="check()" >COMPLETE PURCHASE</button>


    
 <div id="footer">
                <p>&#169 S&Sneakers</p>
                <p>PHOTOGRAPHY BY</p>
                <p>xxx-xxx Cres<br>SASKATOON. SK</p>
                <p>Google Image<br>Sneakers</p>
            </div>
    
</body>
    
</html>



<style>
#span-two{
    position:absolute;
    right:35vw;
}
    input[type=text11] {
  background-color: lightgrey;
}
input[type=text22] {
  background-color: lightgrey;
}
input[type=text33] {
  background-color: lightgrey;
}
input[type=text44] {
  background-color: lightgrey;
}
input[type=text2] {
  background-color: lightgrey;
}

input[type=text3] {
  background-color: lightgrey;
}
input[type=text4] {
  background-color: lightgrey;
}
input[type=text5] {
  background-color: lightgrey;
}
input[type=text11], select {
  position: relative;
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  right:-5vw;

  
}

input[type=text22], select {
position: relative;
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
   right:-8vw;
}


input[type=text33], select {
position: relative;
  width: 40%;
  padding: 12px 20px;

  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
   right:-5vw;
}


input[type=text44], select {
position: relative;
 width: 40%;
  padding: 12px 20px;
 
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
 right:-8vw;
   
}

input[type=text2], select {
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
   
}

input[type=text3], select {
  width: 60%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
   
}

input[type=text4], select {
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
   
}

input[type=text5], select {
  width: 40%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
   
}

#finish{
background-color:black;
color:white;
text-align: center;
     
   position: relative;
   right:20vw;
   display: inline;
   font-size:1vw;
   bottom:-10vw;
    height:5vw;

}

.wechat{

	bottom:-5vw;
	right:55vw;
	width:30vw;
	position:relative;
	right:-53vw;
}	
.alipay{

	bottom:-5vw;
	right:21vw;
	width:30vw;
	position:relative;
	right:17vw;
}

#footer{
	position: relative;
	bottom:-10vw;
	width:100vw;
	
}
</style>
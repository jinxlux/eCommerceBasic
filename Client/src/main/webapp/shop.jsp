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
    <script type="text/javascript" src="js/jquery.min.js" ></script>
</head>   

<script>

$(document).ready(selection("0~600","0~15","all"));



function select(){
	  var mySelect = document.getElementById("selectorb");
	  var index = mySelect.selectedIndex;
	  var brand = mySelect.options[index].text;
	 
	  var mySelect = document.getElementById("selectorp");
	  var index = mySelect.selectedIndex;
	  var priceRange = mySelect.options[index].text;
	  
	  var mySelect = document.getElementById("selectors");
	  var index = mySelect.selectedIndex;
	  var sizeRange = mySelect.options[index].text;
	  
	  selection(priceRange,sizeRange,brand);
}


function selection(priceRange,sizeRange, brand){
	imageS = "";
	buttons = "";
	$.ajax({  
	    url:"webapi/shoes/shoeall/"+ priceRange +"/"+ sizeRange + "/" + brand,  
	    type:'GET',  
	    dataType:'json',  
	    success:function(images){ 
	    	$.each(images, function(i, image){
	    		buttons = '<button class = "shop'+image.brand+image.id + '"' + " id = " + image.id +' style="cursor:pointer" type="button">'+ "Add to cart</button>";
	    		imageS += '<img class='+image.brand+image.id + " id = " + image.id  + ' style="cursor:pointer" src="'+image.photo +'">' + buttons;
	    	});
	    	document.getElementById("images").innerHTML = imageS;
	    	handlebuttons();
	    	handleImages();
	    },  
	    error:function(XMLHttpRequest, textStatus, errorThrown){
	    	alert("error");
	        switch(XMLHttpRequest.status){  
	            case 401:  
	                break;  
	            case 404:  
	                break;  
	            case 500:  
	                break;  
	        }  
	    }  
	});
}


function jump(){
    window.location.href="ShoeInfo.jsp";
}

function handlebuttons(){
    $("button").click(function() {
    	// login ?
        var name="";
        name= '<%=user %>';
      	if (name == "null" || name == ""){
    		window.location.href="LoginPage.html";
    		return;
       	}
      	
        var value = $(this).attr("id");
        
		var req = {};
		
		req.name = name;
		req.unchecked = value;
    		$.ajax({
    	type: 'PUT',
    	url: 'webapi/users/user/unchecked/' + req.unchecked, 
		data: JSON.stringify(req),
		contentType: "application/json",
		dataType: 'json',   
    	error:function(){alert('error!')},
		success: function(obj){	
			//alert('success!');
			
			
		}	
	});
        //alert("Poriduct ID = "+ value + " is added in Car");
    });
}



function handleImages(){
    $("img").click(function() {
        var name="";
        name= '<%=user %>';
      	if (name == "null" || name == ""){
    		window.location.href="LoginPage.html";
    		return;
       	}
        var id = $(this).attr("id"); 
        var src = $(this).attr("src");
        localStorage.image = src;
        localStorage.shoesid = id;
        jump();
    });
}




function needToLogin(){
    var name="";
    name= '<%=user %>';
  	if (name == "null" || name == ""){
		window.location.href="LoginPage.html";
		return;
   	}
}








</script>

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
      		  <div class="banner-text-heading">&nbsp<br>S&Sneakers<br>Shop</div>
		      
      		 
      	 <a href="cart.jsp">
                <div class=menu-item-cart-underline></div>
                <div class=menu-item-cart></div>
            </a>
   		</div> <!-- end of .header-banner -->
            
            
            <div id=header-banner-home>
            <div class="header-banner-text-home">
              
               
            </div>
             
        </div>
       
  
       
    
    
    <div class="feature1">
   		<div><span class="feature-text1">Our Products</span></div>
	</div> 
    
    <div class ="select">
   	<label for="select">brand:</label>
    <select class='bar' id="selectorb" onchange = "select()">
    
	<option> all </option>
	<option> nike </option>
	<option> addidas </option>
	</select>
    
    <label for="select">price:</label>
    <select class='bar' id="selectorp" onchange = "select()">
	<option> 0~600 </option>
	<option> 0~100 </option>
	<option> 100~150 </option>
	<option> 150~200 </option>
	<option> 200~250 </option>
	<option> 250~300 </option>
	<option> 300~350 </option>
	<option> 350~400 </option>
	<option> 400~450 </option>
	<option> 450~500 </option>
	<option> 500~600 </option>
	</select>
 	
 	<label for="select">size:</label>
	<select class='bar' id="selectors" onchange = "select()">
	<option> 0~15 </option>
	<option> 0~8 </option>
	<option> 8~12 </option>
	<option> 12~15 </option>
	</select>
	</div>




	<div class = "s" id = "images">

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

.bar{
	width:10vw;
	font-size:1.5vw;
}

.feature1{
    position: relative;
    bottom:1vw;
	
}


#footer{
	position: absolute;
	bottom:-50vw;
	width:100vw;
	
}


.s{
	position: relative;
	bottom:-10vw;
}



.select{
	position: relative;
	right:-30vw;
	margin-top:5vw;
}












.addidas1{

	bottom:-40vw;
	right:55vw;
	width:30vw;
}	
.addidas2{

	bottom:-40vw;
	right:21vw;
	width:30vw;
}
	
.nike3{
	
	bottom:-80vw;
	right:55vw;
	width:30vw;
}
.nike4{

	bottom:-80vw;
	right:18vw;
	width:30vw;
}

.nike5{

	bottom:-80vw;
	right:18vw;
	width:30vw;
}
.nike6{

	bottom:-80vw;
	right:18vw;
	width:30vw;
}
.nike7{

	bottom:-80vw;
	right:18vw;
	width:30vw;
}

.addidas8{

	bottom:-40vw;
	right:21vw;
	width:30vw;
}
.addidas9{

	bottom:-40vw;
	right:21vw;
	width:30vw;
}
.addidas10{

	bottom:-40vw;
	right:21vw;
	width:30vw;
}
	
.shopaddidas1{
	background-color:black;
	color: white;

	bottom:-56vw;
	right:60vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}

.shopaddidas2{
	background-color:black;
	color: white;

	bottom:-56vw;
	right:25vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}

.shopnike3{
	background-color:black;
	color: white;

	bottom:-96vw;
	right:60vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}

.shopnike4{
	background-color:black;
	color: white;

	bottom:-96vw;
	right:25vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}

.shopnike5{
	background-color:black;
	color: white;

	bottom:-96vw;
	right:25vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}

.shopnike6{
	background-color:black;
	color: white;

	bottom:-96vw;
	right:25vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}
.shopnike7{
	background-color:black;
	color: white;

	bottom:-96vw;
	right:25vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}

.shopaddidas8{
	background-color:black;
	color: white;

	bottom:-56vw;
	right:60vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}
.shopaddidas9{
	background-color:black;
	color: white;

	bottom:-56vw;
	right:60vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}
.shopaddidas10{
	background-color:black;
	color: white;

	bottom:-56vw;
	right:60vw;
	height:5vw;
	width:15vw;
	font-size:2vw;
}
</style>
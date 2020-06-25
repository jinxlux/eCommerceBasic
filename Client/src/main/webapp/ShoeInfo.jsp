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

<meta charset="UTF-8">
<title>product information</title>
    <link rel=stylesheet type="text/css" href="./styles/style.css">
    <script src="./scripts/script.js"></script>
    <script type="text/javascript" src="js/jquery.min.js" ></script>
</head>

	<script>
	
	function changeBackG(){
		// get the background image of the page
		document.getElementById('back').style.backgroundImage ='url('+localStorage.image+')';
	}
	
	function information(){
		// use ajax get the information from backend
		$.ajax({  
		    url:"webapi/shoes/shoeID/"+localStorage.shoesid,  
		    type:'GET',  
		    dataType:'json',  
		    success:function(json){ 
		    	show(json);
		    },  
		    error:function(XMLHttpRequest, textStatus, errorThrown){
		    	alert("error");  
		    }  
		});
	}
	
	function show(result){
		 // show the information of a specific shoe
	     var name = document.createElement("p");
	     name.innerHTML = "Style: " + getName(result.id-1);
	    	
	     var brand = document.createElement("p");
	     brand.innerHTML = "Brand: " + result.brand;
	     
	     var price = document.createElement("p");
	     price.innerHTML = "Price: " + result.price;
	     
	     var size = document.createElement("p");
	     size.innerHTML = "Size: " + result.size;
	     
	     document.getElementById('product').appendChild(name);
	     document.getElementById('product').appendChild(brand);
	     document.getElementById('product').appendChild(price);
	     document.getElementById('product').appendChild(size);
	     document.getElementById('product').appendChild(size);
	     
	     handlebuttons(result.id);
	}
	
	function handlebuttons(ind){
		// handle button click functions here
	    $("button").click(function() {
	    	//if button's id is 'back', ignore
	    	var id = $(this).attr("id"); 
	    	if(id == "back"){
	    		return;
	    	}
	    	// else, add the shoe to the car
	    	else if (id == 'buy'){
	            var name="";
	            name= '<%=user %>';
	            var value = ind;
	            
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
	    	}
	    	else{
	    		alert("Product is added in your car");
	    	}

	    });
	}
	
	function buy(){
		
	}
	
	</script>

    <style>
    
	body{
    margin:0;
    padding:0;
    height:100%;
    z-index: 0;
    background-position: center;
    background-size:240px 180px;
    background-repeat:repeat;
    font-size:1.2vw;

    }
    


    #content{
        z-index: 1;
        margin-top:8vw;
        margin-left: 28vw;
        width: 30vw;
        height:100%;
        border-style: groove;
        border-radius:25px;
        padding-left:5vw;
        padding-right:5vw;
        padding-top:2vw;
        background-color:white;
        padding-bottom:2vw;
    }
    
    button{
        cursor: pointer;
        font-size: 1vw;    
        transition:0.6s ease;
        padding: 0.5vw;
        border-radius:25px;
        width: 30vw;
        background-color: antiquewhite;
        margin-top: 1vw;
        margin-bottom: 1vw;
    }
    
    
    
    </style>
    

<body id = "back" onload = "changeBackG(),information(),up(),down()">

	<div id="content">
	
		<div id='product'>
	 	
	 	</div>
	 	<div><img style= "cursor:pointer" height="30" width="40" src= "images/up.png" onClick = "Updateup()" ></div>
	 	<div id = "up"></div>
	 	<div><img  style= "cursor:pointer" height="30" width="40" src= "images/down.png" onClick = "Updatedown()" ></div>
	 	<div id = "down"></div>
	 	<button id='buy'> Buy This </button>
	 	<a href = "shop.jsp"><button id = "back"> Go  Back </button></a>
	 	
		
	</div>>


</body>
</html>
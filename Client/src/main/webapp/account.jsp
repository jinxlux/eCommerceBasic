<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <%
    	// check whether log in
    	HttpSession hs = request.getSession();
    	String user = (String)hs.getAttribute("user");
    	if (user == null || user.equals(""))
    	{
    		response.sendRedirect("login.jsp");
    	}   
    	
    	
    %>
    
<head>
<meta charset="ISO-8859-1">
<title>account page</title>
    <script type="text/javascript" src="js/jquery.min.js" ></script>
    
    <script>
    
    // get attribute by name
    var name="";
    name= '<%=user %>';
    
    function upload() {
        
	var req = {};
		
	req.name = name;
	
		$.ajax({
	type: 'GET',
	url: 'webapi/users/user/' + req.name, 
	error:function(){alert('error!')},
	success: function(obj){	
		//alert("success")
		showResult(obj);
	}	
	});
	}
    
    // list all attribute
    function showResult(result){
    	
     var UID = document.createElement("p");
     UID.innerHTML = "UID: " + result.id;
    	
     var name = document.createElement("p");
     name.innerHTML = "UserName: " + result.name;
     
     var email = document.createElement("p");
     email.innerHTML = "Email address: " + result.email;
     
     var time = document.createElement("p");
     time.innerHTML = "Time Register: " + result.time;
     
     
     
     var checked = document.createElement("div");
	 var p = document.createElement("p");
	 p.innerHTML = "Checked:";
	 checked.appendChild(p);
     if (result.checked != null){
         var ch = jQuery.parseJSON(result.checked);
    	 for (var i in ch){
    		 var p = document.createElement("p");
    		 var str = "";
    		 str = str + "Check Time " + (parseInt(i)+1) + ":  ";
    		 
    	     var Timechecked = jQuery.parseJSON(ch[i].check);
    	     var str2 = "";
    		 for (var row of Timechecked){
    			 str2 = str2 + " ShoesID: " + row.shoe + "  ";
    		 }
    		 str = str + str2 + "\n";
    		 p.innerHTML = str;
    		 checked.appendChild(p);
    	 }

         
        
     }
     
     var billing = document.createElement("p");
	 var p = document.createElement("p");
	 p.innerHTML = "Billing info:";
	 billing.appendChild(p);
     if (result.billing != null){
	     var bill = jQuery.parseJSON(result.billing);
	     
	     var p = document.createElement("p");
		 var str = "";
	     str = str + "FirstName: " + bill.firstname;
		 p.innerHTML = str;
		 billing.appendChild(p);
		 
	     var p = document.createElement("p");
		 var str = "";
	     str = str + "LastName: " + bill.lastname;
		 p.innerHTML = str;
		 billing.appendChild(p);
		 
	     var p = document.createElement("p");
		 var str = "";
	     str = str + "Address: " + bill.address;
		 p.innerHTML = str;
		 billing.appendChild(p);
		 
	     var p = document.createElement("p");
		 var str = "";
	     str = str + "Post Code: " + bill.postal;
		 p.innerHTML = str;
		 billing.appendChild(p);
		 
     }
     
     
     
     
     var unchecked = document.createElement("p");
     if (result.unchecked != null){
         var shoes = jQuery.parseJSON(result.unchecked);
         var str = "";
    	 for (var row of shoes){
    		 str = str + "ShoesID: " + row.shoe + "\n";
    	 }
         unchecked.innerHTML = "unchecked: " + str;
     }
     
    
     
     
     
     document.getElementById('SelfInfo').appendChild(UID);
     document.getElementById('SelfInfo').appendChild(name);
     document.getElementById('SelfInfo').appendChild(email);
     document.getElementById('SelfInfo').appendChild(time);
     document.getElementById('SelfInfo').appendChild(billing);
     document.getElementById('SelfInfo').appendChild(checked);
     document.getElementById('SelfInfo').appendChild(unchecked);
   	 
   }
    
    function GoChangePage(){
		window.location.href="ChangePage.jsp";
    }
    
    
    
    
    </script>
    
    <style>
    
    body{
    margin:0;
    padding:0;
    height:100%;
    background: url(images/shoes.png);
    z-index: 0;
    background-position: center;
    background-size:cover;
    background-repeat:no-repeat;
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
        padding-bottom:2vw;
        background-color:white;
    }
    
    .button1{
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

    .button2{
        cursor: pointer;
        font-size: 1vw;    
        transition:0.6s ease;
        padding: 0.5vw;
        border-radius:25px;
        width: 30vw;
        background-color:orange;
        margin-top: 1vw;
        margin-bottom: 1vw;
    }
    
    
    
    </style>



</head>
<body onpageshow="upload()">
		<div id="content">
		
		<p><%=user %> welcome! 	  <br><br> </p>
		
	 	
	 	<div id='SelfInfo'>
	 	
	 	</div>
	 	
	    <button onclick="GoChangePage()" class="button1"> ChangePassward  </button>
	    <button onclick="window.location.href='index.jsp'" class="button2"> GoMainPage  </button>
	 	
        
      	 </div>


</body>
</html>
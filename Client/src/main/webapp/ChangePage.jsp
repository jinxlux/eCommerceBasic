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
<title>Change Page</title>
	<script type="text/javascript" src="js/jquery.min.js" ></script>
	
	<script>
	
	// change pass ward 
	
    var name="";
    name= '<%=user %>';
	
    function upload() {

        var p;
        p=$('#passward').val();
        if(p == ""){
        	$('#notification').html("old passard is required!");        
        	return;
        }
        
        var p1;
        p1=$('#passward1').val();
        if(p1 == ""){
        	$('#notification').html("new passard is required!");        
        	return;
        }
        
        if(p1.length <=5){
        	$('#notification').html("New Passward should be larger than 5 characters");    
        	return;
        }
        
        var p2;
        p2=$('#passward2').val();
        if(p2 == ""){
        	$('#notification').html("Verify passard is required!");        
        	return;
        }
        
        if(p1!=p2){
        	$('#notification').html("two passwards are not same");  
        	return;
        }
        
        
        
        
    	var req = {};
    		
    	req.oldpassward = $('#passward').val().trim();
    	req.newpassward = $('#passward1').val().trim();
    	
    		$.ajax({
    	type: 'PUT',
    	url: 'webapi/users/user/' + name, 
		data: JSON.stringify(req), 
		contentType: "application/json",
    	error:function(){alert('error!')},
    	success: function(obj){	

    		if (obj == "false"){
            	$('#notification').html("The old passward is wrong");  
    		}
    		else{
    			alert("success to change");
    			window.location.href="LoginPage.html";
    		}
    		
    		
    	}	
    	});
    	}
	
	</script>
	
    <style>
        
    #notification{
        color:red;  
        margin-bottom:1vw;

    }  
    
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
        height:28vw;
        border-style: groove;
        border-radius:25px;
        padding-left:5vw;
        padding-right:5vw;
        padding-top:2vw;
        background-color:white;
    }
    
    
    .border{
        height: 1.8vw;
        width: 30vw;
        
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
    
    </style>
	
	
</head>
<body>
    
    <div id="content">    
                <p1 id= "notification"> </p1>
                <p></p>
				<p1>Old Passward: </p1>
                <p></p>
                <input name="password" type="password" id="passward" class="border">
                <p></p>

                <p1>New Passward: </p1>
                <p></p>
                <input name="password" type="password" id="passward1" class="border">
                <p></p>
                
                <p1>Verify Passward: </p1>
                <p></p>
                <input name="password" type="password" id="passward2" class="border">
                <p></p>

			    <button onclick="upload()" class="button1"> Submit </button>

    </div>

</body>
</html>
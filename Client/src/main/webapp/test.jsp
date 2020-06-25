<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

	<%     
	
		HttpSession hs = request.getSession();
		String user = (String)hs.getAttribute("user"); 
	
	%>
	
<meta charset="ISO-8859-1">
<title>Insert title here</title>
    <script type="text/javascript" src="js/jquery.min.js" ></script>
    <script>
    
    
	   $(function(){
		   $("input:button").click(function(){
			   needToLogin();
			   var value = $(this).attr("name");
			   //console.log(value);
			   
					    var name="";
					    name= '<%=user %>';
					   
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
							alert('success!');
							
							
						}	
					});

			   
			   
			   
			   
		   });
	   })
	   
	   function needToLogin(){
		    var name="";
		    name= '<%=user %>';
		  	if (name == null || name == ""){
				window.location.href="LoginPage.html";
				return;
		   	}
	   }
	   
	   
	   
	   
	   
	   
	   
	   $(function(){
		   $(".bt").click(function(){
			   needToLogin();
			   var value = $(this).attr("name");
			  // console.log(value);
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
					alert('success!');
					
					
				}	
			});
		   });
	   })
	   
	   
	   
	   
	   function check(){
		    var name="";
		    name= '<%=user %>';
			var req2 = {};
			
			req2.name = name;
			
			
			var req = {};
			   
			req.name = name;
			req.firstname = $('#firstname').val().trim();;
			req.lastname = $('#lastname').val().trim();;
			req.address1 = $('#address1').val().trim();;
			req.address2 = $('#address2').val().trim();;
			req.city = $('#city').val().trim();;
			req.province = $('#province').val().trim();;
			req.postal = $('#postal').val().trim();;
			req.country = $('#country').val().trim();;
		   
			$.ajax({
				type: 'PUT',
				url: 'webapi/users/user/check/' + req2.name,
				error:function(){alert('error!')},
				success: function(obj){	
					alert('success!')
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
					alert('success!')
				}	
			});
	   }
	   
	   
    
    </script>
    
    <style>
    
    
    </style>
    
    
</head>
<body>

    <%
    
    	
    	// Get the current user
    	if (user == null || user.equals(""))
    	{
    		// not log in
    		out.print("<a href='LoginPage.html'> please log in </a> ");
    	}
    	else
    	{	
    		// account info
    		out.print(user + ",Welcome!");
    		out.print("<a href='logout.jsp'> log out </a> ");
    		out.print("<a href='account.jsp'> your account </a> ");
    		
    	}
    
    %>

	 <div>
	 
		<p>1</p>
		<input type="button" name="1" class="class" value="submit"> AddCart
		<button class="bt"  name="1"> clean</button>
	</div>

	<div>
	
		<p>123</p>
		<input type="button" name="123" class="class" value="submit" > AddCart
		<button class="bt" name="123"> clean</button>
	</div>
	
	<div>
	
		<p>200</p>
		<input type="button" name="200" class="class" value="submit" > AddCart
		<button class="bt"  name="200"> clean</button>
	</div>
	
	<p></p>
	<button onclick="check()"> check</button>
	<p></p>
	
	<textarea id="firstname" cols="100" rows="3" ></textarea>
    <p></p>
	
	<textarea id="lastname" cols="100" rows="3" ></textarea>
    <p></p>

	<textarea id="address1" cols="100" rows="3" ></textarea>
    <p></p>
    
	<textarea id="address2" cols="100" rows="3" ></textarea>
    <p></p>

	<textarea id="city" cols="100" rows="3" ></textarea>
    <p></p>

	<textarea id="province" cols="100" rows="3" ></textarea>
    <p></p>
    
	<textarea id="postal" cols="100" rows="3" ></textarea>
    <p></p>

	<textarea id="country" cols="100" rows="3" ></textarea>
    <p></p>
	
	<button onclick="submit()"> submit </button>
	
</body>
</html>
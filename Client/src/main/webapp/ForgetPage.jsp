<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    
<head>
<meta charset="ISO-8859-1">
<title>Forget Page</title>
	<script type="text/javascript" src="js/jquery.min.js" ></script>
	
	<script>
	
    function sendVerifyCode(){
		$.ajax({
			type: 'GET',
			url: 'webapi/users/verifycode',
			contentType: "application/json",       
			error:function(){alert('error!')},
			success: function(obj){	
				$('#code').html(obj);
			}	
			});
			}
    
	
    function upload() {

        var e;
        e=$('#email').val();
        if(e == ""){
        	$('#notification').html("Email address is required!");       
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
        
        var v;
        v=$('#verifycode').val();
        if(v == ""){
        	$('#notification').html("Verify code is required!");       
        	return;
        }
        
        
        code = $('#code').html();
        if(v != code){
        	$('#notification').html("Verify code is wrong");        
        	return;
        }
        
        
        
        
    	var req = {};
    	
    	req.oldpassward = $('#email').val().trim();
    	req.newpassward = $('#passward1').val();
    	
    		$.ajax({
    	type: 'PUT',
    	url: 'webapi/users/user/email/' + $('#email').val().trim(), 
		data: JSON.stringify(req),
		contentType: "application/json", 
    	error:function(){alert('error!')},
    	success: function(obj){	

    		if (obj == "false"){
            	$('#notification').html("Email address is wrong");     
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
        height:36vw;
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
        
        #codeframe{
            width: 100%;
            display: inline-block;
            height:1.5vw;            
        }

        #codeframe p:nth-child(1){
            cursor: pointer;
            float: left;
            color:darkgreen;
            font-size: 1vw;
            
        }
        
        #codeframe p:nth-child(2){
            float:right;
            color:darkgreen;
            font-size: 1vw;
        }
        
        #show{
        	cursor: pointer;
        	color:darkgreen;
            font-size: 1vw;
        }
    
    
    </style>
	
	
</head>
<body>
    
        <div id="content">
				<p1 id= "notification"> </p1>
				<p></p>
				<p1>Email Address: </p1>
                <p></p>
                <input id="email" class="border">
                <p></p>

                <p1>New Passward: </p1>
                <p></p>
                <input name="password" type="password" id="passward1" class="border">
                <p></p>
                
                <p1>Verify Passward: </p1>
                <p></p>
                <input name="password" type="password" id="passward2" class="border">
                <p></p>
            
                            
                <p1>VerifyCode:</p1>
                <p></p>
                <input id="verifycode"  type='text' class="border" />

                <div id="codeframe">
                    <p onclick='sendVerifyCode()'> Security code  </p>
                    <p id="code" style="display:none"></p>
                </div>
                
                <p id="show" onclick="document.getElementById('code').style.display='block'" >show</p>

			    <button onclick="upload()" class="button1"> Submit </button>


        </div>
    
</body>
</html>
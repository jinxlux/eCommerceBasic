// local save shoe's price and name (since we only sell 10 shoes)
var itemPrice = [188, 218, 368, 228, 368, 118, 388, 488, 588, 88];
var itemName = ["ULTRABOOST 4.0", "NMD HUMAN RACE", "AIR MAX 90","ZOOM FLY SP","AIR JORDAN 1","AIR FORCE 1","AIR JORDAN 13","YEZZY 700 V2","YEEZY 700 inerita","YEEZY 350 CLAY"];

// initialize the information of products that clients would like to buy in the car page
function refresh(itemInds){
	document.getElementById("items").innerHTML = "";
	document.getElementById("to").innerHTML = "$0";
	split(itemInds)
}

// get the name of a specific shoe
function getName(ind){
	return itemName[ind];
}

// split the id string (1,2,3..) which represents IDs of shoes clients try to buy
function split(itemInds){
	if(itemInds == ""){
		TotalPrice(0);
		return;
	}
	var itemIDs = itemInds.split(",");
	var items = document.getElementById("items");
	var total = 0;
	var NumOfItemsArray = initializeArray(10);
	// calculate total price and the number of a specific shoe here
	for (var i=0; i < itemIDs.length; i++){
		var index = parseInt(itemIDs[i])-1;
		NumOfItemsArray[index] = NumOfItemsArray[index] + 1;
		total += itemPrice[index];
	}
	// refresh the information of products that clients would like to buy in the car page
	for (var i=0; i < 10; i++){
		if(NumOfItemsArray[i] != 0){
		    var item = document.createElement("div");
		    item.className = "item";	    
			addItemsTO(NumOfItemsArray[i], item, items, i);
		}
	}
	TotalPrice(total);	
}

// initialize an array as [0,0,0 ... ,0]
function initializeArray(ind){
	var arr = new Array(ind);
	for (var i=0; i < ind; i++){
		arr[i] = 0;
	}
	return arr;
}






// refresh the total price of all products the client tried to buy
function TotalPrice(total) {
    var t = document.getElementById("to");
    total = parseInt(total);
    t.innerHTML="$"+total;
}


function up(){
	$.ajax({  
	    url:"webapi/shoes/shoeUP/"+localStorage.shoesid,  
	    type:'GET',  
	    dataType:'text',  
	    success:function(ind){ 
	    	document.getElementById('up').innerHTML = ind;
	    },  
	    error:function(XMLHttpRequest, textStatus, errorThrown){
	    	alert("error");  
	    }  
	});
}

function down(){
	$.ajax({  
	    url:"webapi/shoes/shoeDown/"+localStorage.shoesid,  
	    type:'GET',  
	    dataType:'text',  
	    success:function(ind){ 
	    	document.getElementById('down').innerHTML = ind;
	    },  
	    error:function(XMLHttpRequest, textStatus, errorThrown){
	    	alert("error");  
	    }  
	});
}

function Updateup(){
	$.ajax({  
	    url:"webapi/shoes/shoeupdateUP/"+localStorage.shoesid,  
	    type:'PUT',  
	    dataType:'text',  
	    success:function(ind){ 
	    	document.getElementById('up').innerHTML = ind;
	    },  
	    error:function(XMLHttpRequest, textStatus, errorThrown){
	    	alert("error");  
	    }  
	});
}

function Updatedown(){
	$.ajax({  
	    url:"webapi/shoes/shoeupdateDown/"+localStorage.shoesid,  
	    type:'PUT',  
	    dataType:'text',  
	    success:function(ind){ 
	    	document.getElementById('down').innerHTML = ind;
	    },  
	    error:function(XMLHttpRequest, textStatus, errorThrown){
	    	alert("error");  
	    }  
	});
}


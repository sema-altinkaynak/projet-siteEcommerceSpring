$(function() {	
	$(".cannotUpdate").click( function(e) {
		var ref = $(this).data("ref");
		$.ajax({
			method: 'GET',
			url: ref + "_show_details.html"})
		 .done(function(data){
				JSON.stringify($('#problemDock').html(data) )
			  });
	});
	
	
	$(".delete-btn").click( function(e) {
		var ref = $(this).data("ref");
		$.ajax({
			type: 'DELETE',
			url: "docks/" + ref + "/delete",
			success: function (result) {  
				if (JSON.stringify(result.message).includes("success")){     
           		 	modify(ref);     
           		 	fetch();
           		 	popup(result.message);   
           		 	
           		 	
           		}
		    },
		    error: function (result) {
				if (JSON.stringify(result.message).includes("error")){ 
					alert(result.message);
				}
		        
		    } 
		});
	});
	
	$('body').on('click', "#hide-view-btn", function() {		
		var hide_view = $("#hide-view-btn");
		hide_view.attr('id', "show-view-btn");
		
		const details = document.getElementById("details");
		var show_view_plane = document.getElementById("show-view-plane");
		show_view_plane.childNodes.forEach(s => {
			!s.isEqualNode(details) ? show_view_plane.removeChild(s) : 0;
		})
		$("#details").css("visibility", "hidden");
		show_view_plane.style.width = null; 
  		show_view_plane.style.height = null;	
  		
  		var show_view_txt = document.getElementById("show-view-text");
		show_view_txt.innerHTML = "Show view";	
		
		var show_btn = document.getElementById("eye");
		show_btn.classList.remove("bi-eye-slash");
		show_btn.classList.add("bi-eye");
		
	});
	
	$('body').on('click', "#show-view-btn", function() {
		// document.getElementById("demo").id = "newid";
		var show_view = $("#show-view-btn");
		show_view.attr('id', "hide-view-btn");
			
		var show_view_txt = document.getElementById("show-view-text");
		show_view_txt.innerHTML = "Hide view";		
		
		var show_btn = document.getElementById("eye");
		show_btn.classList.remove("bi-eye");
		show_btn.classList.add("bi-eye-slash");
		
		$("#details").css("display", "block");
		
		$.ajax({
			type: "GET",
			url: "docks/docks_plane",
		 })
		 .done(function(data){
			drawChart(data);
		 });
	});
	
	
	function drawChart(data) {	
      max_x = 0; max_y = 0 ;
	  max_length = 0; max_width = 0;
	  
	  
	  data = data || [];
	  if (data.length == 0) {return;}
	  
	  // calculate the total width and the maximal length	
	  for (let index = 0; index < data.length; index++) {
		  length_field = data[index].length;
		  width_field = data[index].width;		  
		  x_field = data[index].x;
		  y_field = data[index].y;
		  
		  total_width = width_field;
		  
		  if (max_x < x_field) {
			max_x = x_field;
			max_width = width_field;
		  }
		  
		  if (max_y < y_field) {
			max_y = y_field;
			max_length = length_field;
		  }
	  }

	  // COnstruction du plan se fait içi
	  var width_limit = max_x + max_width;
	  var height_limit = max_y + max_length;
	  let html = `<svg overflow="scroll" 
	                   width="50%" 
	                   height="25%" 
	                   viewBox="0 0 ${width_limit+1} ${height_limit+1}" 
	                   xmlns="http://www.w3.org/2000" 
	                   style="background-color:#e1e6e2; padding: 10px;" 
	              /svg>`;
	  
	  for (let index = 0; index < data.length; index++) {
		  id_field = data[index].id;
		  x_field = data[index].x;
		  y_field = data[index].y;
		  width_field = data[index].width;
		  length_field = data[index].length;
		  free_field = data[index].isFree;
		  
		  dock_style = getColor(free_field);
		  
		  html += `<g id="Dock(id:${id_field}, width:${width_field}, length:${length_field}, x:${x_field}, y:${y_field})" class="box">
		  		   <rect id="${id_field}" 
		                 x="${x_field}" 
		                 y="${y_field}" 
		                 width="${width_field}" 
		                 height="${length_field}"  
		                 fill="${dock_style}"
		                 stroke="#343635" 
                    	 stroke-width="0.5"
		                 />
		           <text x="${(width_field/2) + x_field}" y="${(length_field/2) + y_field+0.5}" font-family="Verdana" font-size="2" 
		           	     text-anchor="middle" fill="black"> ${id_field} </text>
		           </g>`;
	  }
	  
	  html += `</svg>`;
	  
	  const svg = document.createElement("svg")
	  svg.innerHTML = html ;
	  var show_view_plane = document.getElementById("show-view-plane");
	  show_view_plane.style.padding = 6;
	  show_view_plane.innerHTML = `<p class='h2 mx-3 text-muted'> 2D docks plane representation </p> 
	                               <p id="details">  </p>` 
	  							   + svg.innerHTML;
	  							   
	  let elements = document.getElementsByClassName("box");
 
	  for (var i = 0; i < elements.length; i++) {
		  elements[i].addEventListener('mouseover', hoveredBox);
		  elements[i].addEventListener('mouseleave', unhoveredBox);
	  }
	}
});

function hoveredBox(event) {
	$("#details").first().text($(this).attr("id"));
    $("#details").css("visibility", "visible");
}
 
function unhoveredBox() { 
	$("#details").css("visibility", "hidden");
}

	
function modify(id) {
	var container  = document.getElementById("container");
	var dockRow  = document.getElementById("row-"+id);
	container.removeChild(dockRow);
}

function fetch() {
	$.ajax({
			method: 'GET',
			url: "docks"})
		 .done(function(data){$('body').html(data);});
}


function popup(data){
	var popup  = document.getElementById("deleted-dock-popup");
	
	var popupMsg  = document.getElementById("delete-dock-msg");
	var text = document.createTextNode(data);
	popupMsg.appendChild(text);

	$('#deleted-dock-popup').modal();
}

function getColor(isFree) {
	return isFree ? "#74f26d" : "#D33C3F";
}

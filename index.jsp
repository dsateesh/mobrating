<!DOCTYPE HTML>
<%@ page import="java.util.regex.Pattern" %>

<html>
	<head>
		<title>Mob Rating</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>

		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.poptrox.min.js"></script>
		<script src="js/jquery.scrolly.min.js"></script>
		<script src="js/jquery.scrollgress.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/init.js"></script>

		<link rel="stylesheet" href="rateit/rateit.css" />
		<link rel="stylesheet" href="rateit/bigstars.css" />
		<noscript>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-wide.css" />
			<link rel="stylesheet" href="css/style-normal.css" />						
		</noscript>
		<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->			
	</head>
	<%!
		boolean isDesktop(String userAgent) {        
			Pattern desktop = Pattern.compile("(windows|linux|os\\s+[x9]|solaris|bsd)",Pattern.CASE_INSENSITIVE);
			Pattern mobile = Pattern.compile("(iphone|ipod|ipad|blackberry|android|palm|windows\\s+ce)",Pattern.CASE_INSENSITIVE);
			Pattern bot = Pattern.compile("(spider|crawl|slurp|bot)", Pattern.CASE_INSENSITIVE);
	        return (!matches(mobile, userAgent) && matches(desktop, userAgent)) || matches(bot, userAgent);
	    }

	    boolean matches(Pattern p, String s) {	    	
	        return p.matcher(s).find();
	    }
	    boolean isBlank(String str){
	    	return str == null || "".equals(str.trim());
		}
	%>
	<%
		String HTTP_X_OPERAMINI_PHONE_UA = "X-Operamini-Phone-UA";
		String HTTP_X_SKYFIRE_PHONE = "X-Skyfire-Phone";
		String HTTP_USER_AGENT = "User-Agent";
	 
    	String ua = request.getHeader(HTTP_X_OPERAMINI_PHONE_UA);
        if (isBlank(ua))
            ua = request.getHeader(HTTP_X_SKYFIRE_PHONE);
        if (isBlank(ua))
            ua = request.getHeader(HTTP_USER_AGENT);
        if (isBlank(ua))
            ua = "";
        boolean isDesktop = isDesktop(ua);        
	%>
	<body onLoad="getLocation()">
		<script src="rateit/jquery.rateit.js" type="text/javascript"></script>
		
		<form id="mobrate" >
		<!-- Header -->
		<script>
			function addElement(name,formToAdd){
				var input = document.createElement("input");
				input.setAttribute("type", "hidden");
				input.setAttribute("name", name);
				input.setAttribute("id", name);
				input.setAttribute("value", "value_you_want");
				return document.getElementById(formToAdd).appendChild(input);
			}
			function getLocation() {				
				addElement("lat","mobrate")
				addElement("long","mobrate")				
				var x = document.getElementById("lat");
				
			    if (navigator.geolocation) {
			        navigator.geolocation.getCurrentPosition(showPosition, showError);
			    } else { 
			        x.innerHTML = "Geolocation is not supported by this browser.";
			    }
			}

			function showPosition(position) {
				var x = document.getElementById("lat");
				var y = document.getElementById("long");
			    x.value = position.coords.latitude;
			    y.value = position.coords.longitude;			    
			}

			function showError(error) {
			    switch(error.code) {
			        case error.PERMISSION_DENIED:
			            x.innerHTML = "User denied the request for Geolocation."
			            break;
			        case error.POSITION_UNAVAILABLE:
			            x.innerHTML = "Location information is unavailable."
			            break;
			        case error.TIMEOUT:
			            x.innerHTML = "The request to get user location timed out."
			            break;
			        case error.UNKNOWN_ERROR:
			            x.innerHTML = "An unknown error occurred."
			            break;
			    }
			}
		</script>	
		<%
			if(!isDesktop){
		%>			
		
			<section id="products" class="main style2  dark fullscreen">
				<div id="movie" class="content box style2">
					<center>
					<header>
						
						Thanks for watching
						<image src="images/intro_1.jpg" style="max-width:100%"> in Navrang Theater Atlanta GA
						
					</header>
					<div id="response" data-productid="312" class="rateit"><h3>Rate it:</h3></div>
							
					<script type ="text/javascript">

					     $('#movie .rateit').bind('rated reset', function (e) {
					     	
					         var ri = $(this);

					 	         

							 
					         var value = ri.rateit('value');
					         var productID = ri.data('productid'); // if the product id was in some hidden field: ri.closest('li').find('input[name="productid"]').val()
						     ri.rateit('readonly', true);
					         $.ajax({

					             url: 'rateit.jsp', //your server side script
					             data: { id: productID, value: value ,latitude: $('#lat').val(), longitude: $('#long').val()}, //our data
					             type: 'POST',
					             success: function (data) {

					                 $('#response').append('<p>' + data + '</p>');
					 
					             },
					             error: function (jxhr, msg, err) {
					                 $('#response').append('<p style="color:red">' + msg + '</p>');
					             }
					         });
					     });
					 </script>
					</center>
				</div>						
		<%
			}else{
				out.println("<h1>This website is only available on mobile device. Thanks for visiting us.<h1>");
			}
		%>
	</body>
</html>
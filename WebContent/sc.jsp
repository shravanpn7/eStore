<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel='stylesheet'
	href='<%=request.getContextPath()%>/css/style.css' media='screen' />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/home.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/polyfill.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/blocksit.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script>
<script type="text/javascript">
var rem = function(pid,uid){
	console.log("remove");
	$.ajax({
		type : "POST",
		url : "http://localhost:8080/LabStore/myrest/sc/remove/"+pid+"?buyerid="+uid,
		success : function(data) {
			console.log("success");
			console.log(data);
		},
		error : function() {
			console.log("error");
		}
	});
	
	return false;
};

var checkout = function(uid){
	$.ajax({
		type : "POST",
		url : "http://localhost:8080/LabStore/myrest/sc/checkout/"+uid,
		success : function(data) {
			console.log("success");
			console.log(data);
		},
		error : function() {
			console.log("error");
		}
	});
}

$(document).ready(function() {
	//vendor script
	$('#header')
	.css({ 'top':-50 })
	.delay(1000)
	.animate({'top': 0}, 800);
	
	$('#footer')
	.css({ 'bottom':-15 })
	.delay(1000)
	.animate({'bottom': 0}, 800);
	
	//blocksit define
	$(window).load( function() {
		$('#container').BlocksIt({
			numOfCol: 5,
			offsetX: 8,
			offsetY: 8
		});
	});
	
	//window resize
	var currentWidth = 1100;
	$(window).resize(function() {
		var winWidth = $(window).width();
		var conWidth;
		if(winWidth < 660) {
			conWidth = 440;
			col = 2
		} else if(winWidth < 880) {
			conWidth = 660;
			col = 3
		} else if(winWidth < 1100) {
			conWidth = 880;
			col = 4;
		} else {
			conWidth = 1100;
			col = 5;
		}
		
		if(conWidth != currentWidth) {
			currentWidth = conWidth;
			$('#container').width(conWidth);
			$('#container').BlocksIt({
				numOfCol: col,
				offsetX: 8,
				offsetY: 8
			});
		}
	});
});
</script>


</head>

<body>

	<!-- Header -->
	<header id="header">
	<h1>282 Lab1, Amazon Shopping Store</h1>
	<div id="backlinks">
		<a href="../">Back to Home Page &raquo;</a> <a
			href="http://localhost:8080/LabStore/myrest/sc/get-sc/${legalUser.getUser_id()}?lastname=${legalUser.getLast_name()}&firstname=${legalUser.getFirst_name()}">go
			to my shopping cart &raquo;</a>
			<a href="#">sign out &raquo;</a>
	</div>
	<div class="clearfix"></div>
	</header>
	<section id="wrapper"> <hgroup>
	<h2>${lastname} ${firstname}'s shopping cart</h2>
	<h3>
		<div>
			<a href="http://localhost:8080/LabStore/myrest/sc/checkout/${userid}">Check Out</a>
		</div>
	</h3>
	</hgroup>

	<div id="container">
		<c:forEach var="product" items="${products}">
			<div class="grid">
				<div class="imgholder">
					<img
						src="${product.getImage_url() }" />
				</div>

				<div>
					<span>title: </span><span id="${product.getProduct_id()}_name">${product.getProduct_name()}</span><br>
					<span>price: </span><span id="${product.getProduct_id()}_price">${product.getProduct_price()}</span><br>
					<span>Quantity: </span><span
						id="${product.getProduct_id()}_quantity">${product.getProduct_quantity()}</span><br>
					<span>description: </span><span id="${product.getProduct_id()}_des">${product.getProduct_description()}</span><br>
					<span>owner: </span><span id="${product.getProduct_id()}_oid">${product.getOwner_id()}</span><br>
					<span>Catalog: </span><span id="${product.getProduct_id()}_catalg">${product.getCatalog_name()}</span><br>
					<button onclick="rem(${product.getProduct_id()}, ${userid})">
						remove</button>
				</div>

			</div>
		</c:forEach>
	</div>
	</section>
</body>
</html>
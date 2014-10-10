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
	<link rel='stylesheet'
	href='<%=request.getContextPath()%>/dist/css/bootstrap.min.css' media='screen' />
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
	<script type="text/javascript"  src="<%=request.getContextPath()%>/dist/js/bootstrap.min.js"></script>
	
<script>
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


$(document).ready(function() {
	
	$('#addp').click(function(){
		//alert("click add product");
		$('#addcatalog').css("display","none");
		$('#addproduct').css("display","inline");
	});
	
	$('#addc').click(function(){
		//alert("click add catalog");
		$('#addproduct').css("display","none");
		$('#addcatalog').css("display","inline");
	});
	
	$('#closeaddc').click(function(){
	
		$('#addcatalog').css("display","none");
	});
	
	$('#closeaddp').click(function(){
		
		$('#addproduct').css("display","none");
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
			href="http://localhost:8080/eStore/myrest/sc/get-sc/${legalUser.getUser_id()}?lastname=${legalUser.getLast_name()}&firstname=${legalUser.getFirst_name()}">go
			to my shopping cart &raquo;</a> <a href="#">sign out &raquo;</a>
	</div>
	<div class="clearfix"></div>
	</header>
	<section id="wrapper"> <hgroup>
	<h2>All Products</h2>

	<div class="btn-group">
		<button id="addp" type="button" class="btn btn-default">add product</button>
		<button id="addc" type="button" class="btn btn-default">add catalog</button>

		<div class="btn-group">
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown">
				Product Catalog <span class="caret"></span>
			</button>
			<ul class="dropdown-menu">
			<c:forEach var="cata" items="${catalogs}">
				<li><a href="#">${cata.getCname()}</a></li>
			</c:forEach>
			</ul>
		</div>
	</div>

	<div style="display: none;" id="addcatalog">
		<form action="http://localhost:8080/eStore/myrest/home/addcatalog" method="post">
			<lable>catalog name:</lable>
			<input name="catalog_name" type="text">
			<input type="submit"><br>
		</form>
		<button id="closeaddc">close</button>
	</div>

	<div style="display: none;" id="addproduct">
		<form action="http://localhost:8080/eStore/myrest/home/addproduct/${legalUser.getUser_id()}" method="post">
			<lable>product name</lable>
			<input name="product_name" type="text" ><br>
			<lable>product type:</lable>
			<select name="product_catalog_id">
				<c:forEach var="cata" items="${catalogs}">
					<option value="${cata.getCid()}">${cata.getCname()}</option>
				</c:forEach>
			</select><br>
			
			<lable>product price:</lable>
			<input name="product_price" type="text"><br>
			<lable>product quantity:</lable>
			<input name="product_quantity" type="text"><br>
			<lable>image url:</lable>
			<input name="product_image_url" type="text"><br>
			<lable>product description:</lable>
			<textarea name="product_des" rows="4" cols="20"></textarea><br>
			<input type="submit" value="submit"><br>
		</form>
	<div><button  id="closeaddp">close</button></div>
	</div>
	
	</hgroup>
	<div id="container">
		<c:forEach var="product" items="${products}">
			<div class="grid">
				<div class="imgholder">
					<img
						src="${product.getImage_url()}" />
				</div>

				<div>
					<span>title: </span><span id="${product.getProduct_id()}_name">${product.getProduct_name()}</span><br>
					<span>price: </span><span id="${product.getProduct_id()}_price">${product.getProduct_price()}</span><br>
					<span>Quantity: </span><span
						id="${product.getProduct_id()}_quantity">${product.getProduct_quantity()}</span><br>
					<span>description: </span><span id="${product.getProduct_id()}_des">${product.getProduct_description()}</span><br>
					<span>owner: </span><span id="${product.getProduct_id()}_oid">${product.getOwner_id()}</span><br>
					<span>Catalog: </span><span id="${product.getProduct_id()}_catalg">${product.getCatalog_name()}</span><br>
					<button onclick="add(${product.getProduct_id()})">add into
						shoppingcart</button>
				</div>

			</div>
		</c:forEach>
	</div>
	</section>



	<h1>
		<div style="visibility: hidden;">
			<span id="uid">${legalUser.getUser_id()}</span>
		</div>
	</h1>
</body>
</html>
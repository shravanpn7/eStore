<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	<h2>Your Order</h2>
	<hr>
	<h3>Products List</h3>
	<c:forEach var="p" items="${products}">
		<div>
			<span>Product Name: </span><span>${p.getProduct_name()}</span>
		</div>
		<div>
			<span>Product Quantity:</span><span>${p.getProduct_quantity()}</span>
		</div>
	</c:forEach>
	<hr>
	<h3>Total Price</h3>
	<div>
		<span>${total}</span>
	</div>
	<hr>
	
	<h1>credit card payment:</h1>
	<form action="http://localhost:8080/LabStore/myrest/sc/pay/${uid}"
		method="post">
		<div>
			<span>Firstname: </span><span><input type="text"
				name="firstname"></span>
		</div>
		<div>
			<span>Lastname: </span> <span><input type="text"
				name="lastname"></span>
		</div>
		<div>
			<span>card number: </span> <span><input type="text"
				name="cardnumber"></span>
		</div>

		<input type="submit" value="Place your order">
	</form>
	</hgroup>
</body>
</html>
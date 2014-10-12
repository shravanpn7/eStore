<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
</head>
<body>
	<!-- Header -->
	<header id="header">
	<h1>282 Lab1, Amazon Shopping Store</h1>

	<div class="clearfix"></div>
	</header>
	<section id="wrapper"> <hgroup>
	<h2>Please Login</h2>
	<form id="login_form_" action="myrest/home/signin" method="post">
		lastname:<input type="text" name="lastname" value="Papanaidu"><br>
		firstname:<input type="text" name="firstname" value="Shravan"><br>
		email:<input type="text" name="email" value="shravanpn7@gmail.com"><br>
		password:<input type="password" name="password" value="papanaidu"><br>
		<input type="submit" id="submit_1_1" name="submit"><br>
	</form>
	<button id="sign_up">sign up</button>
	</hgroup> </section>
</body>
</html>
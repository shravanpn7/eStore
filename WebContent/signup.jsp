<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel='stylesheet'
	href='<%=request.getContextPath()%>/css/style.css' media='screen' />
<link rel='stylesheet'
	href='<%=request.getContextPath()%>/dist/css/bootstrap.min.css'
	media='screen' />
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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dist/js/bootstrap.min.js"></script>

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
	<h2>Sign Up</h2>

	<div>
		<span id="error_msg"></span>
	</div>
	<form id="signup_submit" action="myrest/home/signup" method="post">
		lastname: <input type="text" name="lastname" id="lastname"><span
			id="lastname_validate"></span><br> firstname:<input type="text"
			name="firstname" id="firstname"><span id="firstname_validate"></span><br>
		email:<input type="text" name="email" id="email"><span
			id="email_validate"></span><br> password:<input type="password"
			name="password" id="password"><span id="password_validate"></span><br>
		password_1:<input type="password" name="password_1" id="password_1"><span
			id="password_1_validate"></span><br> <input type="submit">
	</form>
	</hgroup> </section>



</body>
</html>
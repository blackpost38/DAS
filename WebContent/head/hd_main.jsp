<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp" flush="true"/>
		<title>Employee main</title>
	</head>
	<body>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp" flush="true"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/head/hd_menu.jsp"/>
				</div>
				<div class="span9">
					<h1>부장 페이지</h1>
					<img src="img/heads.jpg" class="img-polaroid">
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>
</html>
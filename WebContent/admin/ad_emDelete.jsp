<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>admin employee delete</title>
	</head>
	<body>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp"/>
			<div class="row">
				<div class="span3">
				
					<jsp:include page="../template/admin/ad_menu.jsp"/></div>
				<div class="span9">
					<h1>사원삭제</h1><br/>
					사번:<input type="text"><br/>
					<button class="btn btn-primary" onclick="alert('사원이 삭제되었습니다.')">사원삭제</button>
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>
</html>
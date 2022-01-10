<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인증 방어 코드 : 로그인 전에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	
	if(session.getAttribute("loginMember") != null) {
		System.out.println("이미 로그인 되어 있습니다.");
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<h1>로그인</h1>
	
	<form id="loginForm" class="form-inline" method="post" action="<%=request.getContextPath() %>/loginAction.jsp">
		<div>memberId : </div>
		<div><input type="text" id="memberId" name="memberId"  placeholder="Enter id" value=""></div>
		<div>memberPw : </div>
		<div><input type="password" id="memberPw" name="memberPw" placeholder="Enter password" value=""></div>
		<div><button id="loginBtn" type="button" class="btn btn-primary">로그인</button></div>
	</form>
	
	<script>
		$('#loginBtn').click(function(){
			// 버턴을 click했을때
			if($('#memberId').val() == '') { // id 공백이면
				alert('memberId를 입력하세요');
				return;
			} else if($('#memberPw').val() == '') { // pw 공백이면
				alert('memberPw를 입력하세요');
				return;
			} else {
				$('#loginForm').submit(); // <button type="button"> -> <button type="submit">
			}
		});
	</script>
</body>
</html>






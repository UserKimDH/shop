<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member) session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if (loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<form id="updateEbookForm" action="<%=request.getContextPath()%>/admin/updateEbookImgAction.jsp" method="post"
		  enctype="multipart/form-data"> 
		  <!-- multipart/form-data : 액션으로 기계어코드를 넘길때 사용 -->
		  <!-- application/x-www-form-urlencoded : 액션으로 문자열 넘길때 사용 -->
		<input type="text" id="ebookNo" name="ebookNo" value="<%=ebookNo%>" readonly="readonly"> <!-- type="hidden" -->
		<input type="file" id="ebookImg" name="ebookImg">
		<button type="submit" class="btn btn-primary">이미지파일 수정</button>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#ebookNo').val() == '') {
				alert('ebookNo를 입력하세요');
				return;
			}
			if($('#ebookImg').val() == '') {
				alert('ebookImg가 없습니다');
				return;
			}
			$('#insertCategory').submit();
		});	
	</script>
</body>
</html>










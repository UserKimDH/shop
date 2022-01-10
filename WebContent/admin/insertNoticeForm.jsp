<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String updateDate = request.getParameter("updateDate");
	String createDate = request.getParameter("createDate");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	//없으면 아래 ~~님 반갑습니다 쪽에 오류
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>공지 수정</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<form id="insertNotice" action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp?=<%=loginMember.getMemberNo()%>">
		<div>작성자 : :<input type="text" id="memberNo" name="memberNo" value="<%=loginMember.getMemberNo() %>" readonly="readonly"></div>
		<div>제목 : <input type="text" id="noticeTitle" name="noticeTitle"></div>
		<div><textarea id="noticeContent" name="noticeContent"></textarea></div>
		<div><button id="btn" type="button" class="btn btn-primary">생성</button></div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#memberNo').val() == '') {
				alert('memberNo가 정확하지 않습니다');
				return;
			}
			if($('#noticeTitle').val() == '') {
				alert('noticeTitle를 입력하세요');
				return;
			}
			if($('#noticeContent').val() == '') {
				alert('noticeContent를 입력하세요');
				return;
			}
			$('#insertNotice').submit();
		});
	</script>
</body>
</html>
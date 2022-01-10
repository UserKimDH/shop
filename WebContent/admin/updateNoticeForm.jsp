<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String createDate = request.getParameter("createDate");
	String updateDate = request.getParameter("updateDate");

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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>공지 수정</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- 관리자 메뉴 인클루드(include)시작 -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<form id="updateNoticeForm" action="<%=request.getContextPath() %>/admin/updateNoticeAction.jsp?=<%=noticeNo%>">
		<div>번호 : <input type="text" id="noticeNo" name="noticeNo" value="<%=noticeNo %>" readonly="readonly"></div>
		<div>작성자 : :<input type= "text" id="memberNo" name="memberNo" value="<%=memberNo %>" readonly="readonly"></div>
		<div>제목 : <input type="text" id="noticeTitle" name="noticeTitle" value="<%=noticeTitle %>"></div>
		<div><textarea id="noticeContent" name="noticeContent"><%=noticeContent %></textarea></div>
		<div><input type="hidden" name="updateDate" value="<%=updateDate%>"><input type="hidden" name="createDate" value="<%=createDate%>"></div>
		<div><button id="btn" type="button" class="btn btn-primary">수정</button></div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#noticeTitle').val() == '') {
				alert('noticeTitle를 입력하세요');
				return;
			}
			if($('#noticeContent').val() == '') {
				alert('noticeContent를 입력하세요');
				return;
			}
			$('#updateNoticeForm').submit();
		});	
	</script>
</body>
</html>
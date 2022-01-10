<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	//없으면 아래 ~~님 반갑습니다 쪽에 오류
	}
		
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>공지 상세</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- 관리자 메뉴 인클루드(include)시작 -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<form id="noticeForm" action="<%=request.getContextPath() %>/admin/updateNoticeForm.jsp?=<%=notice.getNoticeNo()%>">
		<div>번호 : <input type="text" id="noticeNo" name="noticeNo" value="<%=notice.getNoticeNo() %>" readonly="readonly"></div>
		<div>작성자 :<input type="text" id="memberNo" name="memberNo" value="<%=notice.getMemberNo() %>" readonly="readonly"></div>
		<div>제목 : <input type="text" id="noticeTitle" name="noticeTitle" value="<%=notice.getNoticeTitle() %>" readonly="readonly"></div>
		<div><textarea id="noticeContent" name="noticeContent" readonly="readonly"><%=notice.getNoticeContent() %></textarea></div>
		<div>수정일 : <%=notice.getUpdateDate() %> 생성일 : <%=notice.getCreateDate() %></div>
		<button id="btn" type="button" class="btn btn-primary">수정</button>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#noticeNo').val() == '') {
				alert('noticeNo를 입력하세요');
				return;
			}
			if($('#memberNo').val() == '') {
				alert('memberNo를 입력하세요');
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
			$('#noticeForm').submit();
		});
	</script>
</body>
</html>
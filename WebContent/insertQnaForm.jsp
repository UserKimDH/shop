<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8"); //인코딩		
	Member loginMember = (Member)session.getAttribute("loginMember");
	//방어코드
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	String memberId=request.getParameter("memberId");
	
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>문의 페이지</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<h1 class="text-white">문의</h1>
	<form id="insertQnaForm" action="<%=request.getContextPath() %>/insertQnaAction.jsp">
		<div>
			<input type="radio" class="qnaCategory" name="qnaCategory" value="전자책관련">전자책관련
			<input type="radio" class="qnaCategory" name="qnaCategory" value="개인정보관련">개인정보관련
			<input type="radio" class="qnaCategory" name="qnaCategory" value="기타">기타
		</div>
		<div>제목<input type="text" id="qnaTitle" name="qnaTitle"></div>
		<div>내용<textarea id="qnaContent" name="qnaContent"></textarea></div>
		<div><input type="hidden" id="memberNo" name="memberNo" value="<%=loginMember.getMemberNo()%>"></div>
		<div>
			<input type="radio" class="qnaSecret" name="qnaSecret" value="Y">Y
			<input type="radio" class="qnaSecret" name="qnaSecret" value="N">N
		</div>
		<button type="button" id="btn" class="btn btn-primary">문의</button>
	</form>
	
	<script>
		$('#btn').click(function(){
			let qnaCategory = $('.qnaCategory:checked');
			if(qnaCategory.length == 0) {
				alert('qnaCategory를 선택하세요');
				return;
			}
			if($('#qnaTitle').val() == '') {
				alert('qnaTitle가 정확하지 않습니다');
				return;
			}
			if($('#qnaContent').val() == '') {
				alert('qnaContent가 정확하지 않습니다');
				return;
			}
			if($('#memberNo').val() == '') {
				alert('memberNo가 정확하지 않습니다');
				return;
			}
			let qnaSecret = $('.qnaSecret:checked');
			if(qnaSecret.length == 0) {
				alert('qnaSecret를 선택하세요');
				return;
			}
			$('#insertQnaForm').submit();
		});
	</script>
</body>
</html>
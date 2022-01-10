<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%	
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	//없으면 아래 ~~님 반갑습니다 쪽에 오류
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPw=request.getParameter("memberPw");	
	
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(memberPw);
%>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>관리자의 특정회원의 비밀번호를 수정</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<h1>회원 비밀번호 수정</h1>
	<form id="updateMemberPwForm" action="updateMemberPwAction.jsp">
		<table class="table table-bordered table-dark">
			<tr>
				<td>memberNo</td>
				<td><input type="text" id="memberNo" name="memberNo" value="<%=member.getMemberNo() %>" readonly></td>
			</tr>
			<tr>
				<td>memberPw</td>
				<td><input type="password" id="memberPw" name="memberPw"></td>
			</tr>
			<tr>
				<td>New memberPw</td>
				<td><input type="password" id="memberPwNew" name="memberPwNew"></td>
			</tr>
		</table>
		<button id="btn" type="button" class="btn btn-primary">수정 확인</button>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#memberNo').val() == '') {
				alert('memberNo를 입력하세요');
				return;
			}
			if($('#memberPw').val() == '') {
				alert('memberPw를 입력하세요');
				return;
			}
			if($('#memberPwNew').val() == '') {
				alert('memberPwNew를 입력하세요');
				return;
			}
			
			$('#updateMemberPwForm').submit();
		});	
	</script>
</body>
</html>
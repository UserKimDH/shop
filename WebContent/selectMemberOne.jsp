<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	//로그인 멤버값이 없으면 접근 불가
	if(loginMember==null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	//없으면 아래 ~~님 반갑습니다 쪽에 오류
	}	
	
	String memberId = request.getParameter("memberId");
	
	MemberDao memberDao = new MemberDao();
	
	Member member = new Member();
	member=memberDao.selectMemberIdByMember(memberId);
	
	String resultLevel = "";
	if(member.getMemberLevel()==0){
		resultLevel="일반회원";
	}else{
		resultLevel="관리자";
	}
%>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<h1>회원 정보</h1>
	<table class="table table-bordered table-dark">
		<tr>
			<td>회원이름</td>
			<td><input type="text" id="memberId" name="memberId" value="<%=memberId %>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>회원 나이</td>
			<td><input type="text" id="memberAge" name="memberAge" value="<%=member.getMemberAge()%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>회원 성별</td>
			<td><input type="text" id="memberGender" name="memberGender" value="<%=member.getMemberGender()%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>회원 정보</td>
			<td><input type="text" id="memberLevel" name="memberLevel" value="<%=resultLevel%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>회원 생성일</td>
			<td><input type="text" id="createDate" name="createDate" value="<%=member.getCreateDate()%>" readonly="readonly"></td>
		</tr>
	</table>
</body>
</html>
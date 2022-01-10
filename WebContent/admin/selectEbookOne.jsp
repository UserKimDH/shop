<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>Insert title here</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>
	<div>
		<%=ebook.getEbookNo()%>
	</div>
	<div>
		<img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>">
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/updateEbookImgForm.jsp?ebookNo=<%=ebook.getEbookNo()%>" class="btn btn-primary">이미지수정</a>
	</div>
</body>
</html>












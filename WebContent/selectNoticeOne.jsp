<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
%>
<!DOCTYPE html>
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
	<div>번호 : <%=notice.getNoticeNo() %></div>
	<div>작성자 : <%=notice.getMemberNo() %></div>
	<div>제목 : <%=notice.getNoticeTitle() %></div>
	<div><textarea readonly="readonly"><%=notice.getNoticeContent() %></textarea></div>
	<div>수정일 : <%=notice.getUpdateDate() %> 생성일 : <%=notice.getCreateDate() %></div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//페이징
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
	//공지사항을 나열할 메소드 호출
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticePageAll(beginRow,ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>공지 사항</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<h1>[공지사항]</h1>
	<table>
		<thead>
			<tr>
				<th>NoticeNo</th>
				<th>제목</th>
				<th>작성자</th>
				<th>updateDate</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
			for(Notice n : noticeList){
			%>
				<tr>
					<td><%=n.getNoticeNo() %></td>
					<td><a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle() %></a></td>
					<td><%=n.getMemberNo() %></td>
					<td><%=n.getUpdateDate() %></td>
					<td><%=n.getCreateDate() %></td>
				</tr>
			<%
			}
			%>
		</tbody>
	</table>
</body>
</html>
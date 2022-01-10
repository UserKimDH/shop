<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
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
	//페이징
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	int totalCount = 0;
	
	
	//공지사항을 나열할 메소드 호출
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticePageByAdmin(beginRow,ROW_PER_PAGE);
	totalCount=noticeDao.selectCountNotice(ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>공지 사항</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<h1>[공지사항]</h1>
	<table class="table table-bordered table-dark">
		<thead>
			<tr>
				<th>NoticeNo</th>
				<th>제목</th>
				<th>작성자</th>
				<th>updateDate</th>
				<th>createDate</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%
			for(Notice n : noticeList){
			%>
				<tr>
					<td><%=n.getNoticeNo() %></td>
					<td><a href="<%=request.getContextPath() %>/admin/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle() %></a></td>
					<td><%=n.getMemberNo() %></td>
					<td><%=n.getUpdateDate() %></td>
					<td><%=n.getCreateDate() %></td>
					<td><a href="<%=request.getContextPath() %>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
				</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<div>
	<a href="<%=request.getContextPath() %>/admin/insertNoticeForm.jsp?=<%=loginMember.getMemberNo()%>" class="btn btn-primary">추가</a>
	</div>
	<%
		if (currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage - 1%>" class="btn btn-light">이전</a>
	<%
		}	
			int lastPage = totalCount / ROW_PER_PAGE;
		
			if (totalCount % ROW_PER_PAGE != 0) {
				lastPage += 1;
		}
		
		if (currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-light">다음</a>
	<%
		}
	%>
</body>
</html>
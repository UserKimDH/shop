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
	// 페이징
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;
		
	/*String qnaSecret = "N";
	if (request.getParameter("currentPage") != "N") {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}*/
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qnaListThisMember = qnaDao.selectQnaListMemberByPage(beginRow, ROW_PER_PAGE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>본인의 문의사항을 보는 페이지</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 추가문의 -->
	<div><a href="<%=request.getContextPath()%>/insertQnaForm.jsp?memberId=<%=loginMember.getMemberId()%>">문의</a></div>
	<!-- 회원의 삭제수정은 자세한 정보를 들어간뒤 한다 -->
	<table class="table table-bordered table-dark">
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>문의사항 제목</th>
				<th>문의한 인원번호</th>
				<th>생성일</th>
				<th>갱신일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>		
			<%
			for(Qna q : qnaListThisMember){
			%>
				<tr>
					<td><%=q.getQnaNo() %></td>
					<td><%=q.getQnaCategory() %></td>
					<td><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a></td>
					<td><%=q.getMemberNo() %></td>
					<td><%=q.getCreateDate() %></td>
					<td><%=q.getUpdateDate() %></td>
					<td><a href="<%=request.getContextPath()%>/deleteQnaAction.jsp?qnaNo=<%=q.getQnaNo() %>" class="btn btn-primary">삭제</a></td>
				</tr>
			<%
			}
			%>		
		</tbody>
	</table>
</body>
</html>
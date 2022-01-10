<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 인증코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
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
	int totalCount = 0;
		
	// 구현코드
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderList(beginRow, ROW_PER_PAGE);
	totalCount=orderDao.selectCountOrder(ROW_PER_PAGE);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectOrderList.jsp</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- 관리자 메뉴 인클루드(include)시작 -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<h1>주문 목록</h1>
	<table class="table table-bordered table-dark">
		<thead>
			<tr>
				<th>orderNo</th>
				<th>ebookTitle</th>
				<th>orderPrice</th>
				<th>createDate</th>
				<th>memberId</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderEbookMember oem : list) {
			%>
					<tr>
						<td><%=oem.getOrder().getOrderNo()%></td>
						<td><%=oem.getEbook().getEbookTitle()%></td>
						<td><%=oem.getOrder().getOrderPrice()%></td>
						<td><%=oem.getOrder().getCreateDate()%></td>
						<td><%=oem.getMember().getMemberId()%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<%
		if (currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=currentPage - 1%>" class="btn btn-light">이전</a>
	<%
		}	
			int lastPage = totalCount / ROW_PER_PAGE;
		
			if (totalCount % ROW_PER_PAGE != 0) {
				lastPage += 1;
		}
		
		if (currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-light">다음</a>
	<%
		}
	%>
</body>
</html>

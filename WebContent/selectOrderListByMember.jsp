<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8"); //인코딩		
	Member loginMember = (Member)session.getAttribute("loginMember");

	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 구현코드
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(loginMember.getMemberNo());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>selectOrderList.jsp</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>

	<h1>나의 주문 목록</h1>
	<table class="table table-bordered table-dark">
		<thead>
			<tr>
				<th>orderNo</th>
				<th>ebookTitle</th>
				<th>orderPrice</th>
				<th>createDate</th>
				<th>memberId</th>
				<th>상세주문내역</th>
				<th>ebook후기</th>
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
						<td><a href="<%=request.getContextPath()%>/selectOrderOneByMember.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&memberNo=<%=oem.getMember().getMemberNo()%>" class="btn btn-primary">상세주문내역</a>
						<td><a href="<%=request.getContextPath()%>/insertOrderCommentFrom.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>" class="btn btn-primary">ebook후기</a>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>

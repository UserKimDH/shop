<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	//방어코드
	if(request.getParameter("memberNo")==null || request.getParameter("orderNo")==null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	if(request.getParameter("memberNo").equals("") || request.getParameter("orderNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	//값불러오기
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	//디버깅
	System.out.println(memberNo+"<<memberNo");
	System.out.println(orderNo+"<<orderPrice");

	OrderDao orderDao = new OrderDao();
	OrderEbookMember oem = new OrderEbookMember();
	oem = orderDao.selectOrderOneByMember(memberNo,orderNo);
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>주문 상세 내역</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<h1><%=oem.getOrder().getOrderNo() %>의 주문 상세 정보</h1>
	<table class="table table-bordered table-dark">
		<tr>
			<td>주문한 ebook</td>
			<td><%=oem.getEbook().getEbookNo()%></td>
		</tr>
		<tr>
			<td>주문하신 분</td>
			<td><%=oem.getMember().getMemberNo() %></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><%=oem.getOrder().getOrderPrice()%></td>
		</tr>
		<tr>
			<td>주문일</td>
			<td><%=oem.getOrder().getCreateDate()%></td>
		</tr>
		<tr>
			<td><%=oem.getEbook().getEbookTitle()%></td>
			<td><%=oem.getMember().getMemberId()%></td>		
		</tr>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%	
	request.setCharacterEncoding("utf-8"); //인코딩	
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	//방어코드
	if(request.getParameter("ebookNo")==null || request.getParameter("ebookPrice")==null || request.getParameter("memberNo")==null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	if(request.getParameter("ebookNo").equals("") || request.getParameter("ebookPrice").equals("") || request.getParameter("memberNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	//값불러오기
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	//디버깅
	System.out.println(ebookNo+"<<ebookNo");
	System.out.println(memberNo+"<<memberNo");
	System.out.println(orderPrice+"<<orderPrice");
	
	Order order = new Order();
	order.setEbookNo(ebookNo);
	order.setMemberNo(memberNo);
	order.setOrderPrice(orderPrice);
	
	OrderDao orderDao = new OrderDao();
	orderDao.insertOrder(order);
	
	response.sendRedirect(request.getContextPath()+"/selectEbookOne.jsp?=ebookNo="+ebookNo);
%>
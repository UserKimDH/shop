<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");
	
	int qnaNo=Integer.parseInt(request.getParameter("qnaNo"));
	String qnaTitle=request.getParameter("qnaTitle");
	String qnaContent=request.getParameter("qnaContent");

	System.out.println("qnaNo : " + qnaNo);
	System.out.println("qnaTitle : " + qnaTitle);
	System.out.println("qnaContent : " + qnaContent);

	// 방어코드
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	// dao
	QnaDao qnaDao = new QnaDao();
	
	qnaDao.updateQnaMember(qnaNo, qnaTitle, qnaContent);
	response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
%>
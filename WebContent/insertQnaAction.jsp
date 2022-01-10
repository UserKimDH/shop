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
	
	String qnaCategory =request.getParameter("qnaCategory");
	String qnaTitle =request.getParameter("qnaTitle");
	String qnaContent =request.getParameter("qnaContent");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String qnaSecret =request.getParameter("qnaSecret");
	
	// debug
	System.out.println("qnaCategory : " + qnaCategory);
	System.out.println("추가할 qnaTitle : " + qnaTitle);
	System.out.println("추가할 qnaContent : " + qnaContent);
	System.out.println("memberNo : " + memberNo);
	System.out.println("qnaSecret : " + qnaSecret);

	// 방어코드
	if(request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	// dao
	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();
	qna.setQnaCategory(qnaCategory);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setMemberNo(memberNo);
	qna.setQnaSecret(qnaSecret);
	
	qna=qnaDao.insertQnaByMember(qna);
	
	response.sendRedirect(request.getContextPath() + "/index.jsp");

%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");
	
	int noticeNo=Integer.parseInt(request.getParameter("noticeNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String noticeTitle=request.getParameter("noticeTitle");
	String noticeContent=request.getParameter("noticeContent");
	String createDate = request.getParameter("createDate");
	String updateDate = request.getParameter("updateDate");
	
	System.out.println("noticeNo : " + noticeNo);
	System.out.println("memberNo : " + memberNo);
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);
	System.out.println("createDate : " + createDate);
	System.out.println("updateDate : " + updateDate);

	// 방어코드
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/selectNoticeList.jsp");
		return;
	}

	// dao
	NoticeDao noticeDao = new NoticeDao();
	
	noticeDao.updateNotice(noticeNo, noticeTitle, noticeContent);
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
%>
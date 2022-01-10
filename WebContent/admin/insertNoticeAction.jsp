<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// debug
	System.out.println("memberNo : " + memberNo);
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);

	// dao
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = new Notice();
	notice.setMemberNo(memberNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	noticeDao.insertNotice(notice);
	System.out.println("공지 생성 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
%>
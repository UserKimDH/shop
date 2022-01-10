<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	//memberIdCheck값이 공백 or null인지 유효성 검사 
	if(request.getParameter("memberIdCheck") == null || request.getParameter("memberIdCheck").equals("")){ // 파라메터가 null or 공백인경우
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp"); //insertMemberForm.jsp로 반환
		return;
	}
	String memberIdCheck = request.getParameter("memberIdCheck");
	//memberDao.selectMemberId() 호출
	MemberDao memberDao = new MemberDao();	
	String result = memberDao.selectMemberId(memberIdCheck);	
	if(result == null){		
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheck="+memberIdCheck);			
	}else{	
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?idCheckResult=This ID is already taken.");		
	}
%>

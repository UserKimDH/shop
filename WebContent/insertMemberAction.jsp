<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8"); //인코딩	
	//인증 방어 코드 : 로그인 전 session.getAttribute("loginMember") == null 인 경우
	if(session.getAttribute("loginMember")!=null){
		System.out.println("이미 로그인 되어 있음");
		response.sendRedirect("./index.jsp"); //로그인 되면 회원가입 하면 안됨
		return;
	}
	//회원가입 입력값 유효성 검사
	if(request.getParameter("memberId")==null||request.getParameter("memberPw")==null||request.getParameter("memberName")==null||request.getParameter("memberAge")==null||request.getParameter("memberGender")==null){
		System.out.println("입력값 null");
		response.sendRedirect("./insertMemberForm.jsp"); //입력값이 null인 경우
		return;
	}
	
	if(request.getParameter("memberId").equals("")||request.getParameter("memberPw").equals("")||request.getParameter("memberName").equals("")||request.getParameter("memberAge").equals("")||request.getParameter("memberGender").equals("")){
		System.out.println("입력값 공백");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp"); //입력값이 빈경우
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	Member member = new Member();
	MemberDao memberDao = new MemberDao();
	
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberPw(request.getParameter("memberPw"));
	member.setMemberName(request.getParameter("memberName"));
	member.setMemberAge(Integer.parseInt(request.getParameter("memberAge")));
	member.setMemberGender(request.getParameter("memberGender"));
	
	System.out.println(member.getMemberId()+"<--- insertMemberAction - memberId");
	System.out.println(member.getMemberPw()+"<--- insertMemberAction - memberPw");
	System.out.println(member.getMemberAge()+"<--- insertMemberAction - memberAge");
	System.out.println(member.getMemberName()+"<--- insertMemberAction - memberName");
	System.out.println(member.getMemberGender()+"<--- insertMemberAction - memberGender");
	//디버깅
	
	memberDao.insertMember(member);
	response.sendRedirect("./loginForm.jsp");
%>

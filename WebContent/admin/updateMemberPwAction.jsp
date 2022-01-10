<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	//없으면 아래 ~~님 반갑습니다 쪽에 오류
	}
	// 파라미터 받아오기
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPw = request.getParameter("memberPw");
	String memberPwNew = request.getParameter("memberPwNew");
	System.out.println("memberNo :"+memberNo);
	System.out.println("memberPw :"+memberPw);
	System.out.println("memberPwNew:"+memberPwNew);
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	
	memberDao.updateMemberPwByAdmin(member,memberPwNew);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>
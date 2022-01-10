<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없으면 안됨
	if(loginMember==null ){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	//없으면 아래 ~~님 반갑습니다 쪽에 오류
	}
	// 파라미터 받아오기
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo+"<<qnaNo");
	
	Qna qna = new Qna();
	qna.setQnaNo(qnaNo);
	
	System.out.println(qna.getMemberNo()+"<<qnaNo");
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.deleteQnaMember(qnaNo);

	response.sendRedirect(request.getContextPath()+"/selectQnaList.jsp");//모두 실행후 복귀	
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>index.jsp</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
<div>
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<div>
	<h1 class="text-white">쇼핑몰 메인페이지</h1>		
		<!-- 로그인 작업 -->
			<%
				if(session.getAttribute("loginMember") == null) {
			%>
					<div>
						<a href="<%=request.getContextPath() %>/loginForm.jsp" class="btn btn-primary">로그인</a>
						<a href="<%=request.getContextPath() %>/insertMemberForm.jsp" class="btn btn-primary">회원가입</a>
					</div>
			<%		
				} else {
					Member loginMember = (Member)session.getAttribute("loginMember");
			%>
				<!-- 로그인 후-->
				<div>
					<%=loginMember.getMemberId()%>님 반갑습니다.
					<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-primary">로그아웃</a>
					<a href="<%=request.getContextPath()%>/selectMemberOne.jsp?memberId=<%=loginMember.getMemberId() %>"  class="btn btn-primary">회원정보</a>
					<a href="<%=request.getContextPath()%>/selectOrderListByMember.jsp?memberId=<%=loginMember.getMemberId()%>"  class="btn btn-primary">나의주문</a>
				</div>
				
				<!-- 관리자 페이지로 가는 링크 -->
			<%
					if(loginMember.getMemberLevel() > 0) {
			%>
						<div><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp"class="btn btn-waring">관리자 페이지</a></div>
			<%
					}
				}
			%>
	</div>
	<!-- 상품 목록 -->
	<%
		// 페이징
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;
	
		// 전체 목록
		EbookDao ebookDao = new EbookDao();
		ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
		
		// 인기 목록 5개(많이 주문된 5개의 ebook)
		ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
		//신규목록 5개
		ArrayList<Ebook> newEbookList = ebookDao.selectNewEbookList();
		//최근공지
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice> noticeListNew = noticeDao.selectNewNotice(); 
	%>
	<h3 class="text-white">최근 공지</h3>
	<%
		for(Notice n : noticeListNew){
	%>
			<div><a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>" class="text-white"><%=n.getNoticeTitle() %></a></div>
	<%
		}
	%>
	<h2 class="text-white">신상품 목록</h2>
	<table  class="table table-bordered table-dark">
		<tr>
			<%
				for(Ebook e: newEbookList) {
			%>
					<td>
						<div>
							<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200" ></a>
						</div>
						<div><a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>" class="text-white"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>
			<%
				}
			%>
		</tr>
	</table>
	
	<h2 class="text-white">인기 상품 목록</h2>
	<table  class="table table-bordered table-dark">
		<tr>
			<%
				for(Ebook e: popularEbookList) {
			%>
					<td>
						<div>
							<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
						</div>
						<div><a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>" class="text-white"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>
			<%
				}
			%>
		</tr>
	</table>
	
	<h2 class="text-white">전체 상품 목록</h2>
	<table  class="table table-bordered table-dark">
		<tr>
			<%
				int i = 0;
				for(Ebook e : ebookList) {
			%>	
					<td>
						<div>
							<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
						</div>
						<div><a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>" class="text-white"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>	
			<%
					i+=1; // i=i+1; i++; for문 끝날때마다 i는 1씩 증가
					if(i%5 == 0) {
			%>
						</tr><tr><!-- 줄바꿈 -->
			<%			
					}
				}
			%>
		</tr>
	</table>
	<div>하단부 설명</div>
</div>
</body>
</html>
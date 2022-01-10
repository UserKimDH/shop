<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<% 
	request.setCharacterEncoding("utf-8");
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : " + currentPage);

	int ebookNo = Integer.parseInt(request.getParameter("ebookNo")); 
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage - 1) * ROW_PER_PAGE;	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>상품 상세보기 (주문)</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<h1>상품상세보기</h1>
	<div>
		<!-- 상품 상세 출력 -->
		<%
			EbookDao ebookDao = new EbookDao();
			Ebook ebook = ebookDao.selectEbookOne(ebookNo);
			//따로 구현
		%>
	</div>
	<div>
		<!-- 주문 입력을 위한 폼 -->
		<%
		Member loginMember = (Member)session.getAttribute("loginMember");
			//위에다 적는게 좋으나 확인하기 위해 memberNo를 가져오기 위한 코드를 가져옴
		if(loginMember == null){
		%>
			<div>로그인 후에 주문이 가능합니다 <a href="<%=request.getContextPath() %>/loginForm.jsp">로그인페이지로</a></div>
		<%
		}else{
		%>
		<h2>전자책 주문</h2>
		<form id="orderEbookForm"action= "<%=request.getContextPath() %>/insertOrderAction.jsp" method="post">
			<input type="hidden" id="ebookNo" name="ebookNo" value="<%=ebook.getEbookNo()%>">
			<input type="hidden" id="memberNo" name="memberNo" value="<%=loginMember.getMemberNo()%>">
			<input type="hidden" id="orderPrice" name="orderPrice" value="<%=ebook.getEbookPrice()%>">
			<button id="btn" type="button" class="btn btn-primary">주문</button>
		</form>
		<%
		}
		%>
	</div>
	<div>
		<h2>상품 후기</h2>
		<!-- 별점의 평균점수 -->
		<!-- SELECT AVG(order_score) FROM order_comment WHERE ebook_no=? ORDER BY ebook_no-->
		<div>
			<%
			OrderCommentDao orderCommentDao = new OrderCommentDao();
			int countOrderCommentList = orderCommentDao.selectCountOrderComment(ROW_PER_PAGE,ebookNo);
			double avgScore = orderCommentDao.selectOrderScoreAVG(ebookNo);
			%>
			별점 평균 : <%=avgScore %>
		</div>
		<div>
			<h2>후기 목록</h2>
		</div>
		<!-- 이 상품의 상품 후기(페이징) -->
		<%
		// 페이징
		
		ArrayList<OrderComment> commentList = new ArrayList<OrderComment>();
		commentList = orderCommentDao.selectOrderCommentView(beginRow, ROW_PER_PAGE, ebookNo);
		
		// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
		// int 타입의 lastPage에 저장
		// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
		int lastPage = orderCommentDao.selectCountOrderComment(ROW_PER_PAGE, ebookNo);
		
		// 화면에 보여질 페이지 번호의 갯수
		int displayPage = 10;
		
		// 화면에 보여질 시작 페이지 번호
		// ((현재페이지번호 - 1) / 화면에 보여질 페이지 번호) * 화면에 보여질 페이지 번호 + 1
		// (currentPage - 1)을 하는 이유는 현재페이지가 10일시에도 startPage가 1이기 위해서
		int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			
		// 화면에 보여질 마지막 페이지 번호
		// 만약에 마지막 페이지 번호(lastPage)가 화면에 보여질 페이지 번호(displayPage)보다 작다면 화면에 보여질 마지막 페이지번호(endPage)를 조정한다
		// 화면에 보여질 시작 페이지 번호 + 화면에 보여질 페이지 번호 - 1
		// -1을 하는 이유는 페이지 번호의 갯수가 10개이기 때문에 statPage에서 더한 1을 빼준다
		int endPage = 0;
		if(lastPage<displayPage){
			endPage = lastPage;
		} else if (lastPage>=displayPage){
			endPage = startPage + displayPage - 1;
		}
		%>
		<table class="table table-bordered table-dark">
			<thead>
				<tr>
					<td>COMMENT</td>
					<td>DATE</td>
				</tr>
			</thead>
			<tbody>
			<%
			for(OrderComment c : commentList) {
			%>
				<tr>
					<td>
						
					<td><%=c.getOrderCommentContent()%></td>
					<td><%=c.getCreateDate()%></td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
		<%
		if(endPage == 0){
		%>
			<h1>작성된 후기가 없습니다.</h1>
		<%
		}
		// 처음으로 버튼
		// 제일 첫번째 페이지로 이동할때 = 1 page로 이동
		if(currentPage != 1){
			%>
			<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=1%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary center-block">◀처음</a>
		<%
		}
			
		// 이전 버튼
		// 화면에 보여질 시작 페이지 번호가 화면에 보여질 페이지 번호의 갯수보다 크다면 이전 버튼을 생성
		if(startPage > displayPage){
		%>
			<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage-displayPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">&lt;이전</a>
		<%
		}
					
		// 페이징버튼
		// 화면에 보여질 시작 페이지 번호를 화면에 보여질 마지막 페이지 번호까지 반복하면서 페이지 번호 생성
		// 만약에 화면에 보여질 마지막 페이지 번호가 마지막 페이지보다 크다면 for문을 break로 종료시킴
		for(int i=startPage; i<=endPage; i++){
			if(currentPage == i){
		%>
				<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=i%>&ebookNo=<%=ebookNo%>" class="btn btn-secondary"><%=i%></a>
		<%
			} else if(endPage<lastPage || endPage == lastPage){
		%>
				<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=i%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary"><%=i%></a>
		<%	
			} else if(endPage>lastPage){
				break;
			}
		}
			
		// 다음 버튼
		// 화면에 보여질 마지막 페이지 번호가 마지막페이지보다 작다다면 이전 버튼을 생성
		if(endPage < lastPage){
		%>
			<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=startPage+displayPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">다음></a>
		<%
			}
					
		// 끝으로 버튼
		// 가장 마지막 페이지로 바로 이동하는 버튼
		if(currentPage != lastPage && endPage != 0){
		%>
			<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=lastPage%>&ebookNo=<%=ebookNo%>" class="btn btn-outline-secondary">끝▶</a>
		<%
		}
		%>	
	</div>	
	<script>
	$('#btn').click(function(){	
		$('#orderEbookForm').submit();
	});
	</script>
</body>
</html>
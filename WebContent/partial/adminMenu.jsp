<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 jsp에 들어갈 부분jsp -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<table class="table table-dark">
	<tr>
		<td><a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-info">쇼밍몰 홈으로</a></td>
		<td><a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp" class="btn btn-info">회원관리</a></td>
		<td><a href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp" class="btn btn-info">전자책 카테고리 관리</a></td>
		<td><a href="<%=request.getContextPath()%>/admin/selectEbookList.jsp" class="btn btn-info">전자책 관리</a></td>
		<td><a href="<%=request.getContextPath()%>/admin/selectOrderList.jsp" class="btn btn-info">상품평 관리</a></td>
		<td><a href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp" class="btn btn-info">공지게시판 관리</a></td>
		<td><a href="<%=request.getContextPath()%>/admin/selectQnaList.jsp" class="btn btn-info">QnA게시판 관리</a></td>
	</tr>
</table>

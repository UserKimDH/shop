<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 jsp에 들어갈 부분jsp -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<table class="table table-dark">
	<tr>
		<td><a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-info">홈으로</a></td>
		<td><a href="<%=request.getContextPath()%>/selectNoticeForm.jsp" class="btn btn-info">공지사항</a></td>
		<td><a href="<%=request.getContextPath()%>/selectQnaList.jsp" class="btn btn-info">QNA</a></td>
	</tr>
</table>


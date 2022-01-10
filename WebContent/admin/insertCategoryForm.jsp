<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>여기에 제목을 입력하십시오</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<h1>카테고리 추가</h1>
	
	<%
		String categoryCheckResult = "";
		if(request.getParameter("categoryCheckResult") != null){
			categoryCheckResult = request.getParameter("categoryCheckResult");
		}
		String categoryNameCheck = "";
		if(request.getParameter("categoryNameCheck") != null){
			categoryNameCheck = request.getParameter("categoryNameCheck");
		}
	%>
	<form action="<%=request.getContextPath() %>/admin/selectCategoryNameCheckAction.jsp" method="post">
			<div>중복 검사</div>
			<div>
				<input type="text" name="categoryNameCheck"> 
				<button type="submit" class="btn btn-primary">중복 검사</button> 
			<%
				if(!categoryCheckResult.equals("")){
			%>
					<%=request.getParameter("categoryCheckResult") %>
			<%
				}
			%>
			</div>
		</form>
	<form method="post" id="insertCategory" action="<%=request.getContextPath() %>/admin/insertCategoryAction.jsp">
		<div>추가할 카테고리</div>
		<div><input type="text" id="categoeyName" name="categoryName"  value="<%=categoryNameCheck%>" readonly></div>
		<div><button id="btn" type="button" class="btn btn-primary">추가</button></div>
	</form>
	
	<script>
		$('#btn').click(function(){
			if($('#categoeyName').val() == '') {
				alert('categoeyName를 입력하세요');
				return;
			}
			
			$('#insertCategory').submit();
		});	
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); //인코딩	
	//인증 방어 코드 : 로그인 전 session.getAttribute("loginMember") == null 인 경우
	if(session.getAttribute("loginMember")==null){
		System.out.println("로그인 해야됨");
		response.sendRedirect("./index.jsp"); //로그인 안되면 후기 달수 없음.
		return;
	}
	
	System.out.println(request.getParameter("orderNo")+"insertOrderCommentForm - orderNo");
	System.out.println(request.getParameter("ebookNo")+"insertOrderCommentForm - ebookNo");//check
	
	String orderNo="";
	String ebookNo="";
	
	if(request.getParameter("orderNo")!=null||request.getParameter("ebookNo")!=null){
	
		orderNo = request.getParameter("orderNo");
		ebookNo = request.getParameter("ebookNo");
	}
	
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Insert title here</title>	
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">		
	<!-- 입력폼-->
	<form id="insertOrderCommentForm" action="<%=request.getContextPath() %>/insertOrderCommentAction.jsp" method="post">
		<input type="text" hidden="hidden" id="orderNo" name = "orderNo" value="<%=orderNo%>"> <!--액션으로 넘기고 안보이게-->
		<input type="text" hidden="hidden" id="ebookNo" name = "ebookNo" value="<%=ebookNo%>">
		<table  class="table table-bordered table-dark">		
			<tr>			
				<td>내용</td>
				<td><textarea name = "content" id="content"></textarea></td>				
			<tr>			
			<tr>			
				<td>별점</td>				
				<td>				
					<select name ="score" class="score">					
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>					
					</select>				
				</td>			
			</tr>		
		</table>		
		<button type="button" id="btn" class="btn btn-primary">입력</button>	
	</form>	
	
	<script>
		$('#btn').click(function(){
			if($('#content').val() == '') {
				alert('content를 입력하세요');
				return;
			}
			let score = $('.score:checked'); // . 클래스속성으로 부르면 리턴값은 배열
			if(score.length == 0) {
				alert('score를 선택하세요');
				return;
			}
			$('#insertOrderCommentForm').submit();
		});	
	</script>
</body>
</html>
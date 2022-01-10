<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	//수정해야됨
	
	request.setCharacterEncoding("utf-8"); //인코딩		
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo+"<<qnaNo");
	
	QnaDao qnaDao = new QnaDao();	
	
	Qna qna = new Qna();
	qna = qnaDao.selectQnaListOne(qnaNo);
	
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	ArrayList<QnaComment> adminQnaCommentList = qnaCommentDao.selectQnaCommentListAdminByPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>질의 상세</title>
</head>
<body class = "container_fluid p-3 my-3  bg-dark text-white">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 문의내용. 관리자는 강제로 문의내용을 변경할 수 없다 -->
	<div>질의 번호 <%=qna.getQnaNo()%></div>
	<div>분류 <%=qna.getQnaCategory()%></div>
	<div>제목 <%=qna.getQnaTitle()%></div>
	<div>내용 <textarea readonly="readonly"> <%=qna.getQnaContent()%></textarea></div>
	<div>비공개여부 <%=qna.getQnaSecret()%></div>
	<div>문의자 <%=qna.getMemberNo()%></div>
	<div>작성일 <%=qna.getCreateDate()%></div>
	<div>갱신일 <%=qna.getUpdateDate()%></div>
<!-- 코멘트 작성 후 관리자가 보낸 코멘트 표시 -->
	<table class="table table-bordered table-dark">
		<thead>
			<tr>
				<th>문의번호</th>
				<th>작성담당자</th>
				<th>작성내용</th>
				<th>작성일</th>
				<th>갱신일</th>
			</tr>
		</thead>		
		<tbody>
			<%
			for(QnaComment qc : adminQnaCommentList){
			%>				
				<tr>
					<td><%=qc.getQnaNo() %></td>
					<td><%=qc.getMemberNo() %></td>
					<td><%=qc.getQnaCommentContent() %></td>
					<td><%=qc.getCreateDate() %></td>
					<td><%=qc.getUpdateDate() %></td>
				</tr>
			<%
			}
			%>
		</tbody>
	</table>
</body>
</html>
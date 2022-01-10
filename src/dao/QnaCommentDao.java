package dao;

import java.sql.*;
import java.util.*;
import vo.*;
import commons.*;

public class QnaCommentDao {
	//[관리자] 관리자의 질의 응답 답장
	public void insertQnaCommentByAdmin(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		System.out.println(qnaComment + " <-- qnaComment");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO qna_comment qnaComment(qna_no qnaNo,qna_comment_content qnaCommentContent, member_no memberNo,create_date createDate,update_date updateDate) VALUES (?,?,?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getQnaNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
		stmt.setInt(3, qnaComment.getMemberNo());
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println(stmt + " <--stmt");
		
		rs.close();
		stmt.close();
		conn.close();
	}
	//[관리자] 관리자 전체열람 qna
	public ArrayList<QnaComment> selectQnaCommentListAdminByPage() throws ClassNotFoundException, SQLException {
		ArrayList<QnaComment> list = new ArrayList<QnaComment>();

		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo,qna_comment_content qnaCommentContent, member_no memberNo,create_date createDate,update_date updateDate FROM qna_comment ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);

		System.out.println(stmt+"<<stmt");
		ResultSet rs = stmt.executeQuery();
		//리스트에 값 넣기
		while(rs.next()) {
			QnaComment qnaComment = new QnaComment();
			qnaComment.setQnaNo(rs.getInt("qnaNo"));
			qnaComment.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qnaComment.setMemberNo(rs.getInt("memberNo"));
			qnaComment.setCreateDate(rs.getString("createDate"));
			qnaComment.setUpdateDate(rs.getString("updateDate"));
			list.add(qnaComment);
		}
		//접속 종료
		rs.close();
		stmt.close();
		conn.close();
		//값 리턴
		return list;
	}
}

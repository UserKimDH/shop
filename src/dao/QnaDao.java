package dao;

import java.sql.*;
import java.util.*;
import vo.*;
import commons.*;

public class QnaDao {
	//[관리자] 관리자 전체열람 qna
	public ArrayList<Qna> selectQnaListAdminByPage(int beginRow,int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<Qna>();
		System.out.println(beginRow+"<<beinRow");
		System.out.println(rowPerPage+"<<rowPerPage");

		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo,create_date createDate,update_date updateDate FROM qna ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt+"<<stmt");
		ResultSet rs = stmt.executeQuery();
		//리스트에 값 넣기
		while(rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
			list.add(qna);
		}
		//접속 종료
		rs.close();
		stmt.close();
		conn.close();
		//값 리턴
		return list;
	}
	//[회원] 회원관련 qna 전체 열람 //본인문의만확인하도록 해야함
	public ArrayList<Qna> selectQnaListMemberByPage(int beginRow,int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<Qna>();
		System.out.println(beginRow+"<<beinRow");
		System.out.println(rowPerPage+"<<rowPerPage");

		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo,create_date createDate,update_date updateDate FROM qna ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt+"<<stmt");
		ResultSet rs = stmt.executeQuery();
		//리스트에 값 넣기
		while(rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
			list.add(qna);
		}
		//접속 종료
		rs.close();
		stmt.close();
		conn.close();
		//값 리턴
		return list;
	}
	//하나의 qna 상세보기
	public Qna selectQnaListOne(int qnaNo) throws ClassNotFoundException, SQLException{
		System.out.println(qnaNo+"<<qnaNo");
		Qna qna = null;
		
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql = "SELECT qna_no qnaNo, qna_category qnaCategory, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no memberNo,create_date createDate,update_date updateDate FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		ResultSet rs = stmt.executeQuery();
		//값 넣기
		while(rs.next()) {
			qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategory(rs.getString("qnaCategory"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("memberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));	
		}
		//접속 종료
		rs.close();
		stmt.close();
		conn.close();
		return qna;
	}
	//[회원] 질문 추가
	public Qna insertQnaByMember(Qna qna) throws ClassNotFoundException, SQLException {
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql = "INSERT INTO qna(qna_category, qna_title, qna_content, qna_secret,member_no,create_date, update_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getMemberNo());
		System.out.println(stmt+"<<stmt");
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력완료");
		}
		//접속종료
		stmt.close();
		conn.close();
		return qna;
	}
	//[회원] 글 수정
	public void updateQnaMember(int qnaNo,String qnaTitle,String qnaContent) throws ClassNotFoundException, SQLException {
		System.out.println("qnaNo : " + qnaNo);
		System.out.println("noticeTitle : " + qnaTitle);
		System.out.println("noticeContent : " + qnaContent);
		
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리생성, 실행
		String sql = "UPDATE qna SET qna_title=?,qna_content=?,update_date=NOW() WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qnaTitle);
		stmt.setString(2, qnaContent);
		stmt.setInt(3, qnaNo);
		System.out.println(stmt+"<<stmt");
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println(row);
		}
		stmt.close();
		conn.close();
	}
	//[회원]문의 삭제
	public void deleteQnaMember(int qnaNo) throws ClassNotFoundException, SQLException {
		System.out.println(qnaNo+"<<qnaNo");
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리생성, 실행
		String sql = "DELETE FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		System.out.println(stmt+"<<stmt");
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println(row);
		}
		stmt.close();
		conn.close();
	}
}

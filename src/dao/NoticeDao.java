package dao;

import vo.*;

import java.sql.*;
import java.util.*;

import commons.DBUtil;

public class NoticeDao {
	//[모든 인원]인덱스페이지,새 공지
	public ArrayList<Notice> selectNewNotice() throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT notice_no noticeNo,notice_title noticeTitle,notice_content noticeContent,member_no memberNo,create_date createDate,update_date updateDate FROM notice ORDER BY update_date desc limit 0,5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			Notice noticeRs = new Notice();
			noticeRs.setNoticeNo(rs.getInt("noticeNo"));
			noticeRs.setNoticeTitle(rs.getString("noticeTitle"));
			noticeRs.setNoticeContent(rs.getString("noticeContent"));
			noticeRs.setMemberNo(rs.getInt("memberNo"));
			noticeRs.setCreateDate(rs.getString("createDate"));
			noticeRs.setUpdateDate(rs.getString("updateDate"));
			list.add(noticeRs);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
	//[모든 인원]공지페이지,모든 공지 표시
	public ArrayList<Notice> selectNoticePageAll(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT notice_no noticeNo,notice_title noticeTitle,notice_content noticeContent,member_no memberNo,create_date createDate,update_date updateDate FROM notice ORDER BY create_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			Notice noticeRs = new Notice();
			noticeRs.setNoticeNo(rs.getInt("noticeNo"));
			noticeRs.setNoticeTitle(rs.getString("noticeTitle"));
			noticeRs.setNoticeContent(rs.getString("noticeContent"));
			noticeRs.setMemberNo(rs.getInt("memberNo"));
			noticeRs.setCreateDate(rs.getString("createDate"));
			noticeRs.setUpdateDate(rs.getString("updateDate"));
			list.add(noticeRs);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
	//[관리자]관리자용공지페이지,모든 공지 표시
	public ArrayList<Notice> selectNoticePageByAdmin(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT notice_no noticeNo,notice_title noticeTitle,notice_content noticeContent,member_no memberNo,create_date createDate,update_date updateDate FROM notice ORDER BY create_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			Notice noticeRs = new Notice();
			noticeRs.setNoticeNo(rs.getInt("noticeNo"));
			noticeRs.setNoticeTitle(rs.getString("noticeTitle"));
			noticeRs.setNoticeContent(rs.getString("noticeContent"));
			noticeRs.setMemberNo(rs.getInt("memberNo"));
			noticeRs.setCreateDate(rs.getString("createDate"));
			noticeRs.setUpdateDate(rs.getString("updateDate"));
			list.add(noticeRs);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
	//공지 상세보기
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		Notice notice = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo,notice_title noticeTitle,notice_content noticeContent,member_no memberNo,create_date createDate,update_date updateDate FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setMemberNo(rs.getInt("memberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return notice;
	}
	//[관리자] 공지 생성
	public void insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
		System.out.println(notice + " <--notice");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO notice(notice_title, notice_content, member_no ,create_date ,update_date ) VALUES (?,?,?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getMemberNo());
		ResultSet rs = stmt.executeQuery();
		// debug
		System.out.println(stmt + " <--stmt");
		
		rs.close();
		stmt.close();
		conn.close();
	}
	//[관리자] 공지내용을 수정
	public void updateNotice(int noticeNo,String noticeTitle, String noticeContent) throws ClassNotFoundException, SQLException {
		System.out.println("noticeNo : " + noticeNo);
		System.out.println("noticeTitle : " + noticeTitle);
		System.out.println("noticeContent : " + noticeContent);
		
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리생성, 실행
		String sql = "UPDATE notice SET notice_title=?,notice_content=?,update_date=NOW() WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, noticeTitle);
		stmt.setString(2, noticeContent);
		stmt.setInt(3, noticeNo);
		System.out.println(stmt+"<<stmt");
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println(row);
		}
		stmt.close();
		conn.close();
	}
	//[관리자] 공지를 삭제
	public void deleteNotice(int noticeNo) throws ClassNotFoundException, SQLException {
		System.out.println(noticeNo+"<<noticeNo");
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리생성, 실행
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		System.out.println(stmt+"<<stmt");
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println(row);
		}
		stmt.close();
		conn.close();
	}
	//페이지	
	public int selectCountNotice(int ROW_PER_PAGE) throws ClassNotFoundException, SQLException  {
		int totalCount = 0;
		int lastPage = 0;
		
		// 디버깅
		System.out.println(ROW_PER_PAGE + "<-- ROW_PER_PAGE");
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT count(*) FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println("총 행의 개수 stmt : "+stmt);
		
		// 리스트에 값 넣기
		if(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		System.out.println("totalCounnt(총 행의 개수) : "+totalCount);
				
		// 마지막 페이지
		// lastPage를 전체 행의 수와 한 페이지에 보여질 행의 수(rowPerPage)를 이용하여 구한다
		lastPage = totalCount / ROW_PER_PAGE;
		if(totalCount % ROW_PER_PAGE != 0) {
			lastPage+=1;
			}
		System.out.println("lastPage(마지막 페이지 번호) : "+lastPage);
				
		rs.close();
		stmt.close();
		conn.close();
				
		return lastPage;
	}
}

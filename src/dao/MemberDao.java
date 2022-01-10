package dao;

import java.sql.*;
import java.util.*;

import vo.*;
import commons.*;


public class MemberDao {
	// [회원] 멤버 아이디 중복 검사
	public String selectMemberId(String memberIdCheck) throws ClassNotFoundException, SQLException{
		String memberId = null;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql="SELECT member_id memberId FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,memberIdCheck);
		System.out.println(stmt+"<-------- dao.selectMemberId - stmt");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
			memberId= rs.getString("memberId");
		}
		
		rs.close();
		stmt.close();
		conn.close();
	
		return memberId; // null -> 사용가능한ID, 아니면 이미 사용중인 ID
	}
	//[비회원]아이디 ,회원 가입
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {
		
		System.out.println(member.getMemberId()+"<<memberId");
		System.out.println(member.getMemberPw()+"<<memberPw");
		System.out.println(member.getMemberName()+"<<memberName");
		System.out.println(member.getMemberAge()+"<<memberAge");
		System.out.println(member.getMemberGender()+"<<memberGender");		
		/*
		 	INSERT INTO member(member_id, member_pw,member_level,member_name,member_age,member_gender,update_date,create_date) VALUES(?,PASSWORD(?),0,?,?,?,NOW(),NOW())
		 */
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql="INSERT INTO member(member_id, member_pw,member_level, member_name, member_age, member_gender, update_date, create_date) VALUES (?, PASSWORD(?), 0, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		System.out.println(stmt+"<<stmt");
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력완료");
		}
		//접속종료
		stmt.close();
		conn.close();
	}
	//[회원]로그인
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		Member returnMember = null;
		/*
 			SELECT member_no memberNo, member_id memberId, member_level memberLevel FROM member WHERE member_id=? AND member_pw=PASSWORD(?)
		 */
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel FROM member WHERE member_id=? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		System.out.println(stmt+"<<stmt");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnMember = new Member();
			returnMember.setMemberNo(rs.getInt("memberNo"));
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			return returnMember;
		}
		System.out.println(rs+"<<rs");
		//접속종료
		rs.close();
		stmt.close();
		conn.close();
		return returnMember;
	}
	//[관리자] 회원 리스트 관리(회원목록출력)
	public ArrayList<Member> selectMemberListAllByPage(int beginRow,int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Member> list = new ArrayList<Member>();
		System.out.println(beginRow+"<<beinRow");
		System.out.println(rowPerPage+"<<rowPerPage");
		/*
		 	SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?,?
		 */
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리 생성 및 실행
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt+"<<stmt");
		ResultSet rs = stmt.executeQuery();
		//리스트에 값 넣기
		while(rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		//접속 종료
		rs.close();
		stmt.close();
		conn.close();
		//값 리턴
		return list;
	}
	//ISSUE : 검색ID가 있으나 없으나 TOTALCOUNT가 동일. 검색ID에 따라 변동해야함. 내가 해보기
	//총 멤버 수
	public int totalMemberCount() throws ClassNotFoundException, SQLException {
		int totalCount = 0 ;
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리생성, 실행
		String sql = "SELECT count(*) FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<<stmt");
		ResultSet rs= stmt.executeQuery();
		while(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		rs.close();
		stmt.close();
		conn.close();
		return totalCount;
	}
	public int totalMemberCount(String searchMemberId) throws ClassNotFoundException, SQLException {
		int totalCount = 0 ;
		//db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리생성, 실행
		String sql = "SELECT count(*) FROM member WHERE member_id LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchMemberId+"%");
		System.out.println(stmt+"<<stmt");
		ResultSet rs= stmt.executeQuery();
		while(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		rs.close();
		stmt.close();
		conn.close();
		return totalCount;
	}
	//[관리자] 회원 리스트 관리(회원 ID 검색에 따른 회원목록 출력)
		public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow,int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException {
			ArrayList<Member> list = new ArrayList<Member>();
			System.out.println(beginRow+"<<beinRow");
			System.out.println(rowPerPage+"<<rowPerPage");
			System.out.println(searchMemberId+"<<searchMemberId");
			/*
				SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id Like ? ORDER BY create_date DESC LIMIT ?,?
			 */
			//db접속 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			//쿼리 생성 및 실행
			String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id Like ? ORDER BY create_date DESC LIMIT ?,?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchMemberId+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println(stmt+"<<stmt");
			ResultSet rs = stmt.executeQuery();
			//리스트에 값 넣기
			while(rs.next()) {
				Member member = new Member();
				member.setMemberNo(rs.getInt("memberNo"));
				member.setMemberId(rs.getString("memberId"));
				member.setMemberLevel(rs.getInt("memberLevel"));
				member.setMemberName(rs.getString("memberName"));
				member.setMemberAge(rs.getInt("memberAge"));
				member.setMemberGender(rs.getString("memberGender"));
				member.setUpdateDate(rs.getString("updateDate"));
				member.setCreateDate(rs.getString("createDate"));
				list.add(member);
			}
			//접속 종료
			rs.close();
			stmt.close();
			conn.close();
			//값 리턴
			return list;
		}
		//[관리자] 특정회원의 등급(일반 회원,관리자)을 수정 <== 대상의 memberNo,직급(memberLevel)을 찾고 새로운 레벨을 받아 수정
		public void updateMemberLevelByAdmin(Member member) throws ClassNotFoundException, SQLException {
			System.out.println(member.getMemberNo()+"<<memberNo");
			System.out.println(member.getMemberPw()+"<<memberPassWord");
			System.out.println(member.getMemberLevel()+"<<memberLevel");
			//db접속 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			//쿼리생성, 실행
			String sql = "UPDATE member SET member_level=?,update_date=NOW() WHERE member_no=? AND member_pw=PASSWORD(?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
			stmt.setString(3, member.getMemberPw());
			System.out.println(stmt+"<<stmt");
			int row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println(row);
			}
			stmt.close();
			conn.close();
		}
		//[관리자] 특정회원의 비밀번호를 수정 <== 대상의 memberNo,memberPw를 찾고 새로운 비밀번호를 받아 수정
		public void updateMemberPwByAdmin(Member member,String memberPwNew) throws ClassNotFoundException, SQLException {
			System.out.println(member.getMemberNo()+"<<memberNo");
			System.out.println(member.getMemberPw()+"<<memberPassWord");
			System.out.println(memberPwNew+"<<memberPwNew");
			//db접속 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			//쿼리생성, 실행
			String sql = "UPDATE member SET member_pw=PASSWORD(?),update_date=NOW() WHERE member_no=? AND member_pw=PASSWORD(?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberPwNew);
			stmt.setInt(2, member.getMemberNo());
			stmt.setString(3, member.getMemberPw());
			System.out.println(stmt+"<<stmt");
			int row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println(row);
			}
			stmt.close();
			conn.close();
		}
		//[관리자] 특정회원을 강제로삭제 <== 대상의 memberNo를 찾아 삭제
		public void deleteMemberByAdmin(int memberNo) throws ClassNotFoundException, SQLException {
			System.out.println(memberNo+"<<memberNo");
			//db접속 메소드 호출
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			//쿼리생성, 실행
			String sql = "DELETE FROM member WHERE member_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, memberNo);
			System.out.println(stmt+"<<stmt");
			int row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println(row);
			}
			stmt.close();
			conn.close();
		}
		public Member selectMemberIdByMember(String memberId) throws ClassNotFoundException, SQLException{
		Member member = null;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql="SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,memberId);
		System.out.println(stmt+"<-------- dao.selectMemberId - stmt");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()){
			member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
	
		return member; // null -> 사용가능한ID, 아니면 이미 사용중인 ID
	}
}

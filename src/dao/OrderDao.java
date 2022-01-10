package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;
import vo.Member;
import vo.Order;
import vo.OrderEbookMember;

public class OrderDao {
	//[회원] 회원용 주문내역
	public ArrayList<OrderEbookMember> selectOrderListByMember(int memberNo) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo,e.ebook_no ebookNo,e.ebook_title ebookTitle,m.member_no memberNo,m.member_id memberId,o.order_price orderPrice,o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE m.member_no=? ORDER BY o.create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	//[관리자] 관리자용 주문내역
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo,e.ebook_no ebookNo,e.ebook_title ebookTitle,m.member_no memberNo,m.member_id memberId,o.order_price orderPrice,o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no ORDER BY o.create_date DESC Limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	//[고객] 주문
	public void insertOrder(Order order) throws ClassNotFoundException, SQLException {
		//db접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리생성실행
		String sql = "INSERT INTO orders(ebook_no, member_no, order_price, update_date, create_date) VALUES (?,?,?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, order.getEbookNo());
		stmt.setInt(2, order.getMemberNo());
		stmt.setInt(3, order.getOrderPrice());
		ResultSet rs = stmt.executeQuery();
		// 디버깅
		System.out.println(stmt + " <-- CategoryDao.insertCategory stmt");
		
		rs.close();
		stmt.close();
		conn.close();
	}
	// [관리자] order 마지막 페이지 도출
	public int selectOrderLastPage(int rowPerPage, String category) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		// 마리아db 연결 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "";
		if (category.equals("") == true) {
			sql = "SELECT COUNT(*) from order";
		} else {
			sql = "SELECT COUNT(*) from order WHERE category_name LIKE '%" + category + "%'";
		}

		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		int totalRowCount = 0;

		System.out.println("[Debug] selectebookLastPage stmt : " + stmt);
		System.out.println("[Debug] selectebookLastPage rs : " + rs);

		if (rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
		}
		lastPage = totalRowCount / rowPerPage;
		if (totalRowCount % rowPerPage != 0) {
			lastPage++;
		}

		rs.close();
		stmt.close();
		conn.close();

		return lastPage;
	}
	//[회원] 회원용 상세정보보기
	public OrderEbookMember selectOrderOneByMember(int orderNo,int memberNo) throws ClassNotFoundException, SQLException {
		OrderEbookMember oem = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo,e.ebook_no ebookNo,e.ebook_title ebookTitle,m.member_no memberNo,m.member_id memberId,o.order_price orderPrice,o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE m.member_no=? AND o.order_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,memberNo);
		stmt.setInt(2,orderNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return oem;
	}
	//[회원] 회원용 상세정보보기
	public void selectOrderOneByAdmin(Order order) throws ClassNotFoundException, SQLException {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo,e.ebook_no ebookNo,e.ebook_title ebookTitle,m.member_no memberNo,m.member_id memberId,o.order_price orderPrice,o.create_date createDate FROM orders o INNER JOIN ebook e INNER JOIN member m ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no WHERE o.order_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, order.getOrderNo());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
		}
		rs.close();
		stmt.close();
		conn.close();
	}
	//페이지	
	public int selectCountOrder(int ROW_PER_PAGE) throws ClassNotFoundException, SQLException  {
		int totalCount = 0;
		int lastPage = 0;
		
		// 디버깅
		System.out.println(ROW_PER_PAGE + "<-- ROW_PER_PAGE");
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT count(*) FROM orders";
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

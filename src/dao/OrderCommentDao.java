package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Member;
import vo.OrderComment;

public class OrderCommentDao {
	
	//[all] 입력
	public void insertOrderCommentReview(OrderComment comment)throws SQLException, ClassNotFoundException {
		
		DBUtil dbutil = new DBUtil();
		int check = 0; //실행성공 여부 확인 
		System.out.println(comment.getOrderNo()+"<------dao.insertOrderCommentReview - getOrderNo");
		System.out.println(comment.getEbookNo()+"<------dao.insertOrderCommentReview - getEbookNo");
		System.out.println(comment.getOrderScore()+"<------dao.insertOrderCommentReview - getOrderScore");
		System.out.println(comment.getOrderCommentContent()+"<------dao.insertOrderCommentReview - getOrderCommentContent");
		//파라미터 확인
		Connection conn = dbutil.getConnection();
		String sql ="INSERT INTO order_comment(order_no, ebook_no, order_score, order_comment_content, create_date, update_date) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setInt(1,comment.getOrderNo());
		stmt.setInt(2, comment.getEbookNo());
		stmt.setInt(3, comment.getOrderScore());
		stmt.setString(4, comment.getOrderCommentContent());
		System.out.println(stmt+"<------dao.insertOrderCommentReview - stmt"); //쿼리 및 파라미터 확인
		check = stmt.executeUpdate(); // 확인용
		if(check == 1) {
			System.out.println("성공");
		}else {
			System.out.println("실패");
		}
		stmt.close();
		conn.close();
		
		return;
		
	}
	//별점 평균
	public double selectOrderScoreAVG(int ebookNo) throws ClassNotFoundException, SQLException {
		double avgScore = 0;
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT AVG(order_score) av FROM order_comment WHERE ebook_no=? ORDER BY ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,ebookNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			avgScore = rs.getDouble("av");
		}
		rs.close();
		stmt.close();
		conn.close();
		return avgScore;
	}
	//후기 나열
	public ArrayList<OrderComment> selectOrderCommentView(int beginRow, int rowPerPage, int ebookNo)throws ClassNotFoundException, SQLException {
		ArrayList<OrderComment> list = new ArrayList<OrderComment>();
		System.out.println(beginRow + "<<beinRow");
		System.out.println(rowPerPage + "<<rowPerPage");
		System.out.println(ebookNo + "<<ebookNo");	

		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 쿼리 생성 및 실행
		String sql = "SELECT order_score orderScore, order_comment_content orderCommentContent, create_date createDate FROM order_comment WHERE ebook_no=? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		// 리스트에 값 넣기
		while (rs.next()) {
			OrderComment orderComment = new OrderComment();
			orderComment.setOrderScore (rs.getInt("orderScore"));
			orderComment.setOrderCommentContent (rs.getString("orderCommentContent"));
			orderComment.setCreateDate (rs.getString("createDate"));
			list.add(orderComment);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
	//페이지
	
	public int selectCountOrderComment(int ROW_PER_PAGE, int ebookNo) throws ClassNotFoundException, SQLException  {
		int totalCount = 0;
		int lastPage = 0;
		
		// 디버깅
		System.out.println(ROW_PER_PAGE + "<--- OrderCommentDao.selectCommentListLastPage parem : ROW_PER_PAGE");
		System.out.println(ebookNo + "<--- OrderCommentDao.selectCommentListLastPage parem : ebookNo");
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT count(*) FROM order_comment WHERE ebook_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		
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
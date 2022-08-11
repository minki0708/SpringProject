package com.spring.javagreenS_jmk;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.junit.Test;

import com.spring.javagreenS_jmk.vo.LikesVO;

public class JUnitTest {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/javagreen_jmk";
		return DriverManager.getConnection(url, "root", "1234");
	}
	
//	@Test
//	public void getBoard() {
//		BoardVO vo = null;
//		try {
//			conn = getConnection();
//			String sql = "select * from board order by idx desc limit 2";
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				vo = new BoardVO();
//				vo.setIdx(rs.getInt("idx"));
//				vo.setMid(rs.getString("mid"));
//				vo.setNickName(rs.getString("nickName"));
//				vo.setTitle(rs.getString("title"));
//				vo.setEmail(rs.getString("email"));
//				vo.setHomePage(rs.getString("homePage"));
//				vo.setContent(rs.getString("content"));
//				System.out.println("vo : " + vo);
//			}
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	}
	//아이디 입력시 찜하기(좋아요) 확인
	@Test
	public void userlikesCheck() {
		String mid= "admin";
		LikesVO vo = getLikes(mid);
		System.out.println("vo : "+vo);
	}
	
	private LikesVO getLikes(String mid) {
		LikesVO vo = new LikesVO();
		try {
			conn = getConnection();
			String sql = "select * from likes2 where userIdx = (select idx from user2 where mid = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new LikesVO();
				vo.setUserIdx(rs.getInt("userIdx"));
				vo.setProductIdx(rs.getInt("productIdx"));
				System.out.println("vo : " + vo);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
}

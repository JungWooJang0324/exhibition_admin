package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import VO.ExHallVO;
import connection.DbConnection;

public class ExHallManagerDAO {

	/**
	 * 테이블 레코드의 개수를 구하는 메소드
	 * 
	 * @return
	 */
	public int getTotalRows(String option, String keyword) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();

		try {

			con = dc.getConn();

			StringBuilder sql = new StringBuilder();

			sql.append("	select count(ex_hall_num) from exhibition_hall			");

			if ("".equals(keyword) || keyword == null) {
				pstmt = con.prepareStatement(sql.toString());

				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
			} else {
				sql.append("	where ").append(option).append(" like '%'||?||'%'		");

				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, keyword.trim());

				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	
	
	/**
	 * 전시장 검색 select 함수
	 * 
	 * @param start
	 * @param end
	 * @param option
	 * @param keyword
	 * @return
	 * @throws ClassNotFoundException
	 * @throws NamingException
	 */
	public List<ExHallVO> selectExHall(int startRow, int pageSize, String option, String keyword)
			throws ClassNotFoundException, NamingException {
		List<ExHallVO> hallList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();

		try {

			con = dc.getConn();

			StringBuilder selectExHall = new StringBuilder();
			selectExHall
				.append("	select * 																		")
				.append(" 	from (select rownum as rnum, ex_hall_name, ex_loc, ex_hall_num 					")
				.append("		from( select *	from EXHIBITION_HALL										")
				.append("				where  																").append(option)
				.append(" 				like '%'||?||'%' order by ex_hall_num	desc) where rownum <=? )	")
				.append("	where rnum >= ?  order by rnum 													");

			pstmt = con.prepareStatement(selectExHall.toString());
			pstmt.setString(1, keyword.trim());
			pstmt.setInt(2, pageSize+startRow-1);
			pstmt.setInt(3, startRow);

			rs = pstmt.executeQuery();

			hallList = new ArrayList<ExHallVO>();

			ExHallVO ehVO = null;
			while (rs.next()) {
				ehVO = new ExHallVO();
				ehVO.setRnum(rs.getInt("rnum"));
				ehVO.setExHallNum(rs.getInt("ex_hall_num"));
				ehVO.setExName(rs.getString("ex_hall_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				hallList.add(ehVO);
			}


		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return hallList;

	}// searchExHall

	public void insertExhibitonHall(ExHallVO ehVO) throws ClassNotFoundException, NamingException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		try {
			conn = dc.getConn();

			String insertExhibitonHall = "insert into EXHIBITION_HALL(ex_hall_num, ex_hall_name, ex_loc, zipcode, latitude, longitude, mgr_name, mgr_tel, ex_tel, address1, address2) values(ex_hall_seq.nextval, ?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(insertExhibitonHall);

			pstmt.setString(1, ehVO.getExName());
			pstmt.setString(2, ehVO.getExLoc());
			pstmt.setString(3, ehVO.getZipcode());
			pstmt.setDouble(4, ehVO.getLatitude());
			pstmt.setDouble(5, ehVO.getLongitude());
			pstmt.setString(6, ehVO.getMgrName());
			pstmt.setString(7, ehVO.getMgrTel());
			pstmt.setString(8, ehVO.getExTel());
			pstmt.setString(9, ehVO.getAddress1());
			pstmt.setString(10, ehVO.getAddress2());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(null, pstmt, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}// insertExhibitonHall

	public int updateExhibitonHall(ExHallVO ehVO) throws ClassNotFoundException, NamingException {
		int cnt = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection dc = DbConnection.getInstance();

		try {
			con = dc.getConn();

			StringBuilder upadateExhibitonHall = new StringBuilder();

			upadateExhibitonHall.append("	update EXHIBITION_HALL														")
								.append("	set	ex_hall_name=?, address1=?, address2=?, zipcode=?, latitude=?, "
												+ "longitude=?, mgr_name=?, mgr_tel=?, ex_tel=?							")
								.append("	where ex_hall_num=?															");

			pstmt = con.prepareStatement(upadateExhibitonHall.toString());

			pstmt.setString(1, ehVO.getExName());
			pstmt.setString(2, ehVO.getAddress1());
			pstmt.setString(3, ehVO.getAddress2());
			pstmt.setString(4, ehVO.getZipcode());
			pstmt.setDouble(5, ehVO.getLatitude());
			pstmt.setDouble(6, ehVO.getLongitude());
			pstmt.setString(7, ehVO.getMgrName());
			pstmt.setString(8, ehVO.getMgrTel());
			pstmt.setString(9, ehVO.getExTel());
			pstmt.setInt(10, ehVO.getExHallNum());

			cnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(null, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
	}// upadateExhibitonHall

	public int deleteExhibitonHall(int hallNum) throws ClassNotFoundException, NamingException {
		int cnt = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection dc = DbConnection.getInstance();

		try {
			con = dc.getConn();

			String deleteExhibitonHall = "delete from EXHIBITION_HALL where EX_HALL_NUM=? ";

			pstmt = con.prepareStatement(deleteExhibitonHall);

			pstmt.setInt(1, hallNum);

			cnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(null, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
	}// deleteExhibitonHall

	public ExHallVO selectExhibitonHallDetail(int hallNum) throws ClassNotFoundException, NamingException {

		ExHallVO ehVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();

		try {

			con = dc.getConn();

			StringBuilder selectExhibitonHallDetail = new StringBuilder();
			selectExhibitonHallDetail.append(
					"	select EX_HALL_NUM, ex_hall_name, ex_loc, zipcode, latitude, longitude, mgr_name, mgr_tel, ex_tel, address1, address2	")
					.append("	from EXHIBITION_HALL 																			")
					.append("	where ex_hall_num=?																				");

			pstmt = con.prepareStatement(selectExhibitonHallDetail.toString());

			pstmt.setInt(1, hallNum);

			rs = pstmt.executeQuery();
			ehVO = new ExHallVO();

			while (rs.next()) {
				ehVO.setExHallNum(rs.getInt("ex_hall_num"));
				ehVO.setExName(rs.getString("ex_hall_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				ehVO.setZipcode(rs.getString("zipcode"));
				ehVO.setLatitude(rs.getDouble("latitude"));
				ehVO.setLongitude(rs.getDouble("longitude"));
				ehVO.setMgrName(rs.getString("mgr_name"));
				ehVO.setMgrTel(rs.getString("mgr_tel"));
				ehVO.setExTel(rs.getString("ex_tel"));
				ehVO.setAddress1(rs.getString("address1"));
				ehVO.setAddress2(rs.getString("address2"));
			}


		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return ehVO;
	}// selectExhibitonHallDetail

	
	
//	 public static void main(String[] args) { 
//		 ExHallManagerDAO ehmDAO = new ExHallManagerDAO (); 
//		 System.out.println(ehmDAO.getTotalRows("ex_hall_name","경기"));
//		 try {
//			 System.out.println(ehmDAO.selectAllExHall(0,10));
////			System.out.println(ehmDAO.selectSearchExHall(0,10,"",""));
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (NamingException e) {
//			e.printStackTrace();
//		}
//	 
//	 }//main

}

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
	 * @return
	 */
	public int getTotalRows(String category, String keyword) {
		int count=0;
		
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
		
		try {
			
			con=dc.getConn();
			
			StringBuilder sql = new StringBuilder();
			sql
			.append("	select count(ex_hall_num) from exhibition_hall			")
			.append("	where ").append(category).append(" like '%'||?||'%'		");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, keyword);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count; 
	} 
	
	
	
	/**
	 * 모든 값 select 함수
	 * @param start
	 * @param end
	 * @return
	 * @throws ClassNotFoundException
	 * @throws NamingException
	 */
	public List<ExHallVO> selectAllExHall(int start, int end) throws ClassNotFoundException, NamingException{
		List<ExHallVO> hallList=null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
		
		try {
			
			con=dc.getConn();
			
			StringBuilder selectExHall = new StringBuilder();
			selectExHall
			.append("	select b.rnum, b.ex_name, b.ex_loc, b.ex_hall_num														")
			.append("	from( select rownum as rnum, a.ex_name, a.ex_loc, a.ex_hall_num 										")
			.append("	from (SELECT ex_hall_num, ex_name, ex_loc from EXHIBITION_HALL order by ex_hall_num) a 	")
			.append("	where rownum < ?) b 																	")
			.append("	where rnum >?   																		")
			.append("	order by rnum desc																		");
			
			pstmt = con.prepareStatement(selectExHall.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs= pstmt.executeQuery();
			
			hallList=  new ArrayList<ExHallVO>();
			
			ExHallVO ehVO= null;
			while(rs.next()) {
				ehVO= new ExHallVO();
				ehVO.setExHallNum(rs.getInt("ex_hall_num"));
				ehVO.setExName(rs.getString("ex_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				ehVO.setRnum(rs.getInt("rnum"));
				hallList.add(ehVO);
			}	
			
			System.out.println("전시장 검색 목록 select 성공");
			
		} catch (SQLException e) {
			e.printStackTrace();	
			System.out.println("왜 jsp에서는 안되냐?!");
		}finally {
			
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return hallList;
		
	}//allExHall
	
	/**
	 * 검색한 값 select 함수
	 * @param start
	 * @param end
	 * @param category
	 * @param keyword
	 * @return
	 * @throws ClassNotFoundException
	 * @throws NamingException
	 */
	public List<ExHallVO> selectSearchExHall(int start, int end, String category, String keyword) throws ClassNotFoundException, NamingException{
		List<ExHallVO> hallList=null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
		
		try {
			
			con=dc.getConn();
			
			StringBuilder selectExHall = new StringBuilder();
			selectExHall
			.append("	select b.rnum, b.ex_name, b.ex_loc 														")
			.append("	from( select rownum as rnum, a.ex_name, a.ex_loc 										")
			.append("	from (SELECT ex_hall_num, ex_name, ex_loc from EXHIBITION_HALL order by ex_hall_num) a 	")
			.append("	where rownum < ?) b 																	")
			.append("	where rnum >?  and ").append(category).append(" like '%'||?||'%'						")
			.append("	order by rnum desc																		");
			
			pstmt = con.prepareStatement(selectExHall.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			pstmt.setString(3, keyword);
			
			rs= pstmt.executeQuery();
			
			hallList=  new ArrayList<ExHallVO>();
			
			ExHallVO ehVO= null;
			while(rs.next()) {
				ehVO= new ExHallVO();
				ehVO.setExHallNum(rs.getInt("rnum"));
				ehVO.setExName(rs.getString("ex_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				hallList.add(ehVO);
			}	
			
			System.out.println("전시장 검색 목록 select 성공");
			
		} catch (SQLException e) {
			e.printStackTrace();	
		}finally {
			
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return hallList;
		
	}//searchExHall
	
	
	public void insertExhibitonHall(ExHallVO ehVO) throws ClassNotFoundException, NamingException{
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		try {
				conn = dc.getConn();
				
				String insertExhibitonHall
					= "insert into EXHIBITION_HALL(ex_hall_num, ex_name, ex_loc, zipcode, latitude, longitude, mgr_name, mgr_tel, ex_tel, address1, address2) values(ex_hall_seq.nextval, ?,?,?,?,?,?,?,?,?,?)";
				pstmt=conn.prepareStatement(insertExhibitonHall);
				
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
				
				System.out.println("전시장 insert 성공");
				
		} catch (SQLException e) {
			e.printStackTrace();		
		}finally {
			try {
				dc.close(null, pstmt, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}//insertExhibitonHall
	
	
	public boolean upadateExhibitonHall(ExHallVO ehVO) throws ClassNotFoundException, NamingException{
		int num=0;
		boolean flag=false;
		
		Connection con=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		
		try {
				con = dc.getConn();

				StringBuilder upadateExhibitonHall=new StringBuilder();
				
				upadateExhibitonHall
				.append("	update EXHIBITION_HALL												")
				.append("	set	ex_name=?, address1=?, address2=?, zipcode=?, latitude=?, "
						+ "longitude=?, mgr_name=?, mgr_tel=?, ex_tel=?							")
				.append("	where ex_hall_num=?													");
				
				
				pstmt=con.prepareStatement(upadateExhibitonHall.toString());

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
				
				num=pstmt.executeUpdate();
				
				System.out.println("전시장 update 성공");
		
		} catch (SQLException e) {
			e.printStackTrace();		
		}finally {
			try {
				dc.close(null, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if(num>0) {
			return flag = true;  //업데이트 성공
		}
		return flag; //업데이트 실패
	}//upadateExhibitonHall
	
	
	public boolean deleteExhibitonHall(int exHallNum) throws ClassNotFoundException, NamingException{
		int num=0;
		boolean flag=false;
		
		Connection con=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		
		try {
				con = dc.getConn();

				String deleteExhibitonHall= "delete from EXHIBITION_HALL where ex_hall_num=? ";
				
				pstmt=con.prepareStatement(deleteExhibitonHall);

				pstmt.setInt(1, exHallNum); 
				
				num=pstmt.executeUpdate();
				
				System.out.println("전시장 delete 성공");
		
		} catch (SQLException e) {
			e.printStackTrace();		
		}finally {
			try {
				dc.close(null, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if(num>0) {
			return flag = true;  //삭제 성공
		}
		return flag; //삭제 실패
		
	}//deleteExhibitonHall
	
	
	public ExHallVO selectExhibitonHallDetail(int hallNum) throws ClassNotFoundException, NamingException {

		ExHallVO ehVO= null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
			
		try {
			
			con=dc.getConn();
			
			StringBuilder selectExhibitonHallDetail = new StringBuilder();
			selectExhibitonHallDetail
			.append("	select EX_HALL_NUM, ex_name, ex_loc, zipcode, latitude, longitude, mgr_name, mgr_tel, ex_tel	")
			.append("	from EXHIBITION_HALL 																			")
			.append("	where ex_hall_num=?																				");
			
			pstmt = con.prepareStatement(selectExhibitonHallDetail.toString());
			
			pstmt.setInt(1, hallNum);
			
			rs = pstmt.executeQuery();
			ehVO= new ExHallVO();
			
			while(rs.next()) {
				ehVO.setExHallNum(rs.getInt("ex_hall_num"));
				ehVO.setExName(rs.getString("ex_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				ehVO.setZipcode(rs.getString("zipcode"));
				ehVO.setLatitude(rs.getDouble("latitude"));
				ehVO.setLatitude(rs.getDouble("longitude"));
				ehVO.setMgrName(rs.getString("mgr_name"));
				ehVO.setMgrTel(rs.getString("mgr_tel"));
				ehVO.setExTel(rs.getString("ex_tel"));
			}	
		
			System.out.println("전시 상세 select 성공");	
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return ehVO; 
	}//selectExhibitonHallDetail

	
	
//	 public static void main(String[] args) { 
//		 ExHallManagerDAO ehmDAO = new ExHallManagerDAO (); 
//		 System.out.println(ehmDAO.getTotalRows("ex_name","경기"));
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
	


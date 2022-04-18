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
	
		
	public List<ExHallVO> selectExhibitonHall(String exName) throws ClassNotFoundException, NamingException{
		
		List<ExHallVO> hallList=null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
			
		try {
			con=dc.getConn();
			
			StringBuilder selectExhibitionHall = new StringBuilder();
			selectExhibitionHall
			.append("	SELECT ex_hall_num, ex_name, ex_loc	")
			.append("	from EXHIBITION_HALL				")
			.append("	where ex_name like '%'||?||'%'		");
			
			pstmt = con.prepareStatement(selectExhibitionHall.toString());
			pstmt.setString(1, exName);
			
			rs= pstmt.executeQuery();
			
			hallList=  new ArrayList<ExHallVO>();
					
			ExHallVO ehVO= null;
			while(rs.next()) {
				ehVO= new ExHallVO();
				ehVO.setExHallNum(rs.getInt("ex_hall_num"));
				ehVO.setExName(rs.getString("ex_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				hallList.add(ehVO);
			}	
			
			System.out.println("전시장 목록 select 성공");
			
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
	}//selectExhibitonHall
	
	
	public void insertExhibitonHall(ExHallVO ehVO) throws ClassNotFoundException, NamingException{
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		try {
				conn = dc.getConn();
				
				String insertExhibitonHall
					= "insert into EXHIBITION_HALL(ex_hall_num, ex_name, ex_loc, zipcode, latitude, longtitude, "
							+ "mgr_name, mgr_tel, ex_tel) values(ex_hall_seq.nextval, ?,?,?,?,?,?,?,?)";
				pstmt=conn.prepareStatement(insertExhibitonHall);
				
				pstmt.setInt(1, ehVO.getExHallNum()); 
				pstmt.setString(2, ehVO.getExName()); 
				pstmt.setString(3, ehVO.getExLoc()); 
				pstmt.setString(4, ehVO.getZipcode()); 
				pstmt.setDouble(5, ehVO.getLongtitude()); 
				pstmt.setDouble(6, ehVO.getLongtitude()); 
				pstmt.setString(7, ehVO.getMgrName()); 
				pstmt.setString(8, ehVO.getMgrTel()); 
				pstmt.setString(9, ehVO.getExTel()); 
				
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
		int flag=0;
		
		Connection con=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		
		try {
				con = dc.getConn();

				StringBuilder upadateExhibitonHall=new StringBuilder();
				
				upadateExhibitonHall
				.append("	update EXHIBITION_HALL									")
				.append("	set	ex_name=?, ex_loc=?, zipcode=?, latitude=?, "
						+ "longtitude=?, mgr_name=?, mgr_tel=?, ex_tel=?			")
				.append("	where ex_hall_num=?										")
				;
				
				pstmt=con.prepareStatement(upadateExhibitonHall.toString());

				pstmt.setString(1, ehVO.getExName()); 
				pstmt.setString(2, ehVO.getExLoc()); 
				pstmt.setString(3, ehVO.getZipcode()); 
				pstmt.setDouble(4, ehVO.getLatitude()); 
				pstmt.setDouble(5, ehVO.getLongtitude()); 
				pstmt.setString(6, ehVO.getMgrName()); 
				pstmt.setString(7, ehVO.getMgrTel()); 
				pstmt.setString(8, ehVO.getExTel()); 
				pstmt.setInt(9, ehVO.getExHallNum()); 
				
				flag=pstmt.executeUpdate();
				
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
		
		if(flag>0) {
			return true; 
		}else {
			return false; 
		}
	}//upadateExhibitonHall
	
	
	public boolean deleteExhibitonHall(int exHallNum) throws ClassNotFoundException, NamingException{
		int flag=0;
		
		Connection con=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		
		try {
				con = dc.getConn();

				String deleteExhibitonHall= "delete from EXHIBITION_HALL where ex_hall_num=?";
				
				pstmt=con.prepareStatement(deleteExhibitonHall);

				pstmt.setInt(1, exHallNum); 
				
				flag=pstmt.executeUpdate();
				
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
		
		if(flag>0) {
			return true; 
		}else {
			return false; 
		}
	}//deleteExhibitonHall
	
	
	public ExHallVO selectExhibitonHallDetail(int exHallNum) throws ClassNotFoundException, NamingException {

		ExHallVO ehVO= null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
			
		try {
			
			con=dc.getConn();
			
			StringBuilder selectExhibitonHallDetail = new StringBuilder();
			selectExhibitonHallDetail
			.append("	SELECT ex_hall_num, ex_name, ex_loc, zipcode, latitude, longtitude, "
					+ "mgr_name, mgr_tel, ex_tel													")
			.append("	from EXHIBITION_HALL														")
			.append("	where ex_hall_num=?															");
			
			
			pstmt = con.prepareStatement(selectExhibitonHallDetail.toString());
			pstmt.setInt(1, exHallNum);
			
			rs = pstmt.executeQuery();
			ehVO= new ExHallVO();
			
			while(rs.next()) {
				ehVO.setExHallNum(rs.getInt("ex_hall_num"));
				ehVO.setExName(rs.getString("ex_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				ehVO.setZipcode(rs.getString("zipcode"));
				ehVO.setLatitude(rs.getDouble("latitude"));
				ehVO.setLatitude(rs.getDouble("longtitude"));
				ehVO.setMgrName(rs.getString("mgrName"));
				ehVO.setMgrTel(rs.getString("mgrTel"));
				ehVO.setExTel(rs.getString("exTel"));
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

	
	/*
	 * public static void main(String[] args) { ExHallManagerDAO ehmDAO = new
	 * ExHallManagerDAO (); ehmDAO.selectExhibitonHall("");
	 * System.out.println(ehmDAO.selectExhibitonHall(""));
	 * 
	 * }//main
	 */
	}
	


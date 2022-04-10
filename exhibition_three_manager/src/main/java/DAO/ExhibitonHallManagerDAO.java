package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import VO.ExhibitionHallVO;
import connection.DbConnection;

public class ExhibitonHallManagerDAO {
	
		
	public List<ExhibitionHallVO> selectExhibitonHall(String exName) {
		
		List<ExhibitionHallVO> hallList=null;
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
			.append("	where ex_name like '%'||?||'%'	");
			
			pstmt = con.prepareStatement(selectExhibitionHall.toString());
			pstmt.setString(1, exName);
			
			rs= pstmt.executeQuery();
			
			hallList=  new ArrayList<ExhibitionHallVO>();
					
			while(rs.next()) {
				ExhibitionHallVO ehVO= new ExhibitionHallVO();
				ehVO.setExHallNum(rs.getInt("ex_hall_num"));
				ehVO.setExName(rs.getString("ex_name"));
				ehVO.setExLoc(rs.getString("ex_loc"));
				hallList.add(ehVO);
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
		return hallList;
	}//selectExhibitonHall
	
	
	public void insertExhibitonHall(ExhibitionHallVO ehVO) throws SQLException{
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
		}finally {
			dc.close(null, pstmt, conn);
		}
		
	}//insertExhibitonHall
	
	
	public boolean upadateExhibitonHall(ExhibitionHallVO ehVO) throws SQLException{
		int flag=0;
		
		Connection con=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		
		try {
				con = dc.getConn();

				StringBuilder upadateExhibitonHall=new StringBuilder();
				
				upadateExhibitonHall
				.append("	update EXHIBITION_HALL				")
				.append("	set	ex_name=?, ex_loc=?, zipcode=?, latitude=?, longtitude=?, mgr_name=?, mgr_tel=?, ex_tel=?			")
				.append("	where ex_hall_num=?				")
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
		}finally {
			dc.close(null, pstmt, con);
		}
		
		if(flag>0) {
			return true; 
		}else {
			return false; 
		}
	}//upadateExhibitonHall
	
	
	public boolean deleteExhibitonHall(int exHallNum) throws SQLException{
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
		}finally {
			dc.close(null, pstmt, con);
		}
		
		if(flag>0) {
			return true; 
		}else {
			return false; 
		}
	}//deleteExhibitonHall
	
	
	public ExhibitionHallVO selectExhibitonHallDetail(int exHallNum) throws SQLException{

		ExhibitionHallVO ehVO= null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
			
		try {
			
			con=dc.getConn();
			
			StringBuilder selectExhibitonHallDetail = new StringBuilder();
			selectExhibitonHallDetail
			.append("	SELECT ex_hall_num, ex_name, ex_loc, zipcode, latitude, longtitude, "
					+ "mgr_name, mgr_tel, ex_tel	")
			.append("	from EXHIBITION_HALL				")
			.append("	where ex_hall_num=?				");
			
			
			pstmt = con.prepareStatement(selectExhibitonHallDetail.toString());
			pstmt.setInt(1, exHallNum);
			
			rs = pstmt.executeQuery();
			ehVO= new ExhibitionHallVO();
			
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
			
		}finally {
			dc.close(rs, pstmt, con);
		}
		
		return ehVO; 
	}//selectExhibitonHallDetail

	
	
	public static void main(String[] args) {
		ExhibitonHallManagerDAO ehmDAO = new ExhibitonHallManagerDAO ();
		ehmDAO.selectExhibitonHall("");
	}//main 
}
	


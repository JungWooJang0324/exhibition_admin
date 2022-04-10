package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import VO.BoardVO;
import connection.DbConnection;

public class BoardManagerDAO {
	
	
	public List<BoardVO> selectBoardManager(BoardVO bVO) {
		
		List<BoardVO> boardList=null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
			
		try {
			
			con=dc.getConn();
			
			
			StringBuilder selectBoardManager = new StringBuilder();
		
			
			pstmt = con.prepareStatement(selectBoardManager.toString());
			
			
			rs= pstmt.executeQuery();
			
			boardList=  new ArrayList<BoardVO>();
					
			while(rs.next()) {
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
		return boardList;
	}//selectBoardManager
	
	
	public boolean delete(int bdId) throws SQLException{
		boolean flag=true;
		
		return flag; 
	}//delete
	
	public void insert(BoardVO bVO) throws SQLException{
		
	}//delete
	
	public boolean update(BoardVO bVO) throws SQLException{
		boolean flag=true;
		
		return flag; 
	}//delete
	
	public List<BoardVO> selectBoardDetail(int bdId) throws SQLException{
		
		List<BoardVO> boardList=null;
		
		return boardList;
	}//delete
	
	
}

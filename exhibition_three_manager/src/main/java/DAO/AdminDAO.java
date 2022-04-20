package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.NamingException;

import connection.DbConnection;

public class AdminDAO {
	
	public String login(String userId, String userPassword) throws ClassNotFoundException, NamingException, SQLException {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		DbConnection dc= DbConnection.getInstance();
		String date="";
		try {
			conn=dc.getConn();
			String sql="select created_date from admin where admin_id= ? and password=? ";
		
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPassword);
			rs= pstmt.executeQuery();
			
			
			 if(rs.next()) { 
				 date= rs.getString("created_date");
			 }
			 
		} finally {
			dc.close(rs, pstmt, conn);
		}
		
		
		return date;
	}//login
	
	
	//비밀번호 재설정
	public boolean resetPass(String userId, String newPass) throws ClassNotFoundException, NamingException, SQLException {
		Connection conn=null;
		PreparedStatement pstmt=null;

		DbConnection dc= DbConnection.getInstance();
		int  cnt=0;
		boolean flag=false;
		
		try {
			conn=dc.getConn();
			String sql="UPDATE ADMIN SET PASSWORD=? WHERE ADMIN_ID=?";
		
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, newPass);
			pstmt.setString(2, userId);
			
			cnt= pstmt.executeUpdate();
			
		}finally {
			dc.close(null, pstmt, conn);
			
		}
		
		if(cnt>0) {
			flag=true;
		}
		
		return flag;
	}//login
	
	
	
}




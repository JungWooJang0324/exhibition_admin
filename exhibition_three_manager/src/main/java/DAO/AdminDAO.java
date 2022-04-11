package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.DbConnection;

public class AdminDAO {
	
	public String login(String userId, String userPassword) {
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
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return date;
	}

	public static void main(String[] args) {

		AdminDAO ad = new AdminDAO();
		System.out.println(ad.login("admin", "asd123"));
	}

}




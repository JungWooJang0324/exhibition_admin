package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import VO.ReservationManagerVO;
import connection.DbConnection;

public class ReservationManagerDAO {
	
	
	public List<ReservationManagerVO> selectReservation() throws SQLException, ClassNotFoundException, NamingException{
		List<ReservationManagerVO> list = new ArrayList<ReservationManagerVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		ResultSet rs = null;
		
		try{
			con=dc.getConn();
			StringBuilder selectQuery = new StringBuilder();
			selectQuery
			.append("	select rez_num,ex.ex_name,m.name, visit_date, rez_status 	")
			.append("	from reservation rez,member m,exhibition ex	")
			.append("	where rez.userid=m.userid and rez.ex_num = ex.ex_num	");
			pstmt = con.prepareStatement(selectQuery.toString());
			rs = pstmt.executeQuery();
			ReservationManagerVO rVO = null;
			while(rs.next()) {
				rVO = new ReservationManagerVO();
				rVO.setRezNum(rs.getInt("rez_num"));
				rVO.setExName(rs.getString("ex_name"));
				rVO.setUserName(rs.getString("name"));
				rVO.setVisitData(rs.getDate("visit_date"));
				rVO.setRezStatus(rs.getString("rez_status"));
				list.add(rVO);
			}//end while
			
		}finally {
			dc.close(rs, pstmt, con);
			
		}
		
		return list;
		
	}//selectReservation
	
	
	public ReservationManagerVO selectOneReservation(int rezNum) throws SQLException, ClassNotFoundException, NamingException{
		ReservationManagerVO rVO=null;
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		ResultSet rs = null;
		
		try{
			con=dc.getConn();
			StringBuilder selectQuery = new StringBuilder();
			
			selectQuery
			.append("				SELECT ex.ex_name, ex.ex_num, ex.rez_num, ex.name, ex.rez_count, ex.rez_date,ex.userid, ex.visit_date, (p.adult * ex.rez_count) as price  ")
			.append("				FROM price p, (SELECT ex.ex_name, ex.ex_num, rez.rez_num, m.name, rez.rez_count, rez.rez_date,m.userid, rez.visit_date ")
			.append("			    FROM reservation rez, member m,exhibition ex 	")
			.append("			    WHERE rez.userid=m.userid and rez.ex_num =ex.ex_num) ex	")
			.append("	WHERE ex.rez_num=? and ex.ex_num=p.ex_num");

			pstmt = con.prepareStatement(selectQuery.toString());
			pstmt.setInt(1, rezNum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				rVO = new ReservationManagerVO();
				rVO.setExName(rs.getString("ex_name"));
				rVO.setExNum(rs.getInt("ex_num"));
				rVO.setRezNum(rs.getInt("rez_num"));
				rVO.setUserName(rs.getString("name"));
				rVO.setRezCount(rs.getInt("rez_count"));
				rVO.setRezData(rs.getDate("rez_date"));
				rVO.setUserId(rs.getString("userid"));
				rVO.setVisitData(rs.getDate("visit_date"));
				rVO.setPrice(rs.getInt("price"));
			}//end while
			
		}finally {
			dc.close(rs, pstmt, con);
			
		}
		
		return rVO;
		
	}//selectReservation
	
	//updateReservation
	public int updateReservation(int rezCount, String visitDate, int rezNum) throws SQLException, ParseException {
		Connection conn=null;
		PreparedStatement pstmt=null;
		DbConnection dc=DbConnection.getInstance();
		int cnt=0;
		try {
			conn=dc.getConn();
			String updateRez="UPDATE reservation SET visit_date=to_date(?,'yyyy-mm-dd'),rez_count=? WHERE rez_num=?";
			pstmt = conn.prepareStatement(updateRez.toString());
			pstmt.setString(1, visitDate);
			pstmt.setInt(2, rezCount);
			pstmt.setInt(3, rezNum);
			cnt=pstmt.executeUpdate();
		}finally {
			dc.close(null, pstmt, conn);
		}
		
		return cnt;
	}
	
	
	//cancelReservation
	public int cancelReservation(int rezNum) throws SQLException, ParseException {
			Connection conn=null;
			PreparedStatement pstmt=null;
			DbConnection dc=DbConnection.getInstance();
			int cnt=0;
			try {
				conn=dc.getConn();
				String updateRez="UPDATE RESERVATION SET REZ_STATUS='f' WHERE REZ_NUM=?";
				pstmt = conn.prepareStatement(updateRez.toString());
				
				pstmt.setInt(1, rezNum);
				cnt=pstmt.executeUpdate();
			}finally {
				dc.close(null, pstmt, conn);
			}
			
			return cnt;
		}
	
		//confirmReservation
		public int confirmReservation(int rezNum) throws SQLException, ParseException {
				Connection conn=null;
				PreparedStatement pstmt=null;
				DbConnection dc=DbConnection.getInstance();
				int cnt=0;
				try {
					conn=dc.getConn();
					String updateRez="UPDATE RESERVATION SET REZ_STATUS='t' WHERE REZ_NUM=?";
					pstmt = conn.prepareStatement(updateRez.toString());
					
					pstmt.setInt(1, rezNum);
					cnt=pstmt.executeUpdate();
				}finally {
					dc.close(null, pstmt, conn);
				}
				
				return cnt;
			}
		
	
	//index용 - reservation수;
	public int countReservation() throws SQLException, ClassNotFoundException, NamingException{
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		ResultSet rs = null;
		int cnt=0;
		try{
			con=dc.getConn();
			String countQuery= "select userid from reservation where rez_status='t'";

			pstmt = con.prepareStatement(countQuery);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				cnt++;
			}//end while
			
		}finally {
			dc.close(rs, pstmt, con);
			
		}
		
		return cnt;
		
	}//countReservation	
	
	
	//index용 - 오늘 예약;
		public int countTodaysReservation() throws SQLException, ClassNotFoundException, NamingException{
			Connection con = null;
			PreparedStatement pstmt = null;
			DbConnection dc = DbConnection.getInstance();
			ResultSet rs = null;
			int cnt=0;
			try{
				con=dc.getConn();
				String countQuery= "select userid from reservation where to_char(to_date(rez_date,'yyyy-MM-dd'))=to_char(to_date(sysdate,'yyyy-MM-dd'))";

				pstmt = con.prepareStatement(countQuery);
				rs = pstmt.executeQuery();

				while(rs.next()) {
					cnt++;
				}//end while
				
			}finally {
				dc.close(rs, pstmt, con);
				
			}
			
			return cnt;
			
		}//countReservation	
	
}//class

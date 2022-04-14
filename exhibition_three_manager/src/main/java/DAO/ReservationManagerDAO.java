package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import VO.ReservationManagerVO;
import connection.DbConnection;

public class ReservationManagerDAO {
	
	
	public List<ReservationManagerVO> selectReservation() throws SQLException{
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
	
}//class

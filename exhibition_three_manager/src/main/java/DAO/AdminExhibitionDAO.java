package DAO;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import VO.ExHallVO;
import VO.ExhibitionVO;
import VO.MemberVO;
import VO.PriceVO;
import connection.DbConnection;

public class AdminExhibitionDAO {

	public List<ExhibitionVO> selectExhibition(String ex_name) throws SQLException, ClassNotFoundException, NamingException{
		List<ExhibitionVO> ev= new ArrayList<ExhibitionVO>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		DbConnection dc= DbConnection.getInstance();

		try {
			conn=dc.getConn();
			StringBuilder selectMember = new StringBuilder();
			selectMember
			.append("	SELECT  ex_num,total_count,watch_count,ex_hall_num,ex_name,ex_info,	")
			.append("	ex_intro,exhibition_poster, add_img, ex_status,exhibit_date,deadline,input_date 	")
			.append("	FROM exhibition")
			.append("	WHERE ex_name like ?" );
			
			
			pstmt=conn.prepareStatement(selectMember.toString());
			pstmt.setString(1, "%"+ex_name+"%");
			
			rs=pstmt.executeQuery();			
			ExhibitionVO eVO=null;
			while(rs.next()) {
				eVO = new ExhibitionVO();
				eVO.setExNum(rs.getInt("ex_num"));
				eVO.setTotalCount(rs.getInt("total_count"));
				eVO.setWatchCount(rs.getInt("watch_count"));
				eVO.setExHallNum(rs.getInt("ex_hall_num"));
				eVO.setExIntro(rs.getString("ex_intro"));
				eVO.setExName(rs.getString("ex_name"));
				eVO.setInputDate(rs.getDate("input_date"));
				ev.add(eVO);
			}//end while
			
		}finally {
			dc.close(rs, pstmt, conn);
		}
		return ev;
	}
	
	public void insertExhibition(ExhibitionVO eVO) throws SQLException, ClassNotFoundException, NamingException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		
		try {
			con = dc.getConn();
			StringBuilder insertQuery = new StringBuilder();
			insertQuery
			.append(" INSERT INTO EXHIBITION(ex_num,total_count,watch_count,ex_hall_num,ex_name,ex_info,")
			.append(" ex_intro,exhibition_poster, add_img,exhibit_date,deadline)		")	
			.append(" VALUES(ex_seq.nextval,?,?,?,?,?,?,?,?,?,?,?);		");	
			pstmt = con.prepareStatement(insertQuery.toString());
			
			pstmt.setInt(1, eVO.getTotalCount());
			pstmt.setInt(2, eVO.getWatchCount());
			pstmt.setInt(3, eVO.getExHallNum());
			pstmt.setString(4, eVO.getExName());
			pstmt.setString(5, eVO.getExInfo());
			pstmt.setString(6, eVO.getExInfo());
			pstmt.setString(7, eVO.getExhibitionPoster());
			pstmt.setString(8, eVO.getAddImg());
			pstmt.setDate(9, eVO.getExhibitionDate());
			pstmt.setDate(10, eVO.getDeadLine());
			
			pstmt.executeUpdate();
			
		}finally{
			dc.close(null, pstmt, con);
			
		}//end finally
		
	}//insertExhibition
	
	public void insertPrice(PriceVO pVO,int exNum) throws SQLException, ClassNotFoundException, NamingException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		
		try {
			con = dc.getConn();
			String insertQuery = "insert into price(ex_num, adult,teen,child) values(?,?,?,?)";
			pstmt = con.prepareStatement(insertQuery);
			
			pstmt.setInt(1, exNum);
			pstmt.setInt(2, pVO.getAdult());
			pstmt.setInt(3, pVO.getTeen());
			pstmt.setInt(4, pVO.getChild());
			
			
			pstmt.executeUpdate();
			
		}finally{
			dc.close(null, pstmt, con);
			
		}//end finally
		
	}//insertExhibition
	
	public List<ExHallVO> selectExhibitionHall() throws SQLException, ClassNotFoundException, NamingException{
		List<ExHallVO> exNameList = new ArrayList<ExHallVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String selectQuery = "select ex_name,ex_hall_num,mgr_name from exhibition_hall";
			pstmt = con.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			ExHallVO eVO =  null;
			while(rs.next()) {
				eVO = new ExHallVO();
				eVO.setExHallNum(rs.getInt("ex_hall_num"));
				eVO.setExName(rs.getString("ex_name"));
				eVO.setMgrName(rs.getString("mgr_name"));
				exNameList.add(eVO);
			}//end while
		
		}finally {
			
			dc.close(rs, pstmt, con);
		}//end finally
		
		return exNameList;
	}//selectExhibitionHall
	


	//index용 총 전시회 수 
	public int selectAllEx() throws SQLException, ClassNotFoundException, NamingException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt=0;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String selectQuery = "select ex_name from exhibition where ex_status='t'";
			pstmt = con.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt++;
			}//end while
		
		}finally {
			
			dc.close(rs, pstmt, con);
		}//end finally
		
		return cnt;
	}//selectAllEx
	
	//index용 마감된 전시수 
	public int endedEx() throws SQLException, ClassNotFoundException, NamingException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt=0;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String selectQuery = "select * from exhibition where (to_date(sysdate,'yyyy-MM-dd')-to_date(deadline,'yyyy-MM-dd'))>0";
			pstmt = con.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt++;
			}//end while
		
		}finally {
			
			dc.close(rs, pstmt, con);
		}//end finally
		
		return cnt;
		}//endedEx

	//index용 내일 마감될 전시
	public int endsTomorrow() throws SQLException, ClassNotFoundException, NamingException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt=0;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String selectQuery = "select * from exhibition where to_char(to_date(sysdate+1,'yyyy-MM-dd'))=to_char(to_date(deadline,'yyyy-MM-dd'))";
			pstmt = con.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt++;
			}//end while
			
		}finally {
			
			dc.close(rs, pstmt, con);
		}//end finally
		
		return cnt;
	}//endedEx
}//class

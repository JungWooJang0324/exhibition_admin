package DAO;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import VO.ExHallVO;
import VO.ExhibitionVO;
import VO.PriceVO;
import connection.DbConnection;

public class AdminExhibitionDAO {

	public List<ExhibitionVO> selectEx(int startRow, int endRow, String field,String query) throws SQLException, NamingException{
			
			StringBuilder sql = new StringBuilder();
			sql
			.append("    select * from     ")
			.append("    (select rownum rn, ex_num,total_count,watch_count,ex_hall_num,ex_name,ex_info,     ")
			.append("     ex_intro,exhibition_poster, add_img, ex_status,exhibit_date,deadline,input_date    ")
			.append("     from (select * from exhibition where (ex_status='t' or ex_status='p') and ").append(query)
			.append("   like '%'||?||'%' order by input_date)) where rn between ? and ?  ");
			List<ExhibitionVO> list = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			DbConnection dc = DbConnection.getInstance();
			try {
				con = dc.getConn();
				pstmt = con.prepareStatement(sql.toString());
				
				pstmt.setString(1, field);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs = pstmt.executeQuery();
				
				list= new ArrayList<ExhibitionVO>();
				ExhibitionVO exVO = null;
					
				while(rs.next()) {
					exVO = new ExhibitionVO();
					exVO.setExNum(rs.getInt("ex_num"));
					exVO.setExName(rs.getString("ex_name"));
					exVO.setInputDate(rs.getDate("input_date"));
					exVO.setExhibitionDate(rs.getDate("exhibit_date"));
					exVO.setExhibitionPoster(rs.getString("exhibition_poster"));
					
					list.add(exVO);
				}//end while
				
			}finally {
				dc.close(rs, pstmt, con);
			
			}//end finally
			
			return list;
		
	}//selectMember
		
	public int selectExnum(String exName,String exhibitDate) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dc = DbConnection.getInstance();
		int ex_num = 0;
		try {
			con = dc.getConn();
			String selectQuery  ="select ex_num from exhibition where ex_name=? and exhibit_date=?";
			pstmt= con.prepareStatement(selectQuery);
			pstmt.setString(1, exName);
			pstmt.setString(2, exhibitDate);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				ex_num=rs.getInt("ex_num");
			}//end if
			
		}finally {
			dc.close(rs, pstmt, con);
		}
		return ex_num;
	}
	public int getCount(String field, String query) throws SQLException {
		int count = 0;
		StringBuilder sql = new StringBuilder();
		sql
		.append("	select count(*) from exhibition where (ex_status='t' or ex_status='p') and ")
		.append(query).append("	like '%'||?||'%'	");
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, field);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
				System.out.println("count : "+count);
			}//end if

		}finally {
			dc.close(rs, pstmt, con);
		}
		
		return count;
	}//getCount
	
	
	public int deleteEx(String exNum) throws SQLException, ParseException {
		Connection conn=null;
		PreparedStatement pstmt=null;
		DbConnection dc=DbConnection.getInstance();
		int cnt=0;
		try {
			conn=dc.getConn();
			String updateRez="UPDATE EXHIBITION SET EX_STATUS='f' WHERE EX_NUM=?";
			pstmt = conn.prepareStatement(updateRez.toString());
			
			pstmt.setString(1, exNum);
			cnt=pstmt.executeUpdate();
		}finally {
			dc.close(null, pstmt, conn);
		}
		
		return cnt;
	}
	public void updateEx(ExhibitionVO eVO) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String updateQuery = "UPDATE EXHIBITION SET ex_name=?,ex_info=?,ex_intro=?, ex_hall_num=?, exhibit_date=?, deadline=?, total_count=?, watch_count=?, exhibition_poster=?, add_img=? where ex_num=?";
			pstmt = con.prepareStatement(updateQuery);
			pstmt.setString(1, eVO.getExName());
			pstmt.setString(2, eVO.getExInfo());
			pstmt.setString(3, eVO.getExIntro());
			pstmt.setInt(4, eVO.getExHallNum());
			pstmt.setString(5, eVO.getExhibitDateText());
			pstmt.setString(6, eVO.getDeadLineText());
			pstmt.setInt(7, eVO.getTotalCount());
			pstmt.setInt(8, eVO.getWatchCount());
			pstmt.setString(9, eVO.getExhibitionPoster());
			pstmt.setString(10, eVO.getAddImg());
			pstmt.setInt(11, eVO.getExNum());
			
			pstmt.executeUpdate();
			
		}finally {
			dc.close(null, pstmt, con);
		}//end finally
		
	}//updateEx
	public int releaseEx(String exNum) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		int cnt = 0;
		
		try {
			con = dc.getConn();
			String releaseQuery = " UPDATE EXHIBITION SET EX_STATUS='p' WHERE EX_NUM= ? ";
			pstmt= con.prepareStatement(releaseQuery);
			pstmt.setString(1, exNum);
			
			 cnt = pstmt.executeUpdate();
			
			System.out.println(cnt);
		}finally {
			dc.close(null, pstmt, con);
		}//end finally
		return cnt;
	}//deleteEx
	/**
	 * 전시일정 상세 뷰 조회
	 * @param exNum
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	public ExhibitionVO selectExDetail(int exNum) throws SQLException, IOException {
		ExhibitionVO eVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dc = DbConnection.getInstance();
		BufferedReader br = null;
		try {
			con = dc.getConn();
			String selectQuery ="select * from exhibition_detail where ex_num = ?";
			pstmt = con.prepareStatement(selectQuery);
			pstmt.setInt(1, exNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				eVO = new ExhibitionVO();
				br = new BufferedReader(rs.getClob("ex_info").getCharacterStream());
				String data ="";
				StringBuilder exInfo = new StringBuilder();
				while((data=br.readLine()) != null) {
					exInfo.append(data+"\n");
				}
				eVO.setExName(rs.getString("ex_name"));
				eVO.setExIntro(rs.getString("ex_intro"));
				eVO.setTotalCount(rs.getInt("total_count"));
				eVO.setWatchCount(rs.getInt("watch_count"));
				eVO.setExhibitDateText(rs.getString("exhibit_date"));
				eVO.setDeadLineText(rs.getString("deadline"));
				eVO.setExInfo(exInfo.toString());
				eVO.setAdult(rs.getInt("adult"));
				eVO.setExhibitionPoster(rs.getString("exhibition_poster"));
				eVO.setAddImg(rs.getString("add_img"));
				eVO.setTeen(rs.getInt("teen"));
				eVO.setChild(rs.getInt("child"));
				eVO.setExHallNum(rs.getInt("ex_hall_num"));
				eVO.setExStatus(rs.getString("ex_status"));
			}//end if
			
		}finally {
			dc.close(rs, pstmt, con);
			br.close();
		}
		return eVO;
	}//selectExDetail
	
	public void insertExhibition(ExhibitionVO eVO) throws SQLException, ClassNotFoundException, NamingException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String insertQuery =
		"INSERT INTO EXHIBITION(ex_num,total_count,watch_count,ex_hall_num,ex_name,ex_info,ex_intro,exhibition_poster,add_img,exhibit_date,deadline,ex_status) VALUES(ex_seq.nextval,?,?,?,?,?,?,?,?,?,?,'t')";
			
			pstmt = con.prepareStatement(insertQuery);
			
			pstmt.setInt(1, eVO.getTotalCount());
			pstmt.setInt(2, eVO.getWatchCount());
			pstmt.setInt(3, eVO.getExHallNum());
			pstmt.setString(4, eVO.getExName());
			pstmt.setString(5, eVO.getExInfo());
			pstmt.setString(6, eVO.getExIntro());
			pstmt.setString(7, eVO.getExhibitionPoster());
			pstmt.setString(8, eVO.getAddImg());
			pstmt.setString(9, eVO.getExhibitDateText());
			pstmt.setString(10, eVO.getDeadLineText());
			
			pstmt.executeUpdate();
			
		}finally{
			dc.close(null, pstmt, con);
			
		}//end finally
	}//insertExhibition
	
	public void insertPrice(ExhibitionVO eVO) throws SQLException, ClassNotFoundException, NamingException {
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		
		try {
			con = dc.getConn();
			String insertQuery = "insert into price(ex_num, adult,teen,child) values(?,?,?,?)";
			pstmt = con.prepareStatement(insertQuery);
			
			pstmt.setInt(1, eVO.getExNum());
			pstmt.setInt(2, eVO.getAdult());
			pstmt.setInt(3, eVO.getTeen());
			pstmt.setInt(4, eVO.getChild());
			
			
			pstmt.executeUpdate();
			
		}finally{
			dc.close(null, pstmt, con);
			
		}//end finally
		
	}//insertExhibition
	
	/**
	 * 전시 가격 업데이트
	 * @param eVO
	 * @throws SQLException
	 */
	public void updatePrice(ExhibitionVO eVO)throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String updateQuery = "update price set adult=?,child=?,teen=? where ex_num=? ";
			pstmt=con.prepareStatement(updateQuery);
			
			pstmt.setInt(1, eVO.getAdult());
			pstmt.setInt(2, eVO.getChild());
			pstmt.setInt(3, eVO.getTeen());
			pstmt.setInt(4, eVO.getExNum());
			
			pstmt.executeUpdate();
		}finally {
			dc.close(null, pstmt, con);
		}//end finally
		
	}//updatePrice
	
	/**
	 * 전시장 목록
	 * @return
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 * @throws NamingException
	 */
	public List<ExHallVO> selectExhibitionHall() throws SQLException, ClassNotFoundException, NamingException{
		List<ExHallVO> exNameList = new ArrayList<ExHallVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			String selectQuery = "select ex_hall_name,ex_hall_num,mgr_name from exhibition_hall";
			pstmt = con.prepareStatement(selectQuery);
			rs = pstmt.executeQuery();
			ExHallVO eVO =  null;
			while(rs.next()) {
				eVO = new ExHallVO();
				eVO.setExHallNum(rs.getInt("ex_hall_num"));
				eVO.setExName(rs.getString("ex_hall_name"));
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

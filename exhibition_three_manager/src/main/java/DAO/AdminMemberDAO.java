package DAO;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import VO.MemberVO;
import connection.DbConnection;

public class AdminMemberDAO {

	public List<MemberVO> selectAllMember() throws SQLException, ClassNotFoundException, NamingException{
		List<MemberVO> mv= new ArrayList<MemberVO>();
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs =null;
		DbConnection dc= DbConnection.getInstance();

		try {
			conn=dc.getConn();
			stmt=conn.createStatement();
			StringBuilder selectMember = new StringBuilder();
			selectMember.append("SELECT userid, name, isubscribe_date ")
			.append("FROM member");
			
			rs=stmt.executeQuery(selectMember.toString());			
			MemberVO mVO=null;
			while(rs.next()) {
				mVO=new MemberVO();
				mVO.setUserId(rs.getString("userid"));
				mVO.setName(rs.getString("name"));
				mVO.setIsubscribeDate(rs.getDate("isubscribe_date"));
				
				mv.add(mVO);
			}
			
		}finally {
			dc.close(rs, stmt, conn);
		}
		
		
		return mv;
	}
	
	/**
	 * 회원 레코드 수
	 * @param field
	 * @param query
	 * @return
	 * @throws SQLException
	 */
	public int getCount(String field, String query) throws SQLException {
		int count = 0;
		StringBuilder sql = new StringBuilder();
		sql
		.append("	select count(*) from member where ")
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
			if(rs != null)
				rs.close();
			if(pstmt != null)
				pstmt.close();
			if(con != null)
				con.close();
		}
		
		return count;
	}//getCount
	
	/**
	 * 회원 조회 메소드
	 * @param startRow
	 * @param endRow
	 * @param field
	 * @param query
	 * @return
	 * @throws SQLException
	 * @throws NamingException
	 */
	public List<MemberVO> selectMember(int startRow, int endRow, String field,String query) throws SQLException, NamingException{
		
		StringBuilder sql = new StringBuilder();
		sql
		.append("	select * from	")
		.append("	(select rownum rn, userid, name, tel,zipcode, address1, address2, isdeleted, isubscribe_date	")
		.append("	from (select * from member where	")
		.append(query).append(" like '%'||?||'%' ").append("	order by userid))	")
		.append("	where rn between ? and ?	");
		
		List<MemberVO> list = null;
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
			
			list= new ArrayList<MemberVO>();
			MemberVO mVO = null;
				
			while(rs.next()) {
				mVO=new MemberVO();
				mVO.setUserId(rs.getString("userid"));
				mVO.setName(rs.getString("name"));
				mVO.setIsubscribeDate(rs.getDate("isubscribe_date"));
				list.add(mVO);
			}//end while
			
		}finally {
			dc.close(rs, pstmt, con);
		
		}//end finally
		
		return list;
	
}//selectMember
	

	//index용
	public int countTodayMem() throws ClassNotFoundException, SQLException, NamingException {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs =null;
		DbConnection dc= DbConnection.getInstance();
		int cnt=0;
		try {
			conn=dc.getConn();
			StringBuilder selectMember = new StringBuilder();
			selectMember.append("select userid from member where to_char(to_date(isubscribe_date,'yyyy-MM-dd'))=to_char(to_date(sysdate,'yyyy-MM-dd'))");
			pstmt=conn.prepareStatement(selectMember.toString());
			
			rs=pstmt.executeQuery();			
			MemberVO mVO=null;
			while(rs.next()) {
				cnt++;
			}
			
		}finally {
			dc.close(rs, pstmt, conn);
		}
		
		
		return cnt;
	}
	/*public static void main(String[] args) {
		AdminMemberDAO amDAO=new AdminMemberDAO();
		try {
			List<MemberVO> list = amDAO.selectAllMember();
			StringBuilder sb= new StringBuilder();
			for(MemberVO mv: list) {
				sb.append(mv.getUserId()).append(" ")
				.append(mv.getPassword()).append(" ")
				.append(mv.getName()).append(" ")
				.append(mv.getZipcode()).append(" ")
				.append(mv.getAddress1()).append(" ")
				.append(mv.getAddress2()).append(" ")
				.append(mv.getIsDeleted()).append(" ")
				.append(mv.getIsubscribeDate()).append("\n");
			}
			System.out.println(sb.toString());
		} catch (SQLException e) {
			e.printStackTrace();
			}
		}*/
	}

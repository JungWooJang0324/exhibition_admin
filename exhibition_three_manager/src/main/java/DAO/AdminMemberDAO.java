package DAO;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

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
	
	public List<MemberVO> selectMember(String id){
		List<MemberVO> list = new ArrayList<MemberVO>();
		
		
		
		return list;
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

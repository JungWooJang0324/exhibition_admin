package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import VO.BoardVO;
import connection.DbConnection;

public class BoardManagerDAO {
	
	
	public List<BoardVO> selectBoardAdmin(String title, String userId, String inputDate, String category) throws ClassNotFoundException, NamingException {
		
		List<BoardVO> boardList=null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
			
		try {
			
			con=dc.getConn();
			
			StringBuilder selectBoard = new StringBuilder();
			selectBoard
			.append("	SELECT b.bd_id, b.title, b.userid, b.input_date, cat.cat_name															")
			.append("	from Board b																											")
			.append("	inner join	category cat																								")
			.append("	on cat.cat_num = b.cat_num																								")
			.append("	where title like '%'||?||'%' or userid like '%'||?||'%' or input_date like '%'||?||'%' or	cat_name like '%'||?||'%'	 ")
			.append("	order by bd_id	desc																									");
			
			
			pstmt = con.prepareStatement(selectBoard.toString());
			pstmt.setString(1, title);
			pstmt.setString(2, userId);
			pstmt.setString(3, inputDate);
			pstmt.setString(4, category);
			
			rs= pstmt.executeQuery();
			
			boardList=  new ArrayList<BoardVO>();
				
			BoardVO bVO =null; 
			
			while(rs.next()) {
				bVO = new BoardVO(); 
				bVO.setBdId(rs.getInt("BD_ID"));
				bVO.setTitle(rs.getString("TITLE"));
				bVO.setUserId(rs.getString("USERID"));
				bVO.setInputDate(rs.getString("INPUT_DATE"));
				bVO.setCatName(rs.getString("CAT_NAME"));
				boardList.add(bVO);
			}	
			
			System.out.println("게시글 목록 select 성공");
			
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
	}//selectBoardAdmin
	
	
	public boolean deleteBoardAdmin(int bdId) throws ClassNotFoundException, NamingException{
		int flag=0;
		
		Connection con=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		
		try {
				con = dc.getConn();

				String deleteBoard= "delete from Board where bd_id=?";
				
				pstmt=con.prepareStatement(deleteBoard);

				pstmt.setInt(1, bdId); 
				
				flag=pstmt.executeUpdate();
				
				System.out.println("게시글 delete 성공");
		
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				dc.close(null, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if(flag>0) {
			return true; 
		}else {
			return false; 
		}
	}//deleteBoardAdmin
	
	
	public void insertBoardAdmin(BoardVO bVO) throws ClassNotFoundException, NamingException{
		Connection conn=null;
		PreparedStatement pstmt = null;
		
		DbConnection dc = DbConnection.getInstance();
		try {
				conn = dc.getConn();
				
				String insertBoard
					= "insert into Board(bd_id, cat_num, title, description) values(bd_seq.nextval, ?,?,?)";
				pstmt=conn.prepareStatement(insertBoard);
				
				pstmt.setInt(1, bVO.getCatNum()); 
				pstmt.setString(2, bVO.getTitle()); 
				pstmt.setString(3, bVO.getDescription()); 
				
				pstmt.executeUpdate();
				
				System.out.println("게시글 insert 성공");
		
		} catch (SQLException e) {
			e.printStackTrace();		
		}finally {
			try {
				dc.close(null, pstmt, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}//insertBoardAdmin
	
	
	public BoardVO selectBoardDetail(int bdId) throws ClassNotFoundException, NamingException{
		
		BoardVO bVO= null;
		
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
			
		try {
			
			con=dc.getConn();
			
			StringBuilder selectBoardDetail = new StringBuilder();
			selectBoardDetail
			.append("	SELECT b.bd_id, b.input_date, b.title, b.userid, b.cat_num, cat.cat_name, b.description	")
			.append("	from Board b																			")
			.append("	inner join	category cat																")
			.append("	on cat.cat_num = b.cat_num																")
			.append("	where bd_id=?																			");
				
			
			pstmt = con.prepareStatement(selectBoardDetail.toString());
			pstmt.setInt(1, bdId);
			
			rs = pstmt.executeQuery();
			bVO= new BoardVO();
			
			while(rs.next()) {
				bVO.setBdId(rs.getInt("bd_id"));
				bVO.setInputDate(rs.getString("input_date"));
				bVO.setTitle(rs.getString("title"));
				bVO.setUserId(rs.getString("userid"));
				bVO.setCatNum(rs.getInt("cat_num"));
				bVO.setDescription(rs.getString("description"));
			}	
			
			System.out.println("게시글 상세 보기 성공");
			
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return bVO;
	}//selectBoardDetail
	
	
	//index용 - 새글 수
	public int cntNewContext() throws ClassNotFoundException, NamingException{
		int cnt=0;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		
		DbConnection dc= DbConnection.getInstance();
		try {
			con=dc.getConn();
			StringBuilder countQuery = new StringBuilder();
			countQuery
			.append("	select userid	")
			.append("	from board ")
			.append("	where to_char(to_date(input_date,'yyyy-MM-dd'))>to_char(to_date(sysdate-2,'yyyy-MM-dd'))");
				
			
			pstmt = con.prepareStatement(countQuery.toString());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt++;
			}	
			
		}catch(SQLException se) {
			se.printStackTrace();
		}finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
	}//cntNewContext
	/*
	 * public static void main(String[] args) { BoardManagerDAO bDAO = new
	 * BoardManagerDAO(); bDAO.selectBoardAdmin("가");
	 * System.out.println(bDAO.selectBoardAdmin("가").toString());
	 * 
	 * }//main
	 */}

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

	/**
	 * 테이블 레코드의 개수를 구하는 메소드
	 * 
	 * @return
	 */
	public int getTotalRows(String option, String keyword) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();

		try {

			con = dc.getConn();
			StringBuilder sql = new StringBuilder();
			sql.append("	select count(bd_id) from BOARD	");

			if ("".equals(keyword) || keyword == null) {
				pstmt = con.prepareStatement(sql.toString());

				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
			} else {
				sql.append("	where ").append(option).append(" like '%'||?||'%' ");

				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, keyword.trim());

				rs = pstmt.executeQuery();

				if (rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	
	/**
	 * 검색한 값 select 함수
	 * 
	 * @param start
	 * @param end
	 * @param category
	 * @param keyword
	 * @return
	 * @throws ClassNotFoundException
	 * @throws NamingException
	 */
	public List<BoardVO> selectBoard(int startRow, int pageSize, String option, String keyword)
			throws ClassNotFoundException, NamingException {

		List<BoardVO> boardList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();

		try {
			con = dc.getConn();

			StringBuilder selectBoard = new StringBuilder();

			selectBoard
					.append("	select f.rnum, f.bd_id, f.title, f.userid, f.input_date, f.cat_name, f.admin_id					")
					.append("	from(select rownum as rnum, e.bd_id, e.title, e.userid, e.input_date, e.cat_name, e.admin_id 	")
					.append("	from(SELECT b.bd_id, b.title, b.userid, b.input_date, b.admin_id, cat.cat_name 					")
					.append("		from Board	b																				")
					.append("		right outer join	category cat															")
					.append("		on cat.cat_num = b.cat_num 																	")
					.append("		where ").append(option).append(" like '%'||?||'%' 											")
					.append("		order by input_date desc) e where rownum <= ? ) f											")
					.append("	where rnum >= ?  order by rnum 																	");

			

			pstmt = con.prepareStatement(selectBoard.toString());
			pstmt.setString(1, keyword.trim());
			pstmt.setInt(2, pageSize+startRow-1);
			pstmt.setInt(3, startRow);

			rs = pstmt.executeQuery();

			boardList = new ArrayList<BoardVO>();
			BoardVO bVO = null;

			while (rs.next()) {
				bVO = new BoardVO();
				bVO.setRnum(rs.getInt("rnum"));
				bVO.setBdId(rs.getInt("BD_ID"));
				bVO.setTitle(rs.getString("TITLE"));
				bVO.setUserId(rs.getString("USERID"));
				bVO.setAdminId(rs.getString("admin_id"));
				bVO.setInputDate(rs.getDate("INPUT_DATE"));
				bVO.setCatName(rs.getString("CAT_NAME"));
				boardList.add(bVO);
			}
			System.out.println("게시글 목록 select 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return boardList;
	}// selectBoardAdmin

	public int updateBoard(BoardVO bVO) throws ClassNotFoundException, NamingException {
		int cnt = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection dc = DbConnection.getInstance();

		try {
			con = dc.getConn();

			StringBuilder upadateExhibitonHall = new StringBuilder();

			upadateExhibitonHall
					.append("	update (SELECT b.bd_id, b.title, b.DESCRIPTION, b.cat_num					")
					.append("			from Board b																				")
					.append("			inner join	category cat																	")
					.append("			on cat.cat_num = b.cat_num)																	")
					.append("	set CAT_NUM =?, TITLE=?, DESCRIPTION=?																")
					.append("	where BD_ID =?																						");

			pstmt = con.prepareStatement(upadateExhibitonHall.toString());

			pstmt.setInt(1, bVO.getCatNum());
			pstmt.setString(2, bVO.getTitle());
			pstmt.setString(3, bVO.getDescription());
			pstmt.setInt(4, bVO.getBdId());

			cnt = pstmt.executeUpdate();
			
			System.out.println("게시판 수정 성공");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(null, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
	}// upadateExhibitonHall

	public int deleteBoardAdmin(int bdId) throws ClassNotFoundException, NamingException {
		int cnt = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		DbConnection dc = DbConnection.getInstance();

		try {
			con = dc.getConn();

			String deleteBoard = "delete from BOARD  where bd_id= ?";

			pstmt = con.prepareStatement(deleteBoard);

			pstmt.setInt(1, bdId);

			cnt = pstmt.executeUpdate();

			System.out.println("게시글 delete 성공");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(null, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}// deleteBoardAdmin

	public void insertBoardAdmin(BoardVO bVO) throws ClassNotFoundException, NamingException {
		Connection conn = null;
		PreparedStatement pstmt = null;

		DbConnection dc = DbConnection.getInstance();
		try {
			conn = dc.getConn();

			String insertBoard = 
					"insert into Board(bd_id, cat_num, title, description, admin_id, imgfile, userid) values(bd_seq.nextval, ?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(insertBoard);

			pstmt.setInt(1, bVO.getCatNum());
			pstmt.setString(2, bVO.getTitle());
			pstmt.setString(3, bVO.getDescription());
			pstmt.setString(4, bVO.getAdminId());
			pstmt.setString(5, bVO.getImgFile());
			pstmt.setString(6, bVO.getUserId());

			pstmt.executeUpdate();

			System.out.println("게시글 insert 성공");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				dc.close(null, pstmt, conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}// insertBoardAdmin

	public BoardVO selectBoardDetail(int bdId) throws ClassNotFoundException, NamingException {

		BoardVO bVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();

		try {

			con = dc.getConn();

			StringBuilder selectBoardDetail = new StringBuilder();
			selectBoardDetail.append(
					"	SELECT b.bd_id, b.input_date, b.title, b.userid, b.cat_num, cat.cat_name, b.description, b.imgfile, b.admin_id	")
					.append("	from Board b																									")
					.append("	inner join	category cat																						")
					.append("	on cat.cat_num = b.cat_num																						")
					.append("	where bd_id=?																									");

			pstmt = con.prepareStatement(selectBoardDetail.toString());
			pstmt.setInt(1, bdId);

			rs = pstmt.executeQuery();
			bVO = new BoardVO();

			while (rs.next()) {
				bVO.setBdId(rs.getInt("bd_id"));
				bVO.setInputDate(rs.getDate("input_date"));
				bVO.setTitle(rs.getString("title"));
				bVO.setUserId(rs.getString("userid"));
				bVO.setAdminId(rs.getString("admin_id"));
				bVO.setCatNum(rs.getInt("cat_num"));
				bVO.setCatName(rs.getString("cat_name"));
				bVO.setDescription(rs.getString("description"));
				bVO.setImgFile(rs.getString("imgfile"));
			}

			System.out.println("게시글 상세 보기 성공");

		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return bVO;
	}// selectBoardDetail

	/**
	 * 게시판 글쓰기 카테고리 불러오기
	 * 
	 * @return
	 */
	public List<BoardVO> selectCategory() {
		List<BoardVO> catList = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();

		try {

			con = dc.getConn();

			String sql = "select cat_name, cat_num from category order by cat_num";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			catList = new ArrayList<BoardVO>();
			BoardVO bVO = null;

			while (rs.next()) {
				bVO = new BoardVO();
				bVO.setCatName(rs.getString("cat_name"));
				bVO.setCatNum(rs.getInt("cat_num"));
				catList.add(bVO);
			}

			System.out.println("카테고리 select 성공");

		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return catList;
	}

	// index용 - 새글 수
	public int cntNewContext() throws ClassNotFoundException, NamingException {
		int cnt = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		DbConnection dc = DbConnection.getInstance();
		try {
			con = dc.getConn();
			StringBuilder countQuery = new StringBuilder();
			countQuery.append("	select userid	").append("	from board ").append(
					"	where to_char(to_date(input_date,'yyyy-MM-dd'))>to_char(to_date(sysdate-2,'yyyy-MM-dd'))");

			pstmt = con.prepareStatement(countQuery.toString());

			rs = pstmt.executeQuery();
			while (rs.next()) {
				cnt++;
			}

		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				dc.close(rs, pstmt, con);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
	}// cntNewContext

//	  public static void main(String[] args) { 
//		  BoardManagerDAO bDAO = new BoardManagerDAO(); 
//		  //bDAO.selectBoardAdmin("가");
//		  //System.out.println(bDAO.selectBoardAdmin("가").toString());
//		 try {
//			 
//			// System.out.println(bDAO.selectAllBoard(0,10).toString());
////			System.out.println(bDAO.selectSearchBoard(0,10,"title","가"));
//		} catch (ClassNotFoundException | NamingException e) {
//			e.printStackTrace();
//		}
//	  }//main
}

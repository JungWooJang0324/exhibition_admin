package connection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * Singleton Pattern을 도입한 클래스
 * Connection얻기, 끊기
 * @author user
 *
 */
public class DbConnection {
	private static DbConnection dc;

	private DbConnection() {
		
	}//클래스 외부에서 객체화 되는것을 막는다
	
	/**
	 * DBconnection 객체를 반환하는일
	 * @return
	 */
	public static DbConnection getInstance() {
		if(dc==null) {
			dc=new DbConnection();
		}
		return dc;
	}
	
	public Connection getConn() throws SQLException{
		
		//1. JNDI사용객체 생성
		Context ctx;
		Connection conn = null;
		try {
			ctx = new InitialContext();
			//2. DBCP찾기
			DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/manager");
			conn = ds.getConnection();
			System.out.println("DB연동 성공");
		} catch (NamingException e) {
			e.printStackTrace();
		}

		return conn;
	}
	
	public void close(ResultSet rs, Statement stmt, Connection con) throws SQLException{
		if(rs!=null) {rs.close();}
		if(stmt!=null) {stmt.close();}
		if(con!=null) {con.close();}
	}
	
			
	
}

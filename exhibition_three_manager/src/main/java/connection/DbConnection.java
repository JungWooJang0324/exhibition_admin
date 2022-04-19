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
	
<<<<<<< HEAD
	public Connection getConn() throws SQLException, ClassNotFoundException, NamingException{
		
		//1. JNDI사용객체 생성
		Context ctx = new InitialContext();

		//2. DBCP찾기
		DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/manager");
		Connection conn = ds.getConnection();
		System.out.println("DB연동 성공");
		return conn;
=======

	
	public Statement getStatement() throws SQLException {
		Statement stmt=null;
		stmt=getConn().createStatement();
		return stmt;
>>>>>>> branch 'main' of https://github.com/JungWooJang0324/exhibition_admin.git
	}
	
	public void close(ResultSet rs, Statement stmt, Connection con) throws SQLException{
		if(rs!=null) {rs.close();}
		if(stmt!=null) {stmt.close();}
		if(con!=null) {con.close();}
	}
	
			
	
}

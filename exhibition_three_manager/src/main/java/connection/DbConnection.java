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
 * Singleton Pattern�� ������ Ŭ����
 * Connection���, ����
 * @author user
 *
 */
public class DbConnection {
	private static DbConnection dc;

	private DbConnection() {
		
	}//Ŭ���� �ܺο��� ��üȭ �Ǵ°��� ���´�
	
	/**
	 * DBconnection ��ü�� ��ȯ�ϴ���
	 * @return
	 */
	public static DbConnection getInstance() {
		if(dc==null) {
			dc=new DbConnection();
		}
		return dc;
	}
	
	public Connection getConn() throws SQLException{
		
		//1. JNDI��밴ü ����
		Context ctx;
		Connection conn = null;
		try {
			ctx = new InitialContext();
			//2. DBCPã��
			DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/manager");
			conn = ds.getConnection();
			System.out.println("DB���� ����");
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

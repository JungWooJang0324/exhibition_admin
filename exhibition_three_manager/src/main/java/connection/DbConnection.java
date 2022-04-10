package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
		Connection con=null;
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String url="jdbc:oracle:thin:@211.63.89.133:1521:orcl";
		String id="exhibition";
		String pw="three";
		con= DriverManager.getConnection(url, id,pw);
		
		return con;
	}
	
	public Statement getStatement() throws SQLException {
		Statement stmt=null;
		stmt=getConn().createStatement();
		return stmt;
	}
	
	public void close(ResultSet rs, Statement stmt, Connection con) throws SQLException{
		if(rs!=null) {rs.close();}
		if(stmt!=null) {stmt.close();}
		if(con!=null) {con.close();}
	}
	
	public static void main(String[] args) {
		try {
			System.out.println(new DbConnection().getConn());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

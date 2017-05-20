package com.thinkgem.jeesite.modules.message.db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * @author jiachao
 * 操作 JDBC 的工具类. 其中封装了一些工具方法 Version 1
 */
public class JDBCTools {

	public static void release(ResultSet rs, 
			Statement statement, Connection conn) {
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		if (statement != null) {
			try {
				statement.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**
	 * 关闭 Statement 和 Connection
	 * @param statement
	 * @param conn
	 */
	public static void release(Statement statement, Connection conn) {
		if (statement != null) {
			try {
				statement.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	/**
	 * 1. 获取连接的方法. 通过读取配置文件从数据库服务器获取一个连接.
	 * 
	 * @return
	 * @throws Exception
	 */
	public static Connection getConnection() throws Exception {
		// 1. 准备连接数据库的 4 个字符串.
		// 1). 创建 Properties 对象
//		Properties properties = new Properties();
//
//		// 2). 获取 jdbc.properties 对应的输入流
//		InputStream in = JDBCTools.class.getClassLoader().getResourceAsStream(
//				"jdbc.properties");
//
//		// 3). 加载 2） 对应的输入流
//		properties.load(in);

		// 4). 具体决定 user, password 等4 个字符串.
//		String user = properties.getProperty("username");
//		String password = properties.getProperty("password");
//		String jdbcUrl = properties.getProperty("jdbcUrl");
//		String driver = properties.getProperty("driver");
		String user = "root";
		String password = "123";
		String jdbcUrl = "jdbc:mysql://localhost:3306/hse?characterEncoding=UTF-8";
		String driver = "com.mysql.jdbc.Driver";

		// 2. 加载数据库驱动程序(对应的 Driver 实现类中有注册驱动的静态代码块.)
		Class.forName(driver);

		// 3. 通过 DriverManager 的 getConnection() 方法获取数据库连接.
		return DriverManager.getConnection(jdbcUrl, user, password);
	}

}

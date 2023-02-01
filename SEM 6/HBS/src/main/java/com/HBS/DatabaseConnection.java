package com.HBS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	protected static String dbDriver = "com.mysql.cj.jdbc.Driver";
	protected static String dbURL = "jdbc:mysql://localhost:3305/";
	// Database name to access
	protected static String dbName = "sem6_wad";
	protected static String dbUsername = "root";
	protected static String dbPassword = "root";
	
	public static Connection InitializeDatabase()
		throws SQLException, ClassNotFoundException
	{
		Connection con = null;
		try {
			Class.forName(dbDriver);
			con = DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	public static Connection InitializeDatabase(String DBName)
			throws SQLException, ClassNotFoundException
		{
			// Database name to access
			//dbName = DBName;

			
			Connection con = null;
			try {
				Class.forName(dbDriver);
				con = DriverManager.getConnection(dbURL + DBName, dbUsername, dbPassword);
			}catch(Exception e) {
				e.printStackTrace();
			}
			return con;
		}
}

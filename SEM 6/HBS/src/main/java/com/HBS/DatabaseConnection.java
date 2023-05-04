package com.HBS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {
	protected static String dbDriver = "com.mysql.cj.jdbc.Driver";
	protected static String dbURL = "jdbc:mysql://localhost:3305/";
	// Database name to access
	protected static String dbName = "sem6_wad";
	protected static String dbUsername = "root";
	protected static String dbPassword = "root";
	protected static Connection con = null;
	
	public static Connection InitializeDatabase()
		throws SQLException, ClassNotFoundException
	{
		con = null;
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
				
				if(con!=null) {
					return con;
				}
				else {
					return null;
				}
			}catch(Exception e) {
				e.printStackTrace();
				return null;
			}
			
		}
	
	public static ResultSet SelectQuery(String query, Connection conn) throws SQLException {
		//Statement st = conn.createStatement();
		PreparedStatement ps=conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet record = ps.executeQuery(query);
		
		return record; 
	}
	
	public static int InsertQuery(String query,  Connection conn) throws SQLException {
		PreparedStatement ps=conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		int result = ps.executeUpdate(query);  
		return result; 
	}
}

package bean;
import java.sql.*;
import static bean.Provider.*;

public class ConnectionProvider {
	static String conError = "";
	static Connection con=null;
	static{
		try{
			Class.forName(DRIVER);
			con=DriverManager.getConnection(CONNECTION_URL,USERNAME,PASSWORD);
			}catch(Exception e){
			conError += "SQLException: " + e.getMessage();
		}
	}
	public static Connection getCon(){
		return con;
	}

	public static String getConError()
	{
		return conError;
	}
}

package bean;
import java.sql.*;
public class LoginDao {

	public static String validateErrorLog;

	public static boolean validate(LoginBean bean){
		boolean status=false;
		try{
			Connection con=ConnectionProvider.getCon();

			validateErrorLog +="\n" + ConnectionProvider.getConError() + "\n";
			validateErrorLog += (con == null)?"\nCon is null\n":"\nCon is not null\n";

			PreparedStatement ps=con.prepareStatement("select * from user432 where username=? and pass=?");
			ps.setString(1,bean.getEmail());
			ps.setString(2, bean.getPass());
			
			ResultSet rs=ps.executeQuery();
			validateErrorLog += "\nResultSet fetch size = " + rs.getFetchSize() + "\n";
			status=rs.next();
			
		}catch(Exception e){}
		return status;
	}
}

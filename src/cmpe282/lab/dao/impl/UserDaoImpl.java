package cmpe282.lab.dao.impl;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;




import cmpe282.lab.bean.User;
import cmpe282.lab.dao.UserDao;
import cmpe282.lab.database.AmazonStoreSchema;
import cmpe282.lab.database.MySQL;

public class UserDaoImpl implements UserDao {
	
	Connection con = null;
	Statement stmt = null;
	static String dbDriver = "com.mysql.jdbc.Driver";
	static String username = "root";
	static String password = "papanaidu";
	static String URL = "jdbc:mysql://estore-test.ctug6fbdtj7d.us-east-1.rds.amazonaws.com:3306/cloudschema2";
	
	public UserDaoImpl()
	  {
		   try{
		      try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		     // conn = DriverManager.getConnection("jdbc:mysql://localhost/CloudServices","root","root");
		      con = DriverManager.getConnection("jdbc:mysql://estore-test.ctug6fbdtj7d.us-east-1.rds.amazonaws.com:3306","root","papanaidu");
		   }
		   catch (SQLException e) {
					e.printStackTrace();
					
			}
	  }

	@Override
	public User findUser(String lastname, String firstname, String email,
			String password) {
		MySQL mysql = new MySQL();
		con = mysql.connectDatabase();
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {

			ps = con.prepareStatement("select * from "+AmazonStoreSchema.TABLE_USER+" where last_name = ? and first_name = ? and email = ? and password = ?");
			ps.setString(1, lastname);
			ps.setString(2, firstname);
			ps.setString(3, email);
			ps.setString(4, password);
			rs = ps.executeQuery();
			
			while(rs.next()){
				user = new User();
				user.setUser_id(rs.getInt("user_id"));
				user.setEmail(rs.getString("email"));
				user.setFirst_name(rs.getString("first_name"));
				user.setLast_login_time(rs.getString("last_login_time"));
				user.setLast_name(rs.getString("last_name"));
				user.setLogin_status(rs.getString("login_status"));
				user.setPassword(rs.getString("password"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			MySQL.closeAllConnection(rs,ps,con);
		}
		
		return user;
	}
	
	

	
	public int insertUser(User user)
	  {
		  try {
		 stmt = con.createStatement();
		 String query = "INSERT INTO `cloudschema2`.`user` (`first_name`, `last_name`, `email`, `password`) VALUES ('" + user.getFirst_name() + "', '" + user.getLast_name() + "', '" + user.getEmail() + "', '" + user.getPassword() + "');";
		 stmt.executeUpdate(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  return 1;
	  }

	
	public int updateLoginStatus(int user_id, String status) {
		MySQL mysql = new MySQL();
		con = mysql.connectDatabase();
		Statement s = null;
		try {
			s = con.createStatement();
			s.execute("update "+AmazonStoreSchema.TABLE_USER+" set login_status = '"+status+"' where user_id="+user_id);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}finally{
			MySQL.closeAllConnection(null,s,con);
		}
		return 1;
	}
	
	
	
//	public static void main(String[] arg0) throws SQLException{
//		UserDaoImpl uerdao = new UserDaoImpl();
//		if(uerdao.findUser("feng", "jiawei", "fengjiawei2011@gmail.com", "12345678") != null){
//			System.out.println("legal user");
//		}else{
//			System.out.println("illegal user!");
//		}
//		
//		
//		User user = new User();
//		user.setEmail("111");
//		user.setFirst_name("frank");
//		user.setLast_name("feng");
//		user.setPassword("111");
//		
//		if(uerdao.insertUser(user) == 1){
//			System.out.println("successful");
//			
//		}else{
//			System.out.println("error");
//		}
//		
//		if(uerdao.updateLoginStatus(1, "1") ==1 ){
//			System.out.println("succ");
//			
//		}else{
//			System.out.println("error");
//		}
//	}
	
	

}

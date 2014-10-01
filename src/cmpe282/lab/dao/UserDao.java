package cmpe282.lab.dao;

import java.sql.SQLException;

import cmpe282.lab.bean.User;

public interface UserDao {
	
	public User findUser(String lastname, String firstname, String email, String password);
	public int insertUser(User user) throws SQLException;
	public int updateLoginStatus(int user_id,String status);

}

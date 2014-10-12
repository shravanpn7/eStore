package cmpe282.lab.database;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;
/*
 *
 * @author Shravan
 */
public class DB_Conn {

    private String database="cloudschema2", username = "root", password = "papanaidu";
    private Connection con;
    
    public Connection getConnection() throws SQLException, ClassNotFoundException  {
        Class.forName("com.mysql.jdbc.Driver"); 
       // con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+database+"",""+username+"",""+password+""); 
        con = DriverManager.getConnection("jdbc:mysql://estore-test.ctug6fbdtj7d.us-east-1.rds.amazonaws.com:3306/cloudschema2","root","papanaidu");
        // stm=con.createStatement(); 
        return con;
    }

    public String getDatabase() {
        return database;
    }

    public void setDatabase(String database) {
        this.database = database;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

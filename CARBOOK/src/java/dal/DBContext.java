package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

  protected Connection connection;

    public DBContext() {
        try {
<<<<<<< HEAD
            String user = "sa";
            String pass = "123456";
          String url = "jdbc:sqlserver://localhost:1433;databaseName=CRMS_DB;encrypt=false;trustServerCertificate=true";
=======
            // Edit URL , username, password to authenticate with your MS SQL Server
            String url = "jdbc:sqlserver://localhost:1433;databaseName=CRMS_DB1;encrypt=false";
            String username = "sa";
            String password = "12345678";
>>>>>>> de2e62ac9aaa5a14108af246a26fcb6a189b436f
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                // In ra console để bạn theo dõi lúc debug, khi xong có thể xóa dòng này
                System.out.println(">>> Đã đóng kết nối Database thành công!");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
   public static void main(String[] args) {
    DBContext a = new DBContext();
    if (a.connection != null) {
        System.out.println("Kết nối thành công!");
    } else {
        System.out.println("Kết nối thất bại!");
    }
}

}
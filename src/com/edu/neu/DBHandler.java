package com.edu.neu;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.StringReader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.mysql.jdbc.util.ResultSetUtil;

import sun.rmi.log.LogInputStream;
/**
 *                             _ooOoo_
 *                            o8888888o
 *                            88" . "88
 *                            (| -_- |)                      	
 *                            O\  =  /O
 *                         ____/`---'\____
 *                       .'  \\|     |//  `.
 *                      /  \\|||  :  |||//  \
 *                     /  _||||| -:- |||||-  \
 *                     |   | \\\  -  /// |   |
 *                     | \_|  ''\---/''  |   |
 *                     \  .-\__  `-`  ___/-. /
 *                   ___`. .'  /--.--\  `. . __
 *                ."" '<  `.___\_<|>_/___.'  >'"".
 *               | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *               \  \ `-.   \_ __\ /__ _/   .-` /  /
 *          ======`-.____`-.___\_____/___.-`____.-'======
 *                             `=---='
 *          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *                     佛祖保佑        永无BUG
 */
public class DBHandler {
	private static final String driverName="com.mysql.jdbc.Driver";
	private static final String URL="jdbc:mysql://127.0.0.1:3306/dbdemo?characterEncoding=utf8&useSSL=false";
	private static final String USER="root";
	private static final String PASSWORD="123456";
		/**
	 * To register a new user
	 * @return true if register success, false if failed  
	 * */
	public static boolean registerUser(User user) {
		try {
			Connection conn=getConnection();
        	String sql="insert into user(email,username,password,registered_time) "
                    + "values(?,?,?,?)";
        	PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getUsername());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getTime().toString());
            pstmt.executeUpdate();
            free(conn, pstmt);
            return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean loginUser(User user) {
		try {
			Connection conn=getConnection();
			String sql="select password from user where email = ?";
			PreparedStatement pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, user.getEmail());
			ResultSet set=pstmt.executeQuery();
			set.next();
			String passwordFromMysql=set.getString(1);
			free(set,conn,pstmt);
			return passwordFromMysql.equals(user.getPassword());
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			return false;
		}
       
	}
	public static User getUserByUserEmail(String user_email) {
		try {
			Connection conn=getConnection();
			String sql="select * from user where email = ?";
			PreparedStatement pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, user_email);
			ResultSet set=pstmt.executeQuery();
			set.next();
			User user=new User();
			user.setEmail(set.getString("email"));
			user.setPassword(set.getString("password"));
			user.setUsername(set.getString("username"));
			user.setTime(set.getTimestamp("registered_time"));
			user.setFan_num(set.getInt("fan_num"));
			user.setFocus_num(set.getInt("focus_num"));
			free(set,conn,pstmt);
			return user;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return null;
		}
       
	}
	/**
	 * To publish an article
	 * Contain insert an article and insert an act
	 * if insert article succeed but insert act failed will rollback(回滚)
	 * */
	public static boolean publishedArticle(Article article,Act act){
		Connection conn=null;
		boolean result=true;
		try {
			conn=getConnection();
			conn.setAutoCommit(false);
        	String sql="insert into article(content,tag,is_secret,is_audit,like_num,unlike_num,img_url) "
                    + "values(?,?,?,?,?,?,?)";
        	PreparedStatement pstmt=conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
            pstmt.setClob(1, article.getContent());
            pstmt.setString(2, article.getTag());
            pstmt.setBoolean(3, article.isSecret());
            pstmt.setInt(4, 0);
            pstmt.setInt(5, 0);
            pstmt.setInt(6, 0);
            pstmt.setString(7, article.getImg_url());
            pstmt.executeUpdate();
            ResultSet rs = pstmt.getGeneratedKeys(); //获取结果  
            int autoIncKey = rs.next()?rs.getInt(1):-1;//获得自动生成的id
            act.setArticle_id(autoIncKey);
            act.setAct_type(0);
            String sql1="insert into act(user_email,article_id,time,act_type)"
                    + "values(?,?,?,?)";
        	PreparedStatement pstmt1=conn.prepareStatement(sql1);
            pstmt1.setString(1, act.getUser_email());
            pstmt1.setInt(2, act.getArticle_id());
            pstmt1.setString(3, act.getTime().toString());
            pstmt1.setInt(4, act.getAct_type());
            pstmt1.executeUpdate();       
            conn.commit();//将两条statement都提交
            rs.close();
            pstmt.close();
            pstmt1.close();
		} catch (Exception e) {
			try {
				conn.rollback();//对事件进行回滚，恢复到初始状态
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			result=false;
			e.printStackTrace();
		}finally {
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			}
		}
		return result;
	}
	public static boolean likeArticle(Act act) {
		act.setAct_type(1);
		return insertAct(act);
	}
	public static boolean unlikeArticle(Act act) {
		act.setAct_type(2);
		return insertAct(act);
	}
	public static boolean auditArticle(Act act) {
		act.setAct_type(3);
		return insertAct(act);
	}
	public static Article showArticleByArticleId(int articleId) {
		List<Article> articles=showArticleLimited(1, "article.article_id ="+articleId);
		if(articles.size()==0) {
			return null;
		}else 
		return articles.get(0);
	}
	public static List<Article> showAllArticle(int pageNumber){
		return showArticleLimited(pageNumber, "True");
	}
	public static int maxPageAllArticle() {
		return maxPageArticle("True");
	}
	public static List<Article> showArticleByUserEmail(int pageNumber,String userEmail){
		return showArticleLimited(pageNumber, "user_email = \""+userEmail+"\"");
	}
	public static int maxPageArticleByUserEmail(String userEmail) {
		return maxPageArticle("user_email = \""+userEmail+"\"");
	}
	public static List<Article> showUnSecretedArticleByUserEmail(int pageNumber,String userEmail){
		return showArticleLimited(pageNumber, "user_email = \""+userEmail+"\" and is_secret = 0");
	}
	public static int maxPageUnSecretedArticleByUserEmail(String userEmail) {
		return maxPageArticle("user_email = \""+userEmail+"\" and is_secret = 0");
	}
	//这个需要加上不能审批自己
	public static LinkedList<Article> showUnAuditedArticleNoSelf(String user_email){
		return showArticleUnLimited("is_audit = 0 and user_email <> \""+user_email+"\"");
	}
	public static LinkedList<Article> showUnAuditedArticle() {
		return showArticleUnLimited("is_audit = 0");
	}
	public static List<Article> showAuditedArticle(int pageNumber){
		return showArticleLimited(pageNumber,"is_audit = 1");
	}
	public static int maxPageAuditedArticle() {
		return maxPageArticle("is_audit = 1");
	}
	public static List<Article> showUnAuditedArticle(int pageNumber){
		return showArticleLimited(pageNumber, "is_audit = 0");
	}
	public static int maxPageUnAuditedArticle() {
		return maxPageArticle("is_audit = 0");
	}
	public static Comment showCommentByCommentId(int commentId) {
		return showCommentLimit(1, "comment_id = "+commentId).get(0);
	}
	public static LinkedList<Comment> showCommentByArticleId(int articleId){
		return showCommentUnlimit("article_id = "+articleId);
	}
	public static List<Comment> showCommentByUserEmail(int pageNumber,String userEmail){
		return showCommentLimit(pageNumber, "user_email = \""+userEmail+"\"");
	}
	public static int maxPageCommentByUserEmail(String userEmail) {
		return maxPageComment("user_email = \""+userEmail+"\"");
	}
	public static List<Comment> showUnsecretedCommentByUserEmail(int pageNumber,String userEmail){
		return showCommentLimit(pageNumber, "user_email = \""+userEmail+"\" and is_secret = 0");
	}
	public static int maxPageUnsecretedCommentByUserEmail(String userEmail) {
		return maxPageComment("user_email = \""+userEmail+"\" and is_secret = 0");
	}
	public static boolean publishComment(Comment comment){
		try {
			Connection conn=getConnection();
			String sql="insert into comment(content,is_secret,user_email,article_id,time,last_comment_id)"
                    + "values(?,?,?,?,?,?)";
        	PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, comment.getContent());
            pstmt.setBoolean(2,comment.isSecret());
            pstmt.setString(3, comment.getUser_email());
            pstmt.setInt(4, comment.getArticle_id());
            pstmt.setString(5, comment.getTime().toString());
            if(comment.getLast_comment_id()==Comment.NULL_COMMENT_ID)
            	pstmt.setNull(6, Types.INTEGER);
            else
            	pstmt.setInt(6, comment.getLast_comment_id());
            pstmt.executeUpdate();
            free(conn, pstmt);
            return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	/**
	 * 点关注用的方法
	 * */
	public static boolean focus(Focus focusItem) {
		try {
			Connection conn=getConnection();
			String sql="insert into focus(user_email,focus_email)"
                    + "values(?,?)";
        	PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, focusItem.getUser_email());            
            pstmt.setString(2, focusItem.getFocus_email());
            pstmt.executeUpdate();
            free(conn, pstmt);
            return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public static boolean hasFocused(Focus focusItem) {
		try {
			Connection conn=getConnection();
			String sql="select * from focus where focus_email = ? and user_email = ?";
        	PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, focusItem.getFocus_email());            
            pstmt.setString(2, focusItem.getUser_email());
            ResultSet set=pstmt.executeQuery();
            if(set.next()) {
            	free(set,conn,pstmt);
            	return true;
            }else {
            	free(set,conn,pstmt);
            	return false;
            }
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public static boolean existAct(Act act) {
		try {
			Connection conn=getConnection();
			String sql="select * from act where user_email = ? and article_id = ? and act_type = ?";
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, act.getUser_email());            
			pstmt.setInt(2, act.getArticle_id());
			pstmt.setInt(3, act.getAct_type());
        	ResultSet set=pstmt.executeQuery();
        	if(set.next()) {
        		free(set,conn,pstmt);
        		return true;
        	}else {
        		free(set,conn,pstmt);
        		return false;
        	}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public static User findAuthor(int article_id) throws SQLException {
		Connection conn=getConnection();
		String sql="select * from user,article,act where article.article_id=act.article_id and act.act_type = 0 and user.email=act.user_email and article.article_id="+article_id;
		PreparedStatement pstmt= conn.prepareStatement(sql);
		ResultSet set=pstmt.executeQuery();
		set.next();
		User user=new User();
		user.setEmail(set.getString("email"));
		user.setUsername(set.getString("username"));
		return user;
	}
	/**
	 * To get a connection from mysql
	 * */
	private static Connection getConnection() {
		Connection connection=null;
		try {
			Class.forName(driverName);
			connection=DriverManager.getConnection(URL, USER, PASSWORD);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
	/**
	 * To free resultset,connection,statement 
	 * Do this after finish a command
	 * */
	private static void free(ResultSet rs,Connection connection,Statement statement) {
		try {
			if(rs!=null)
				rs.close();
			connection.close();
			statement.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * To free connection,statement 
	 * Do this after finish a command
	 * */
	private static void free(Connection connection,Statement statement) {
		try {
			connection.close();
			statement.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static boolean insertAct(Act act) {
		try {
			Connection conn=getConnection();
			String sql="insert into act(user_email,article_id,time,act_type)"
                    + "values(?,?,?,?)";
        	PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, act.getUser_email());
            pstmt.setInt(2, act.getArticle_id());
            pstmt.setString(3, act.getTime().toString());
            pstmt.setInt(4, act.getAct_type());
            pstmt.executeUpdate();
            free(conn, pstmt);
            return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	private static LinkedList<Article> showArticleUnLimited(String whereClause){
		return showArticle(1, whereClause, false);
	}
	private static LinkedList<Article> showArticleLimited(int pageNumber,String whereClause){
		return showArticle(pageNumber, whereClause, true);
	}
	private static LinkedList<Article> showArticle(int pageNumber,String whereClause,boolean is_limited){
		LinkedList<Article> articles=new LinkedList<>();
		try {
			Connection conn=getConnection();
			String sql="select * from article , act where article.article_id=act.article_id and act.act_type = 0 and "+whereClause;
			sql+=is_limited?" order by time desc limit "+(pageNumber-1)*4+", 4":"";
			System.out.println(pageNumber);
			System.out.println(sql);
			PreparedStatement pstmt= conn.prepareStatement(sql);
			ResultSet set=pstmt.executeQuery();
			while(set.next()) {
				Article article=new Article(set.getInt("article_id"), 
						set.getCharacterStream("content"), set.getString("tag"), set.getBoolean("is_secret"), 
						set.getBoolean("is_audit"), set.getInt("like_num"), set.getInt("unlike_num"));
				article.setAuthor(set.getString("user_email"));
				article.setTime(set.getTimestamp("time"));
				article.setImg_url(set.getString("img_url"));
				articles.add(article);
			}
			free(set,conn, pstmt);
			return articles;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return articles;
		}
	}
	private static int maxPageArticle(String whereClause) {
		try {
			Connection conn=getConnection();
			String sql="select count(*) from article , act where article.article_id=act.article_id and act.act_type = 0 and "+whereClause;
			PreparedStatement pstmt= conn.prepareStatement(sql);
			ResultSet set=pstmt.executeQuery();
			set.next();
			int rowNum=set.getInt(1);
			free(set,conn, pstmt);
			return (int) Math.ceil(1.0*rowNum/4);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return 0;
		}
	}
	private static LinkedList<Comment> showCommentUnlimit(String whereClause){
		return showComment(1, whereClause, false);
	}
	private static LinkedList<Comment> showCommentLimit(int pageNumber,String whereClause){
		return showComment(pageNumber, whereClause, true);
	}
	private static LinkedList<Comment> showComment(int pageNumber,String whereClause,boolean is_limited){
		LinkedList<Comment> comments=new LinkedList<>();
		try {
			Connection conn=getConnection();
			String sql="select * from comment,user where user.email = comment.user_email and "+whereClause+" order by time desc ";
			sql+=is_limited?"limit "+(pageNumber-1)*5+", 5":"";
			System.out.println(sql);
			PreparedStatement pstmt= conn.prepareStatement(sql);
			ResultSet set=pstmt.executeQuery();
			while(set.next()) {
				Comment comment=new Comment(set.getInt("article_id"), set.getString("content"), 
						set.getBoolean("is_secret"), set.getString("user_email"), set.getInt("article_id"), 
						set.getTimestamp("time"), set.getInt("last_comment_id"));
				comment.setUsername(set.getString("username"));
				comments.add(comment);
			}
			free(set,conn, pstmt);
			return comments;
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return comments;
		}
	}
	private static int maxPageComment(String whereClause) {
		try {
			Connection conn=getConnection();
			String sql="select count(*) from comment where "+whereClause;
			PreparedStatement pstmt= conn.prepareStatement(sql);
			ResultSet set=pstmt.executeQuery();
			set.next();
			int rowNum=set.getInt(1);
			free(set,conn, pstmt);
			return (int) Math.ceil(1.0*rowNum/5);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return 0;
		}
	}
	public static void main(String[] args) throws FileNotFoundException {
		showCommentByUserEmail(1,"3@neu.com");
	}
}

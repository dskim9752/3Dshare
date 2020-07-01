package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import dto.CommentBean;
import jdbc.ConnectionProvider;

public class CommentDAO {
	
	private CommentDAO() { 
	}

	private static CommentDAO instance = new CommentDAO();
	public static CommentDAO getInstance(){
		return instance;
	} 

	// insert
	public int insert(Connection conn, CommentBean Comment) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into Comment values (?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Comment.getCnum());
			pstmt.setInt(2, Comment.getPnum());
			pstmt.setString(3, Comment.getId());
			pstmt.setTimestamp(4, Comment.getDate());
			pstmt.setString(5, Comment.getText());
			pstmt.setInt(6, Comment.getDepth());
			pstmt.setString(7, Comment.getName());
			return pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	// delete
	public int delete(Connection conn, int cnum, int pnum) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String sql = "delete from Comment where  (`cnum`=?) AND (`pnum`=?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.setInt(2, pnum);
			return pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	// renew
	public int renew(Connection conn, CommentBean Comment,int number) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "update Comment set `cnum` = ? where (`cnum`=?) AND (`pnum`=?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			System.out.println( Comment.getCnum()+"    "+Comment.getPnum());
			pstmt.setInt(2, Comment.getCnum());
			pstmt.setInt(3, Comment.getPnum());
			return pstmt.executeUpdate();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	// select(find/get)
	public CommentBean select(Connection conn, int cnum, int pnum) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from Comment where `cnum`=?, `pnum`=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.setInt(2, pnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return createFromResultSet(rs);
			}
			else {
				return null;
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	public CommentBean createFromResultSet(ResultSet rs) throws SQLException {		
		int cnum = rs.getInt("cnum");
		int pnum = rs.getInt("pnum");
		String id = rs.getString("id");
		Timestamp date = rs.getTimestamp("date");
		String text = rs.getString("text");
		int depth = rs.getInt("depth");
		String name = rs.getString("name");
		CommentBean pe = new CommentBean(cnum,pnum,id,date,text,depth,name);
		return pe;
	}

	// selectList
	public List<CommentBean> selectList(Connection conn, int pnum) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from Comment where `pnum`=? order by cnum asc;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			List<CommentBean> pList = new ArrayList<>();
			while (rs.next()) {
				pList.add(createFromResultSet(rs));
			}
			return pList;
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}
	
	//getcnum
		public int nextCnum(int pnum)  throws SQLException {
			Connection conn = ConnectionProvider.getConnection();
			int cnum = 0;

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				do{
					cnum++;
					String sql = "select * from Comment where (`cnum`=?) AND (`pnum`=?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, cnum);
					pstmt.setInt(2, pnum);
					rs = pstmt.executeQuery();		
				}while(rs.next());
				return cnum;
			} finally {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}

			}
		}

}

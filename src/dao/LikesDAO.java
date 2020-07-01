package dao;
import dto.LikesBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LikesDAO {
	private LikesDAO() { 
	}
	
	private static LikesDAO instance = new LikesDAO();
	public static LikesDAO getInstance(){
		return instance;
	} 


	// insert
		public int insert(Connection conn, LikesBean likes) throws SQLException {
			PreparedStatement pstmt = null;
			try {
				String sql = "insert into likes values (?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, likes.getPnum());
				pstmt.setString(2, likes.getId());
				return pstmt.executeUpdate();
			} finally {
				if (pstmt != null) {
					pstmt.close();
				}
			}
		}


		// select(find/get) where pnum
		public LikesBean select(Connection conn, int pnum) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "select * from likes where pnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
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

		// select(find/get) where pnum & id
				public LikesBean select(Connection conn, int pnum , String id) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						String sql = "select * from likes where pnum=? and id =?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pnum);
						pstmt.setString(2, id);
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

		//count likes by pnum
				public int likes(Connection conn, int pnum) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
					String sql = "SELECT COUNT(*) as likes FROM likes where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						int likes =  rs.getInt("likes");
						return likes;
					}else {
						return 0;
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
		
				//count likes by id
				public int likes(Connection conn, String id) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
					String sql = "SELECT COUNT(*) as likes FROM likes where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						int likes =  rs.getInt("likes");
						return likes;
					}else {
						return 0;
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
		
		public LikesBean createFromResultSet(ResultSet rs) throws SQLException {
			int pnum = rs.getInt("pnum");
			String id = rs.getString("id");
			LikesBean pe = new LikesBean(pnum,id);
			return pe;
		}
		
		
		
		// for top5View
		public List<LikesBean> selectTop5(Connection conn) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "SELECT *, COUNT(*) as top5 FROM likes GROUP BY pnum order by top5 desc limit 5";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				List<LikesBean> sList = new ArrayList<>();
				if (!rs.next()) {
					return null;
				}
				do {
					sList.add(createFromResultSet(rs));
				}while (rs.next());	
				return sList;
			} finally {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			}
		}
		

//SELECT pnum, COUNT(*) as top5 FROM likes GROUP BY pnum  limit 5;
}

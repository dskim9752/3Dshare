package dao;
import dto.StarBean;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StarDAO {
	private StarDAO() { 
	}
	
	private static StarDAO instance = new StarDAO();
	public static StarDAO getInstance(){
		return instance;
	} 


	// insert
		public int insert(Connection conn, StarBean star) throws SQLException {
			PreparedStatement pstmt = null;
			try {
				String sql = "insert into star values (?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, star.getPnum());
				pstmt.setString(2, star.getId());
				return pstmt.executeUpdate();
			} finally {
				if (pstmt != null) {
					pstmt.close();
				}
			}
		}
		// delete
		public int delete(Connection conn, int pnum,String id) throws SQLException {
			PreparedStatement pstmt = null;
			try {
				String sql = "delete from star where pnum=? and id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, id);
				return pstmt.executeUpdate();
			} finally {
				if (pstmt != null) {
					pstmt.close();
				}
			}
		}

		// select(find/get) where pnum
		public List<StarBean> select(Connection conn, int pnum) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "select * from star where pnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				rs = pstmt.executeQuery();
				List<StarBean> sList = new ArrayList<>();
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
		
		
		
		// select(find/get) where id
				public List<StarBean> select(Connection conn, String id) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						String sql = "select * from star where id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						rs = pstmt.executeQuery();
						List<StarBean> sList = new ArrayList<>();
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
		

		// select(find/get) where pnum & id
				public StarBean select(Connection conn, int pnum , String id) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						String sql = "select * from star where pnum=? and id =?";
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

		//count star by pnum
				public int star(Connection conn, int pnum) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
					String sql = "SELECT COUNT(*) as star FROM star where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						int star =  rs.getInt("star");
						return star;
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
		
				//count star by id
				public int star(Connection conn, String id) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
					String sql = "SELECT COUNT(*) as star FROM star where id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						int star =  rs.getInt("star");
						return star;
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
		
		public StarBean createFromResultSet(ResultSet rs) throws SQLException {
			int pnum = rs.getInt("pnum");
			String id = rs.getString("id");
			StarBean pe = new StarBean(pnum,id);
			return pe;
		}


		
		
		// 즐겨찾기 여부 check
		public boolean checkStar(Connection conn, int pnum , String id) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "select * from star where pnum=? and id =?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					return true;
				}
				else {
					return false;
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
}

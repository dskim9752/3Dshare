package dao;

import dto.LikesBean;
import dto.PostBean;
import dto.StarBean;
import jdbc.ConnectionProvider;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
	private PostDAO() { 
	}

	private static PostDAO instance = new PostDAO();
	public static PostDAO getInstance(){
		return instance;
	} 

	// insert
	public int insert(Connection conn, PostBean post) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into post values (?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, post.getPnum());
			pstmt.setString(2, post.getId());
			pstmt.setString(3, post.getName());
			pstmt.setTimestamp(4, post.getTimeStamp());
			pstmt.setString(5, post.getTitle());
			pstmt.setString(6, post.getText());
			pstmt.setString(7, post.getCategory());
			return pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	// delete
	public int delete(Connection conn, int pnum) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String sql = "delete from post where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			return pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	// edit
	public int edit(Connection conn, PostBean post) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "update post set post.title = ?, post.text = ?, post.category= ? where (pnum = ? )";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, post.getTitle());
			pstmt.setString(2, post.getText());
			pstmt.setString(3, post.getCategory());
			pstmt.setInt(4, post.getPnum());
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
	public PostBean select(Connection conn, int pnum) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from post where pnum=?";
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
	
	public PostBean createFromResultSet(ResultSet rs) throws SQLException {		
		int pnum = rs.getInt("pnum");
		String id = rs.getString("id");
		String name = rs.getString("name");
		Timestamp date = rs.getTimestamp("date");
		String title = rs.getString("title");
		String text = rs.getString("text");
		String category = rs.getString("category");
		PostBean pe = new PostBean(pnum,id,name,date,title,text,category);
		return pe;
	}

	// selectList
	public List<PostBean> selectList(Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from post order by pnum asc;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			List<PostBean> pList = new ArrayList<>();
			do {
				pList.add(createFromResultSet(rs));
			}while (rs.next());
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
	//get next pnum
	public int nextPnum()  throws SQLException {
		Connection conn = ConnectionProvider.getConnection();
		int pnum = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
				//String sql = "select * from post where pnum=?";
				String sql = "SELECT * FROM post where pnum = (SELECT max(pnum) FROM post);";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					pnum = createFromResultSet(rs).getPnum()+1; //다음 pnum을 구한다.
				}
				else {
					pnum = 1;
				}
			return pnum;
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null || pstmt == null) {
				pstmt.close();
			}
			conn.close();
		}
	}
	
	
	//

	// select(find/get)
		public List<PostBean> search(Connection conn, String user_word) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {//System.out.println("%"+user_word+"%");
				String sql = "select * from post where title like ? or  text like ?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+user_word+"%");
				pstmt.setString(2, "%"+user_word+"%");
				rs = pstmt.executeQuery();
				List<PostBean> pList = new ArrayList<>();
				if (!rs.next()) {
					return null;
				}
				do {
					pList.add(createFromResultSet(rs));
				}while (rs.next());
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
		
		public List<PostBean> searchByCategory(Connection conn, String category) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "select * from post where category=?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, category);
				rs = pstmt.executeQuery();
				List<PostBean> pList = new ArrayList<>();
				if (!rs.next()) {
					//System.out.println("null 발생");
					return null;
				}
				do {
					pList.add(createFromResultSet(rs));
				}while (rs.next());
				//System.out.println("pList = "+pList.toString());
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
		
		// selectMyPostList
		public List<PostBean> selectMyPostList(Connection conn, String name) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "select * from post where name=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				rs = pstmt.executeQuery();
				List<PostBean> pList = new ArrayList<>();
				if (!rs.next()) {
					//System.out.println("null 발생");
					return null;
				}
				do {
					pList.add(createFromResultSet(rs));
				}while (rs.next());
				//System.out.println("pList = "+pList.toString());
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
		
		
		//searchByStar
		public List<PostBean> searchByStar(Connection conn, List<StarBean> star) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			if(star == null)return null;
			try {

				String sql = "select * from post where pnum=? "; 
				for(int i=1;i<star.size();i++) {
					sql +="or pnum=? ";
				}
				pstmt = conn.prepareStatement(sql);
				int num=1;
				for(StarBean s : star) {
					pstmt.setInt(num, s.getPnum());
					num++;
				}
				rs = pstmt.executeQuery();
				List<PostBean> pList = new ArrayList<>();
				if (!rs.next()) {
					return null;
				}
				do {
					pList.add(createFromResultSet(rs));
				}while (rs.next());
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
		
		//searchByLikes
				public List<PostBean> searchByLikes(Connection conn, List<LikesBean> likes) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					if(likes == null)return null;
					try {

						String sql = "select * from post where pnum=? "; 
						for(int i=1;i<likes.size();i++) {
							sql +="or pnum=? ";
						}
						pstmt = conn.prepareStatement(sql);
						int num=1;
						for(LikesBean l : likes) {
							pstmt.setInt(num, l.getPnum());
							num++;
						}
						rs = pstmt.executeQuery();
						List<PostBean> pList = new ArrayList<>();
						if (!rs.next()) {
							return null;
						}
						do {
							pList.add(createFromResultSet(rs));
						}while (rs.next());
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
				
				
				// selectUser
				public List<PostBean> searchByName(Connection conn, String name) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						String sql = "select * from post where name like ? or  id like ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, "%"+name+"%");
						pstmt.setString(2, "%"+name+"%");
						rs = pstmt.executeQuery();
						List<PostBean> pList = new ArrayList<>();
						if (!rs.next()) {
							//System.out.println("null 발생");
							return null;
						}
						do {
							pList.add(createFromResultSet(rs));
						}while (rs.next());
						//System.out.println("pList = "+pList.toString());
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
		
}

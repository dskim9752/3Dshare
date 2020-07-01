package dao;

import dto.UserBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	private UserDAO() { 
	}
	
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance(){
		return instance;
	} 

	// insert
	public int insert(Connection conn, UserBean u) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into user values (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getId());
			pstmt.setString(2, u.getPassword());
			pstmt.setString(3, u.getEmail());
			pstmt.setString(4, u.getName());
			return pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	// delete
	public int delete(Connection conn, String id) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String sql = "delete from user where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			return pstmt.executeUpdate();
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	// edit
	public int edit(Connection conn, UserBean u) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "update user set `password` = ?, `email` = ?, `name` = ? where `id` =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getPassword());
			pstmt.setString(2, u.getEmail());
			pstmt.setString(3, u.getName());
			pstmt.setString(4, u.getId());
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
	
	// select(find/get) id
	public UserBean select(Connection conn, String id) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from user where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
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
	// select(find/get) nuckName
		public UserBean selectByName(Connection conn, String name) throws SQLException {
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				String sql = "select * from user where name=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
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
	
		// select(find/get) nuckName
				public String findName(Connection conn, String id) throws SQLException {
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					try {
						String sql = "select name from user where id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, id);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							return createFromResultSet(rs).getName();
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
				
	public UserBean createFromResultSet(ResultSet rs) throws SQLException {
		String id = rs.getString("id");
		String password = rs.getString("password");
		String email = rs.getString("email");
		String name = rs.getString("name");
		UserBean pe = new UserBean(id, password, email, name);
		return pe;
	}
	
	// selectList
	public List<UserBean> selectList(Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from user";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			List<UserBean> pList = new ArrayList<>();
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
	
}

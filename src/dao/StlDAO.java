package dao;

import dto.StlBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StlDAO {
	private StlDAO() { 
	}
	
	private static StlDAO instance = new StlDAO();
	public static StlDAO getInstance(){
		return instance;
	} 

	// insert
	public int insert(Connection conn, StlBean stl) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into stl values (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, stl.getPnum());
			pstmt.setInt(2, stl.getSnum());
			pstmt.setString(3, stl.getStlName());
			pstmt.setString(4, stl.getStlSrc());
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
			String sql = "delete from stl where pnum=?";
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
	public int edit(Connection conn, StlBean stl) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "update stl set `snum` = ?, `stlname` = ? 'stlsrc'=? where `pnum` =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, stl.getSnum());
			pstmt.setString(2, stl.getStlName());
			pstmt.setString(3, stl.getStlSrc());
			pstmt.setInt(4, stl.getSnum());
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
	public StlBean select(Connection conn, int pnum) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from stl where pnum=?";
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
	
	public StlBean createFromResultSet(ResultSet rs) throws SQLException {		
		int pnum = rs.getInt("pnum");
		int snum = rs.getInt("snum");
		String stlName = rs.getString("stlname");
		String stlSrc = rs.getString("stlsrc");
		StlBean pe = new StlBean(pnum,snum,stlName,stlSrc);
		return pe;
	}
	
	// selectList
	public List<StlBean> selectList(Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from stl  order by snum asc;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			List<StlBean> iList = new ArrayList<>();
			while (rs.next()) {
				iList.add(createFromResultSet(rs));
			}
			return iList;
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

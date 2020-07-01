package dao;

import dto.ImgBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ImgDAO {
	private ImgDAO() { 
	}
	
	private static ImgDAO instance = new ImgDAO();
	public static ImgDAO getInstance(){
		return instance;
	} 

	// insert
	public int insert(Connection conn, ImgBean img) throws SQLException {
		PreparedStatement pstmt = null; 
		try {
			String sql = "insert into img values (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, img.getPnum());
			pstmt.setInt(2, img.getInum());
			pstmt.setString(3, img.getImgName());
			pstmt.setString(4, img.getImgSrc());
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
			String sql = "delete from img where pnum=?";
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
	public int edit(Connection conn, ImgBean img) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "update img set `inum` = ?, `imgname` = ? 'imgsrc'=? where `pnum` =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, img.getInum());
			pstmt.setString(2, img.getImgName());
			pstmt.setString(3, img.getImgSrc());
			pstmt.setInt(4, img.getInum());
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
	public ImgBean select(Connection conn, int pnum) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from img where pnum=?";
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
	
	public ImgBean createFromResultSet(ResultSet rs) throws SQLException {		
		int pnum = rs.getInt("pnum");
		int inum = rs.getInt("inum");
		String imgName = rs.getString("imgname");
		String imgSrc = rs.getString("imgsrc");
		ImgBean pe = new ImgBean(pnum,inum,imgName,imgSrc);
		return pe;
	}
	
	// selectList
	public List<ImgBean> selectList(Connection conn) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from img order by pnum asc;";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			List<ImgBean> iList = new ArrayList<>();
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

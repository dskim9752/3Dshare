<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.StlDAO"%>
<%@page import="dto.StlBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>


<%
int pnum = Integer.parseInt(request.getParameter("pnum"));
//int snum = Integer.parseInt(request.getParameter("snum"));    //복수 파일 첨부시 사용
try{
Connection conn = ConnectionProvider.getConnection();
StlDAO daoS = StlDAO.getInstance(); // getInstance
StlBean stl = daoS.select(conn, pnum);



 response.setContentType("application/download");

 //String fileName = "tomcat.gif";
 String savePath = stl.getStlSrc();
 String fileName = stl.getStlName();

 //아래처럼 attachment 를 사용하면 브라우저는 무조건 다운로드 창을 띄우고 파일명을 보여준다.
 response.setHeader("Content-Disposition", "attachment;filename="+fileName+";");



 ServletOutputStream sos =  response.getOutputStream();

 //다음과 같이 스트림을 열고 브라우저에 바이트 데이터를 전송해주면 된다.
 FileInputStream fio = null;
 byte[] buf = new byte[1024];
 fio = new FileInputStream(savePath);
 int n = 0;


 while((n=fio.read(buf, 0, buf.length))!=-1) {
  sos.write(buf, 0, n);
 	sos.flush();
 }
 response.flushBuffer();
 out.clear();
 out = pageContext.pushBody();
 fio.close();
}catch(Exception e){e.printStackTrace();}
%>
conn.close();
<script>
	//history.go(-1); //뒤로가기
	location.href='viewPost.jsp?pnum=<%=pnum %>'
</script>
 
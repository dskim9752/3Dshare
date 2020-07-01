<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="dao.PostDAO"%>
<%@page import="dto.PostBean"%>
<%@page import="dao.ImgDAO"%>
<%@page import="dto.ImgBean"%>
<%@page import="dao.StlDAO"%>
<%@page import="dto.StlBean"%>
<%@page import="java.sql.*"%>
<%@page import="jdbc.ConnectionProvider"%>	


<%@page import= "java.sql.Timestamp"%>
<%@page import= "java.text.SimpleDateFormat"%>
<%@page import= "java.util.Calendar"%>

<%
	/* String id = request.getParameter("id");
	out.print(id); // request.getParameter() 사용 불가  */
	
	String userID = (String) session.getAttribute("userID");
	String name = (String) session.getAttribute("userName");
	String title = "";
	String category = "";
	String text = "";
	
	
	String imgFileName = "";
	String stlFileName = "";
	String orgimgFileName = "";
	String orgstlFileName = "";
	PostDAO daoP = PostDAO.getInstance(); // getInstance
	int pnum = daoP.nextPnum();
	
	String uploadsDir = "/uploads/"+pnum+"/";  
	String uploadPath = request.getSession().getServletContext().getRealPath(uploadsDir); 
	
	if (!new File(uploadPath).exists()) { 
	 new File(uploadPath).mkdirs();  //폴더 없으면 만들기
	} 
	
	
	out.println(uploadPath);
	
	try {
		MultipartRequest multi = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리) - 이미지와 나머지 
				request, 
				uploadPath, // 파일을 저장할 디렉토리 지정
				30 *1024* 1024, // 첨부파일 최대 용량 설정(bite) / 30MB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);
	
		title = multi.getParameter("title"); // form의 name="title"인 값을 구함
		text = multi.getParameter("text");
		category = multi.getParameter("category");
		//System.out.println("category = "+category);

		imgFileName = multi.getFilesystemName("imgfile"); // name=imgfile의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
		//orgimgFileName = multi.getOriginalFileName("imgfile"); // name=imgfile의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)
		
		stlFileName = multi.getFilesystemName("stlfile");
		//orgstlFileName = multi.getOriginalFileName("stlfile");

		//get time
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
		Calendar cal = Calendar.getInstance();
		String today = null;
		today = formatter.format(cal.getTime());
		Timestamp time = Timestamp.valueOf(today);
		
		
		
		ImgDAO daoI = ImgDAO.getInstance(); // getInstance
        StlDAO daoS = StlDAO.getInstance(); // getInstance
		
		PostBean post = new PostBean(pnum,userID,name,time,title,text,category); 
		//System.out.println("post = "+ post.toString());
		Connection conn = ConnectionProvider.getConnection();
		daoP.insert(conn, post);
        ImgBean img = new ImgBean(pnum,1,imgFileName,uploadPath + imgFileName);
        StlBean stl = new StlBean(pnum,1,stlFileName,uploadPath + stlFileName);
		//System.out.println("snum = "+ stl.getSnum());
        daoI.insert(conn, img);
        daoS.insert(conn, stl);
    	conn.close();	       
	} catch (Exception e) {
		e.getStackTrace();
	} // 업로드 종료

	response.sendRedirect("main.jsp");
%>
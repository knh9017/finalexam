<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
UserDAO userDAO = new UserDAO();
Connection conn = userDAO.conn;
PreparedStatement pstmt = userDAO.pstmt;
ResultSet rs = userDAO.rs;
String id = request.getParameter("userID"); 
String sql = "DELETE FROM user WHERE userID = ?";
try{
	 
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
    pstmt.executeUpdate();
}catch (Exception e){
	e.printStackTrace();
	
}


%>
<script>
	alert( "삭제되었습니다.")
	location.href="managermod.jsp"
</script>
</body>
</html>
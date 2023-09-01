<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter" %>  <!--자바스크립트 작성을 위함   -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF-8로 받기위함 -->
 
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP BBS</title>
</head>
<body>
    <%
        UserDAO userDAO = new UserDAO();
        int result = userDAO.manager(user.getUserID(), user.getUserPassword());
        if (result ==3){
        	
            PrintWriter script = response.getWriter(); 
            script.println("<script>");
            script.println("location.href = 'managermod.jsp'");
            script.println("</script>");
        }
        else if (result == 4){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호 혹은 아이디가 틀립니다.')");
            script.println("history.back()");    // 이전 페이지로 사용자를 보냄
            script.println("</script>");
        }
        
    %>
 
</body>
</html>
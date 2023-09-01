<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import = "java.sql.Connection" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<link rel="stylesheet" href="css/custom.css"> <!-- 참조  -->
<title>JSP 게시판 웹 사이트</title>
<style type = "text/css">
    a, a:hover
    {
        color: #000000;
        text-decoration: none;
    }
</style>
</head>
<body>
<%
UserDAO userDAO = new UserDAO();
Connection conn = userDAO.conn;
PreparedStatement pstmt = userDAO.pstmt;
ResultSet rs = userDAO.rs;


%>
<%

    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
    }
    int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
    if (request.getParameter("pageNumber") != null)
    {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
%>
    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
            <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="loginAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
            <%
                }
            %>
        </div>
    </nav>
    
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color:#eeeeee; text-align:center;">ID</th>
                        <th style="background-color:#eeeeee; text-align:center;">이름</th>
                        <th style="background-color:#eeeeee; text-align:center;">이메일 </th>
                        <th style="background-color:#eeeeee; text-align:center;">성별</th>
                        <th style="background-color:#eeeeee; text-align:center;"></th>
                    </tr>
                </thead>
                <tbody>
                
    <tr>
        <td><% 
       
        String sql = "select * from user";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        %>
        </td>
        
    </tr>
     <%
            while (rs.next()) {
            %>
            <form action="withdraw.jsp">
             <input type="hidden" name="userID" value="<%= rs.getString("userID") %>">
            <tr>
                    <td align="center"><% out.print(rs.getString("userID"));%></td>
                    <td align="ceneter"><% out.print(rs.getString("userName")); %></td>
                    <td align="center"><% out.print(rs.getString("userEmail"));%></td>
                    <td align="center"><% out.print(rs.getString("userGender"));%></td>
                    <td> <button type="submit"> 삭제</button></td>
                    </tr>
                    </form>
                <%
            }
                %>

                </tbody>
            </table>
            
            
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>

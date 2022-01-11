<%-- 
    Document   : add
    Created on : Jan 11, 2022, 2:14:52 PM
    Author     : ACER I7
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
JSONArray list = new JSONArray();


String tenid = request.getParameter("tid");
String tname =  request.getParameter("tname");
String toccupation =  request.getParameter("toccupation");
String rent =  request.getParameter("rent");


Connection con;
PreparedStatement pst;
ResultSet rs;

JSONObject obj = new JSONObject();

Class.forName("com.mysql.jdbc.Driver");

con = DriverManager.getConnection("jdbc:mysql://localhost:3325/rent?","root","");
pst = con.prepareStatement("update  records  set tname = ?, toccupation = ?, rent = ? where id= ?");
pst.setString(1, tname);
pst.setString(2, toccupation);
pst.setString(3, rent);
pst.setString(4, tenid);

pst.executeUpdate();
obj.put("name", "success");
list.add(obj);

out.println(list.toJSONString());
out.flush();


%>

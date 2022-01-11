<%-- 
    Document   : tenant
    Created on : Jan 11, 2022, 3:28:29 PM
    Author     : ACER I7
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
JSONArray list = new JSONArray();
Connection con;
PreparedStatement pst;
ResultSet rs;


Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3325/rent?","root","");

String query = "select * from records";

Statement stmt = con.createStatement();

rs = stmt.executeQuery(query);

while(rs.next())
{
    JSONObject obj = new JSONObject();
    String id = rs.getString("id");
    String name = rs.getString("tname");
    String occupation = rs.getString("toccupation");
    String rent = rs.getString("rent");
    
    obj.put("tname", name);
    obj.put("toccupation", occupation);
    obj.put("rent", rent);
    obj.put("id", id);
    
    
    list.add(obj);
    

}

out.print(list.toJSONString());
out.flush();












%>
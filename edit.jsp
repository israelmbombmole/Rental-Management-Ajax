<%-- 
    Document   : edit
    Created on : Jan 11, 2022, 4:52:38 PM
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


String id = request.getParameter("id");
pst = con.prepareStatement("select id,tname,toccupation,rent from records where id = ?");
pst.setString(1, id);
rs = pst.executeQuery();

if(rs.next()==true)
{
String id1 = rs.getString(1);
String tname = rs.getString(2);
String toccupation = rs.getString(3);
String rent = rs.getString(4);

JSONObject obj = new JSONObject();


obj.put("id",id1);
obj.put("tname",tname);
obj.put("toccupation",toccupation);
obj.put("rent",rent);

list.add(obj);


}


out.print(list.toJSONString());
out.flush();




%>

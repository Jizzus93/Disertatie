<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.SentenceBean" %>
<%@ page import="bean.WordBean" %>
<%@ page import="bean.OccurrenceBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.reflect.TypeToken" %><%--
  Created by IntelliJ IDEA.
  User: octak
  Date: 5/26/2018
  Time: 12:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%
    String verb = request.getParameter("verb");




    URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getVerbOccurrences?verb=" + verb);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Accept", "application/json");

    if (conn.getResponseCode() != 200) {

        throw new RuntimeException("Failed : HTTP error code : "
                + conn.getResponseCode());
    }

    BufferedReader br = new BufferedReader(new InputStreamReader(
            (conn.getInputStream())));
    StringBuilder jsonStr = new StringBuilder();
    String output;
    while ((output = br.readLine()) != null) {
        jsonStr.append(output);
    }

    conn.disconnect();

    Gson gson = new Gson();
    ArrayList<OccurrenceBean> occurrences = gson.fromJson(jsonStr.toString() , new TypeToken<ArrayList<OccurrenceBean>>(){}.getType());
    //<form action="exampleSave.jsp" method="post" target="_blank" >
%>


    <div class="container">

        <%

            for(int i=0; i< occurrences.size() && i<21; i++)
            {
                switch(i%3)
                {
                    case 0:
                    {
                        OccurrenceBean occurrence = occurrences.get(i);

                        String params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();

                        out.println("<div class=\"row\">");
                        out.println("<div class=\"col-sm\">");

                        out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" ></iframe>");
                        out.println("<br>");
                        out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"occurrence" + i + "\">"+occurrence.getTreebankID()+" | "+ occurrence.getSentenceID() + " | "+ occurrence.getWordID() + " | " + "</label>");


                        out.println("</div>");
                        break;
                    }
                    case 1:
                    {
                        OccurrenceBean occurrence = occurrences.get(i);

                        String params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();


                        out.println("<div class=\"col-sm\">");

                        out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" ></iframe>");
                        out.println("<br>");
                        out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"occurrence" + i + "\">"+occurrence.getTreebankID()+" | "+ occurrence.getSentenceID() + " | "+ occurrence.getWordID() + " | " + "</label>");

                        out.println("</div>");
                        break;
                    }
                    case 2:
                    {
                        OccurrenceBean occurrence = occurrences.get(i);

                        String params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();


                        out.println("<div class=\"col-sm\">");

                        out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" ></iframe>");
                        out.println("<br>");
                        out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"occurrence" + i + "\">"+occurrence.getTreebankID()+" | "+ occurrence.getSentenceID() + " | "+ occurrence.getWordID() + " | " + "</label>");

                        out.println("</div>");

                        out.println("</div>");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if(((occurrences.size()-1) %3 != 2) && occurrences.size()<21)
            {
                out.println("</div>");
            }

        //</form>
        %>

    </div>


</body>
</html>

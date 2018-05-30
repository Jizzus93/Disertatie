<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.SentenceBean" %>
<%@ page import="bean.WordBean" %>
<%@ page import="bean.OccurrenceBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="bean.ExampleBundleBean" %><%--
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
    int patternId = Integer.parseInt(request.getParameter("patternId"));



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
    ArrayList<ExampleBundleBean> exampleBundles = gson.fromJson(jsonStr.toString() , new TypeToken<ArrayList<ExampleBundleBean>>(){}.getType());
    //
%>

<form action="exampleSave.jsp" method="post" target="_blank" >
    <input type="text" name="patternId" value="<%=patternId%>" hidden>
    <button style="position: fixed; margin-left: 80%">Add Selected Examples</button>
    <div class="container">

        <%

            for(int i=0; i< exampleBundles.size() && i<21; i++)
            {
                switch(i%2)
                {
                    case 0:
                    {
                        OccurrenceBean occurrence = exampleBundles.get(i).getOccurrences().get(0);

                        String params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();

                        String arguments = "";
                        for(String argument: exampleBundles.get(i).getArguments())
                        {
                            arguments += argument + " | ";
                        }

                        out.println("<div class=\"row\">");
                        out.println("<div class=\"col-sm\">");

                        out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" ></iframe>");
                        out.println("<br>");
                        out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"exampleBundle" + i + "\" value=\""+arguments+"\">" + arguments + exampleBundles.get(i).getOccurrences().size() + "</label>");


                        out.println("</div>");
                        break;
                    }
                    case 1:
                    {
                        OccurrenceBean occurrence = exampleBundles.get(i).getOccurrences().get(0);

                        String params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();

                        String arguments = "";
                        for(String argument: exampleBundles.get(i).getArguments())
                        {
                            arguments += argument + " | ";
                        }
                        out.println("<div class=\"col-sm\">");

                        out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" ></iframe>");
                        out.println("<br>");
                        out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"exampleBundle" + i + "\" value=\""+arguments+"\">"+arguments + exampleBundles.get(i).getOccurrences().size() + "</label>");

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
            if(((exampleBundles.size()-1) %2 != 1) && exampleBundles.size()<21)
            {
                out.println("</div>");
            }

        //
        %>
    </div>
</form>

</body>
</html>

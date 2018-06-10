<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.VerbPatternBean" %>
<%@ page import="bean.VerbEntityBean" %>
<%@ page import="bean.OccurrenceBean" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="bean.ExampleBundleBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.reflect.TypeToken" %><%--
  Created by IntelliJ IDEA.
  User: octak
  Date: 5/6/2018
  Time: 9:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String searchedVerb = request.getParameter("search");

    URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getWordOccurrences?word="+ URLEncoder.encode(searchedVerb, "UTF-8"));
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Accept", "application/json");

    if (conn.getResponseCode() != 200) {

        throw new RuntimeException("Failed : HTTP error code : "
                + conn.getResponseCode());
    }

    BufferedReader br = new BufferedReader(new InputStreamReader(
            (conn.getInputStream()), Charset.forName("UTF-8")));
    StringBuilder jsonStr = new StringBuilder();
    String output;
    while ((output = br.readLine()) != null) {
        jsonStr.append(output);
    }

    conn.disconnect();

    Gson gson = new Gson();
    ArrayList<ExampleBundleBean> exampleBundles = gson.fromJson(jsonStr.toString() , new TypeToken<ArrayList<ExampleBundleBean>>(){}.getType());

%>



<div class="container" style="width: 90%;">

    <header class="row" >
        <div class="col-md-4">
            <img style="width: 250px; height: 125px; border-width: 1px; border-color: black; " src="img/nlp_logo.png">
        </div>
        <div class="col-md-4" >
            <span class="font-weight-bold h1 text-center" > RODiA </span>
        </div>

        <form class="form-signin col-md-4">


            <label for="inputEmail" class="sr-only">Email address</label>
            <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required="" autofocus="">
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" class="form-control" placeholder="Password" required="">
            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me"> Remember me
                </label>
            </div>
            <button class="btn btn-sm btn-primary btn-block" type="submit">Sign in</button>

        </form>
    </header>
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
                    out.println("<div class=\"col-sm-6\">");

                    out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" width=\"100%\"></iframe>");
                    out.println("<br>");
                    out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"exampleBundle" + i + "\" value=\""+i+"\">" + arguments + exampleBundles.get(i).getOccurrences().size() + "</label>");


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
                    out.println("<div class=\"col-sm-6\">");

                    out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" width=\"100%\" ></iframe>");
                    out.println("<br>");
                    out.println("<label class=\"checkbox-inline\"><input type=\"checkbox\" name=\"exampleBundle" + i + "\" value=\""+i+"\">"+arguments + exampleBundles.get(i).getOccurrences().size() + "</label>");

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

</body>
</html>

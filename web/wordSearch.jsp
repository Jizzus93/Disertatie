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
<body background="img/background4.png">
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



<div class="container" style="width: 90%; height: 97%;">

    <header class="row" >
        <div class="col-md-4">
            <h1 style="margin-top: 20%;"><span style="font-size: 40px; background-color: #28a745;" class = "label"><%=searchedVerb%></span></h1>
        </div>
        <div class="col-md-4" >
            <br>
            <span class="font-weight-bold h1 text-center" style="padding-left: 20%;"> PDRoV </span>
        </div>

        <form class="form-signin col-md-4">
            <br>

            <label for="inputEmail" class="sr-only">Email address</label>
            <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required="" autofocus="">
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" class="form-control" placeholder="Password" required="">
            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me"> Remember me
                </label>
            </div>
            <button class="btn btn-sm btn-primary btn-block" type="submit" style="background-color: #28a745; border-color: #28a745">Sign in</button>

        </form>
    </header>




    <div class="row">
        <div class="tab-content col-md-10 ">

            <%
                for(int i= 0; i<exampleBundles.size(); i++)
                {
                    if(i==0)
                    {
                        out.println("<div id=\"preview_example"+(i+1)+"\" class=\"tab-pane fade in active\">");
                    }
                    else
                    {
                        out.println("<div id=\"preview_example"+(i+1)+"\" class=\"tab-pane fade\">");
                    }
                    OccurrenceBean occurrence = exampleBundles.get(i).getOccurrences().get(0);
                    String params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();


                    out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" width=\"100%\" height=\"81%\" frameBorder=\"0\"></iframe>");

                    out.println("</div>");

                }
            %>
        </div>
        <input type="hidden" name="word" value="searchedWord">
        <div class="col-md-2">
            <ul class="nav nav-pills nav-stacked">

                <%
                    if(exampleBundles.size()!=0)
                    {
                        String arguments = "";
                        for(String argument: exampleBundles.get(0).getArguments())
                        {
                            arguments += argument + " | ";
                        }
                        if(arguments.equals(""))
                        {
                            arguments = "None";
                        }

                        out.println("<li class=\"active\"><a data-toggle=\"tab\" href=\"#preview_example1\">"+ arguments +"</a></li>");
                        for(int i= 1; i<exampleBundles.size(); i++)
                        {
                            arguments = "";
                            for(String argument: exampleBundles.get(i).getArguments())
                            {
                                arguments += argument + " | ";
                            }
                            if(arguments.equals(""))
                            {
                                arguments = "None";
                            }
                            out.println("<li><a data-toggle=\"tab\" href=\"#preview_example" + (i+1) + "\">" + arguments + "</a></li>");
                        }
                    }


                %>
            </ul>
        </div>

        <div class="clearfix visible-lg"></div>
    </div>




</div>
<!-- Footer -->
<footer style="background-color:  #28a745;">


    <!-- Copyright -->
    <div class="footer-copyright text-center py-3">© 2018 Copyright:
        <a href="https://mdbootstrap.com/bootstrap-tutorial/"> MDBootstrap.com</a>
    </div>
    <!-- Copyright -->

</footer>
<!-- Footer -->

</body>
</html>

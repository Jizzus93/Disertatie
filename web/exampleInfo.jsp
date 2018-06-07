<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.SentenceBean" %>
<%@ page import="bean.WordBean" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: octak
  Date: 5/26/2018
  Time: 12:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String treebankId = request.getParameter("treebankId");
    String sentenceId = request.getParameter("sentenceId");

    int wordId = Integer.parseInt(request.getParameter("wordId"));

    String exampleType = request.getParameter("exampleType");



    URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getExample?treebankId=" + treebankId
                                                                                        + "&sentenceId=" + sentenceId
                                                                                        + "&wordId=" + wordId
                                                                                        + "&type="+ exampleType);
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
    SentenceBean sentence = gson.fromJson(jsonStr.toString() , SentenceBean.class);

    String text = "";
    for(WordBean w: sentence.getWordList())
    {
        text+= w.getForm() + " ";
    }

%>
<div class="container" style="width: 90%;">
    <div class="row">
        <p><%=text%></p>
    </div>
    <div class="row">
        <div class="col-md-10">
            <div id="lvl_up" class="tab-pane fade">
                <%
                    ArrayList<String> parentArguments = new ArrayList<String>();
                    parentArguments = sentence.getWordArguments(sentence.getWord(wordId).getHead());
                    String parentArgumentsString = "";
                    for(String s: parentArguments)
                    {
                        parentArgumentsString += s + " ";
                    }
                %>
                <p><%=parentArgumentsString%></p>
            </div>
        </div>
        <div class="col-md-2">
            <ul class="nav nav-pills nav-stacked">
                <li ><a data-toggle="tab" href="#lvl_up">Show lvlUp dependencies</a></li>
            </ul>
        </div>
    </div>


</div>
</body>
</html>

<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.VerbPatternInfoBean" %><%--
  Created by IntelliJ IDEA.
  User: octak
  Date: 5/14/2018
  Time: 7:13 PM
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
    String searchedVerb = request.getParameter("verb");
    int patternId = Integer.parseInt(request.getParameter("patternId"));

    URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getPatternInfo?verb="+ searchedVerb+"&patternId="+ patternId);
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
    VerbPatternInfoBean exampleInfoBean = gson.fromJson(jsonStr.toString(), VerbPatternInfoBean.class);
%>


<form>
    <%
        boolean isAuthenticated = true; //TODO: IMPLEMENT USERS
        String restrictions = "";
        for(String s : exampleInfoBean.getClassicRestrictions())
        {
            restrictions += s + " ";
        }

        String advancedArguments = "";
        for(String s : exampleInfoBean.getClassicAdvancedArguments())
        {
            advancedArguments += s + " ";
        }

        String advancedAdjuncts = "";
        for(String s : exampleInfoBean.getClassicAdvancedAdjuncts())
        {
            advancedAdjuncts += s + " ";
        }

        String arguments = "";
        for(String s : exampleInfoBean.getClassicArguments())
        {
            arguments += s + " ";
        }

        String adjuncts = "";
        for(String s : exampleInfoBean.getClassicAdjuncts())
        {
            adjuncts += s + " ";
        }

        String isReadOnly = "";
        String isHidden = "";
        if(!isAuthenticated)
        {
            isReadOnly = "readonly";
            isHidden = "hidden";
        }
    %>
        <h2>Dependencies:</h2>
        <div class="form-group-row">
            <label for="restrictions" class="col-sm-2 col-form-label">Restrictions:</label>
            <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="restrictions" value="<%=restrictions%>">
        </div>
        <div class="form-group-row">
            <label for="advanced_arguments" class="col-sm-2 col-form-label">Advanced Arguments:</label>
            <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="advanced_arguments" value="<%=advancedArguments%>">
        </div>
        <div class="form-group-row">
            <label for="advanced_adjuncts" class="col-sm-2 col-form-label">Advanced Adjuncts:</label>
            <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="advanced_adjuncts" value="<%=advancedAdjuncts%>">
        </div>
        <div class="form-group-row">
            <label for="arguments" class="col-sm-2 col-form-label">Arguments:</label>
            <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="arguments" value="<%=arguments%>">
        </div>
        <div class="form-group-row">
            <label for="adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
            <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="adjuncts" value="<%=adjuncts%>">
        </div>
        <button type="button" <%=isHidden%> >Save Changes</button>
    </form>
</body>
</html>
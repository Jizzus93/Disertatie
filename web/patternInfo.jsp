<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.VerbPatternInfoBean" %>
<%@ page import="bean.VerbPatternBean" %><%--
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
    int searchedVerb = Integer.parseInt(request.getParameter("verbId"));
    
    int patternId = Integer.parseInt(request.getParameter("patternId"));
    boolean isAuthenticated = (request.getParameter("add")=="true")?true:false; //TODO: IMPLEMENT USERS


    URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getPattern?verbId="+ searchedVerb+"&patternId="+ patternId );
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
    VerbPatternBean exampleInfoBean = gson.fromJson(jsonStr.toString(), VerbPatternBean.class);
%>



<%

    //TYPE
    String typeHead = "";
    typeHead = exampleInfoBean.getVerbPatternType().getHead();

    int typeId = 0;
    typeId = exampleInfoBean.getVerbPatternType().getId();

    String patternType = "";
    patternType = exampleInfoBean.getVerbPatternType().getPatternType();

    String syntacticType = "";
    syntacticType = exampleInfoBean.getVerbPatternType().getSyntacticType();
    //END TYPE

    //IMPLICATURES

    //END IMPLICATURES

    //CLASSIC
    String restrictions = "";
    for(String s : exampleInfoBean.getPatternInfo().getClassicRestrictions())
    {
        restrictions += s + " ";
    }

    String advancedArguments = "";
    for(String s : exampleInfoBean.getPatternInfo().getClassicAdvancedArguments())
    {
        advancedArguments += s + " ";
    }

    String advancedAdjuncts = "";
    for(String s : exampleInfoBean.getPatternInfo().getClassicAdvancedAdjuncts())
    {
        advancedAdjuncts += s + " ";
    }

    String arguments = "";
    for(String s : exampleInfoBean.getPatternInfo().getClassicArguments())
    {
        arguments += s + " ";
    }

    String adjuncts = "";
    for(String s : exampleInfoBean.getPatternInfo().getClassicAdjuncts())
    {
        adjuncts += s + " ";
    }
    //END CLASSIC

    //UD
    String udRestrictions = "";
    for(String s : exampleInfoBean.getPatternInfo().getUDRestrictions())
    {
        udRestrictions += s + " ";
    }

    String udAdvancedArguments = "";
    for(String s : exampleInfoBean.getPatternInfo().getUDAdvancedArguments())
    {
        udAdvancedArguments += s + " ";
    }

    String udAdvancedAdjuncts = "";
    for(String s : exampleInfoBean.getPatternInfo().getUDAdvancedAdjuncts())
    {
        udAdvancedAdjuncts += s + " ";
    }

    String udArguments = "";
    for(String s : exampleInfoBean.getPatternInfo().getUDArguments())
    {
        udArguments += s + " ";
    }

    String udAdjuncts = "";
    for(String s : exampleInfoBean.getPatternInfo().getUDAdjuncts())
    {
        udAdjuncts += s + " ";
    }
    //END UD

    //SEMANTIC
    String semanticRestrictions = "";
    for(String s : exampleInfoBean.getPatternInfo().getSemanticRestrictions())
    {
        semanticRestrictions += s + " ";
    }

    String semanticAdvancedArguments = "";
    for(String s : exampleInfoBean.getPatternInfo().getSemanticAdvancedArguments())
    {
        semanticAdvancedArguments += s + " ";
    }

    String semanticAdvancedAdjuncts = "";
    for(String s : exampleInfoBean.getPatternInfo().getSemanticAdvancedAdjuncts())
    {
        semanticAdvancedAdjuncts += s + " ";
    }

    String semanticArguments = "";
    for(String s : exampleInfoBean.getPatternInfo().getSemanticArguments())
    {
        semanticArguments += s + " ";
    }

    String semanticAdjuncts = "";
    for(String s : exampleInfoBean.getPatternInfo().getSemanticAdjuncts())
    {
        semanticAdjuncts += s + " ";
    }
    //END SEMANTIC

    String isReadOnly = "";
    String isHidden = "";
    if(!isAuthenticated)
    {
        isReadOnly = "readonly";
        isHidden = "hidden";
    }
%>

<form>
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#layer1">Layer1<br>Classical<br>Syntactic</a></li>
        <li><a data-toggle="tab" href="#layer2">Layer2<br>UD<br>Syntactic</a></li>
        <li><a data-toggle="tab" href="#layer3"><br>Layer3<br>Semantic</a></li>
    </ul>
    <div class="tab-content">
        <div id="layer1" class="tab-pane fade in active">

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
            <div class="form-group-row">
                <label for="adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="adjuncts" value="<%=adjuncts%>">
            </div>
        </div>

        <div id="layer2" class="tab-pane fade">

            <form>
                <h2>Dependencies:</h2>
                <div class="form-group-row">
                    <label for="ud_restrictions" class="col-sm-2 col-form-label">Restrictions:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_restrictions" value="<%=udRestrictions%>">
                </div>
                <div class="form-group-row">
                    <label for="ud_advanced_arguments" class="col-sm-2 col-form-label">Advanced Arguments:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_advanced_arguments" value="<%=udAdvancedArguments%>">
                </div>
                <div class="form-group-row">
                    <label for="ud_advanced_adjuncts" class="col-sm-2 col-form-label">Advanced Adjuncts:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_advanced_adjuncts" value="<%=udAdvancedAdjuncts%>">
                </div>
                <div class="form-group-row">
                    <label for="ud_arguments" class="col-sm-2 col-form-label">Arguments:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_arguments" value="<%=udArguments%>">
                </div>
                <div class="form-group-row">
                    <label for="ud_adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_adjuncts" value="<%=udAdjuncts%>">
                </div>
            </form>
        </div>

        <div id="layer3" class="tab-pane fade">

            <form>
                <h2>Dependencies:</h2>
                <div class="form-group-row">
                    <label for="semantic_restrictions" class="col-sm-2 col-form-label">Restrictions:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_restrictions" value="<%=semanticRestrictions%>">
                </div>
                <div class="form-group-row">
                    <label for="semantic_advanced_arguments" class="col-sm-2 col-form-label">Advanced Arguments:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_advanced_arguments" value="<%=semanticAdvancedArguments%>">
                </div>
                <div class="form-group-row">
                    <label for="semantic_advanced_adjuncts" class="col-sm-2 col-form-label">Advanced Adjuncts:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_advanced_adjuncts" value="<%=semanticAdvancedAdjuncts%>">
                </div>
                <div class="form-group-row">
                    <label for="semantic_arguments" class="col-sm-2 col-form-label">Arguments:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_arguments" value="<%=semanticArguments%>">
                </div>
                <div class="form-group-row">
                    <label for="semantic_adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
                    <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_adjuncts" value="<%=semanticAdjuncts%>">
                </div>

            </form>
        </div>

    </div>
    <button type="button" <%=isHidden%> >Save Changes</button>
</form>
</body>
</html>
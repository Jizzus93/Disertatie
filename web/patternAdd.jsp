<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.VerbPatternInfoBean" %>
<%@ page import="bean.VerbPatternBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.OccurrenceBean" %><%--
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

%>



<%
    //GENERAL
    String form_ro = "";

    String form_en = "";

    String pwn = "";


    //END GENERAL

    //TYPE
    String typeHead = "";


    int typeId = 0;


    String patternType = "";

    String syntacticType = "";
    //END TYPE

    //IMPLICATURES


    String implicaturesString = "";


    //END IMPLICATURES

    //CLASSIC
    String restrictions = "";

    String advancedArguments = "";

    String advancedAdjuncts = "";

    String arguments = "";

    String adjuncts = "";
    //END CLASSIC

    //UD
    String udRestrictions = "";

    String udAdvancedArguments = "";

    String udAdvancedAdjuncts = "";

    String udArguments = "";

    String udAdjuncts = "";
    //END UD

    //SEMANTIC
    String semanticRestrictions = "";

    String semanticAdvancedArguments = "";

    String semanticAdvancedAdjuncts = "";

    String semanticArguments = "";

    String semanticAdjuncts = "";
    //END SEMANTIC

    //EXAMPLES
    //END EXAMPLES


    String isReadOnly = "";
    String isHidden = "";

%>

<form action="patternSave.jsp" method="post" target="_blank" style="margin-right: 200px;">

    <h2>General Info:</h2>
    <div class="form-group-row">
        <label for="pattern_id" class="col-sm-2 col-form-label">Pattern Id:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="pattern_id" name="pattern_id" value="<%=patternId%>">
        <input type="text" hidden class="form-control-plaintext" id="verb_id" name="verb_id" value="<%=searchedVerb%>">
    </div>
    <div class="form-group-row">
        <label for="pattern_form_ro" class="col-sm-2 col-form-label">Form RO:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="pattern_form_ro" name="pattern_form_ro" value="<%=form_ro%>">
    </div>
    <div class="form-group-row">
        <label for="pattern_form_en" class="col-sm-2 col-form-label">Form EN:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="pattern_form_en" name="pattern_form_en" value="<%=form_en%>">
    </div>
    <div class="form-group-row">
        <label for="pattern_pwn" class="col-sm-2 col-form-label">PWN:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="pattern_pwn" name="pattern_pwn" value="<%=pwn%>">
    </div>



    <h2>Type:</h2>
    <div class="form-group-row">
        <label for="type_id" class="col-sm-2 col-form-label">Type Id:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="type_id" name="type_id" value="<%=typeId%>">
    </div>
    <div class="form-group-row">
        <label for="type_pattern_type" class="col-sm-2 col-form-label">Pattern Type:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="type_pattern_type" name="type_pattern_type" value="<%=patternType%>">
    </div>
    <div class="form-group-row">
        <label for="type_syntactic_type" class="col-sm-2 col-form-label">Syntactic Type:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="type_syntactic_type" name="type_syntactic_type" value="<%=syntacticType%>">
    </div>
    <div class="form-group-row">
        <label for="type_head" class="col-sm-2 col-form-label">Head:</label>
        <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="type_head" name="type_head" value="<%=typeHead%>">
    </div>


    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#layer1">Layer1<br>Classical<br>Syntactic</a></li>
        <li><a data-toggle="tab" href="#layer2">Layer2<br>UD<br>Syntactic</a></li>
        <li><a data-toggle="tab" href="#layer3"><br>Layer3<br>Semantic</a></li>
    </ul>
    <div class="tab-content">
        <div id="layer1" class="tab-pane fade in active">

            <h2>Dependencies:</h2>
            <div class="form-group-row">
                <label for="classic_restrictions" class="col-sm-2 col-form-label">Restrictions:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="classic_restrictions" name="classic_restrictions" value="<%=restrictions%>">
            </div>
            <div class="form-group-row">
                <label for="classic_advanced_arguments" class="col-sm-2 col-form-label">Advanced Arguments:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="classic_advanced_arguments" name="classic_advanced_arguments" value="<%=advancedArguments%>">
            </div>
            <div class="form-group-row">
                <label for="classic_advanced_adjuncts" class="col-sm-2 col-form-label">Advanced Adjuncts:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="classic_advanced_adjuncts" name="classic_advanced_adjuncts" value="<%=advancedAdjuncts%>">
            </div>
            <div class="form-group-row">
                <label for="classic_arguments" class="col-sm-2 col-form-label">Arguments:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="classic_arguments" name="classic_arguments" value="<%=arguments%>">
            </div>
            <div class="form-group-row">
                <label for="classic_adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="classic_adjuncts" name="classic_adjuncts" value="<%=adjuncts%>">
            </div>
        </div>

        <div id="layer2" class="tab-pane fade">


            <h2>Dependencies:</h2>
            <div class="form-group-row">
                <label for="ud_restrictions" class="col-sm-2 col-form-label">Restrictions:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_restrictions" name="ud_restrictions" value="<%=udRestrictions%>">
            </div>
            <div class="form-group-row">
                <label for="ud_advanced_arguments" class="col-sm-2 col-form-label">Advanced Arguments:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_advanced_arguments" name="ud_advanced_arguments" value="<%=udAdvancedArguments%>">
            </div>
            <div class="form-group-row">
                <label for="ud_advanced_adjuncts" class="col-sm-2 col-form-label">Advanced Adjuncts:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_advanced_adjuncts" name="ud_advanced_adjuncts" value="<%=udAdvancedAdjuncts%>">
            </div>
            <div class="form-group-row">
                <label for="ud_arguments" class="col-sm-2 col-form-label">Arguments:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_arguments" name="ud_arguments" value="<%=udArguments%>">
            </div>
            <div class="form-group-row">
                <label for="ud_adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="ud_adjuncts" name="ud_adjuncts" value="<%=udAdjuncts%>">
            </div>

        </div>

        <div id="layer3" class="tab-pane fade">


            <h2>Dependencies:</h2>
            <div class="form-group-row">
                <label for="semantic_restrictions" class="col-sm-2 col-form-label">Restrictions:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_restrictions" name="semantic_restrictions" value="<%=semanticRestrictions%>">
            </div>
            <div class="form-group-row">
                <label for="semantic_advanced_arguments" class="col-sm-2 col-form-label">Advanced Arguments:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_advanced_arguments" name="semantic_advanced_arguments" value="<%=semanticAdvancedArguments%>">
            </div>
            <div class="form-group-row">
                <label for="semantic_advanced_adjuncts" class="col-sm-2 col-form-label">Advanced Adjuncts:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_advanced_adjuncts" name="semantic_advanced_adjuncts" value="<%=semanticAdvancedAdjuncts%>">
            </div>
            <div class="form-group-row">
                <label for="semantic_arguments" class="col-sm-2 col-form-label">Arguments:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_arguments" name="semantic_arguments" value="<%=semanticArguments%>">
            </div>
            <div class="form-group-row">
                <label for="semantic_adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
                <input type="text" <%=isReadOnly%> class="form-control-plaintext" id="semantic_adjuncts" name="semantic_adjuncts" value="<%=semanticAdjuncts%>">
            </div>


        </div>
    </div>

    <div class="form-group-row">
        <label for="implicatures" class="col-sm-2 col-form-label">Implicatures:</label>
        <textarea <%=isReadOnly%> class="form-control" id="implicatures" name="implicatures" value=""><%=implicaturesString%></textarea>
    </div>




    <button <%=isHidden%> >Save Changes</button>
</form>
</body>
</html>
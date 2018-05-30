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

    boolean isAuthenticated = (request.getParameter("add").equals("true"))?true:false; //TODO: IMPLEMENT USERS


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
    //GENERAL
    String form_ro = "";
    form_ro = exampleInfoBean.getForm_ro();
    String form_en = "";
    form_en = exampleInfoBean.getForm_en();
    String pwn = "";
    pwn = exampleInfoBean.getPWN();

    //END GENERAL

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

    ArrayList<String> implicatures = new ArrayList<String>();
    implicatures = exampleInfoBean.getImplicatures();
    String implicaturesString = "";
    for(String s: implicatures)
    {
        implicaturesString += s + "\n";
    }

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

    //EXAMPLES
    ArrayList<OccurrenceBean> occurrences = exampleInfoBean.getExamples();
    //END EXAMPLES


    String isReadOnly = "";
    String isHidden = "";
    if(!isAuthenticated)
    {
        isReadOnly = "readonly";
        isHidden = "hidden";
    }
%>

<form action="patternSave.jsp" method="post" target="_blank" >

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

    <ul class="nav nav-tabs">
        <%
            if(exampleInfoBean.getExamplesNumber() == 0)
            {
                out.println("<li class=\"active\"><a data-toggle=\"tab\" href=\"#add_example\">Add Example</a></li>");
            }
            else
            {
                out.println("<li class=\"active\"><a data-toggle=\"tab\" href=\"#example_1\">1</a></li>");
                for(int i=2; i<=exampleInfoBean.getExamplesNumber(); i++)
                {
                    out.println("<li><a data-toggle=\"tab\" href=\"#example_" + i + "\">" + i + "</a></li>");
                }
                out.println("<li><a data-toggle=\"tab\" href=\"#add_example\">Add Example</a></li>");
            }
        %>

    </ul>

    <div class="form-group-row">
        <div class="tab-content">
            <%
                if(exampleInfoBean.getExamplesNumber() <= 0)
                {
                    out.println("<div id=\"add_example\" class=\"tab-pane fade in active\">");
                    out.println("<iframe src=\"addExample.jsp?verb="+exampleInfoBean.getForm_ro().toLowerCase()+ "&patternId="+ patternId +"\" width=\"100%\" height=\"60%\"></iframe>");
                    out.println("</div>");
                }
                else
                {
                    OccurrenceBean occurrence = occurrences.get(0);
                    String params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();
                    out.println("<div id=\"example_1\" class=\"tab-pane fade in active\">");
                    out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" width=\"100%\" height=\"60%\"></iframe>");
                    out.println("</div>");
                    for(int i=2; i<=exampleInfoBean.getExamplesNumber(); i++)
                    {
                        occurrence = occurrences.get(i-1);
                        params = "treebankId=" + occurrence.getTreebankID() + "&sentenceId=" + occurrence.getSentenceID() + "&wordId=" + occurrence.getWordID() + "&exampleType=" + occurrence.getOccurrenceType();
                        out.println("<div id=\"example_" + i + "\" class=\"tab-pane fade\">");
                        out.println("<iframe src=\"exampleInfo.jsp?"+params+"\" width=\"100%\" height=\"60%\"></iframe>");
                        out.println("</div>");
                    }
                    out.println("<div id=\"add_example\" class=\"tab-pane fade\">");
                    out.println("<iframe src=\"addExample.jsp?verb="+exampleInfoBean.getForm_ro().toLowerCase()+ "&patternId="+ patternId +"\" width=\"100%\" height=\"60%\"></iframe>");
                    out.println("</div>");
                }
            %>
        </div>

    </div>



    <button <%=isHidden%> >Save Changes</button>
    </form>
</body>
</html>
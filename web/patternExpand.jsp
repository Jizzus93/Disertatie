<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.VerbPatternExampleInfoBean" %>
<%@ page import="bean.WordBean" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: octak
  Date: 5/6/2018
  Time: 5:00 PM
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
    String searchedVerb = request.getParameter("verb");
    int patternId = Integer.parseInt(request.getParameter("patternId"));
    int exampleId = Integer.parseInt(request.getParameter("exampleId"));
    URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getPatternInfo?verb="+ searchedVerb+"&patternId="+ patternId+"&exampleId="+ exampleId);
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
    VerbPatternExampleInfoBean exampleInfoBean = gson.fromJson(jsonStr.toString(), VerbPatternExampleInfoBean.class);
%>

<div class="container">

    <header class=" container-fluid row" >
        <img class="col-md-4" style="width: 250px; height: 125px; border-width: 1px; border-color: black; " src="img/nlp_logo.png">

        <div class="col-md-4 text-center" >
            <span class="font-weight-bold h1" > PDRoV </span>
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
    <br>
    <br>
    <div class="row">
        <div class="col-md-5 ">
            <h1 ><span style="font-size: 40px" class = "label label-warning"><%=searchedVerb%></span></h1>
        </div>
        <div class="col-md-3">
            <h4>EN</h4>
            <h4><%=searchedVerb%></h4>
            <h2>PatternId: <%=patternId+1%></h2>
        </div>
        <div class="col-md-2">
            <button>RoWN</button>
        </div>
        <div class="col-md-2">
            <button>VerbNet</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 ">
        <h3>Dependencies</h3>
            <%
                out.println("<p>Restrictions: <span class=\"font-weight-bold\">ASK WHERE TO GET THIS</span> </p");
                out.println("<p>Advanced_arguments: <span class=\"font-weight-bold\">ASK WHERE TO GET THIS</span> </p");
                out.println("<p>Advanced_adjuncts: <span class=\"font-weight-bold\">ASK WHERE TO GET THIS</span> </p");

                String arguments = "";
                for(String s : exampleInfoBean.getArguments())
                {
                    arguments += s + " ";
                }
                out.println("<p>Arguments: <span class=\"font-weight-bold\">" + arguments + "</span></p>");

                String adjuncts = "";
                for(String s : exampleInfoBean.getAdjuncts())
                {
                    adjuncts += s + " ";
                }
                out.println("<p>Adjuncts: <span class=\"font-weight-bold\">" + adjuncts + "</span></p>");


                out.println("<h3>Statistics</h3>");
                out.println("<p>Occurrence Rate: </p>");

            %>
        </div>
        <div class="col-md-6 ">
            <h3>CurrentExampleInfo</h3>
            <%
                out.println("<p>CurrentExampleId: <span class=\"font-weight-bold\">"+(exampleId+1)+"</span> </p");
                out.println("<p>Sub-Corpus: <span class=\"font-weight-bold\">ADD OCCURRENCE INFO TO SENTENCE</span> </p");
                out.println("<p>Sentence id: <span class=\"font-weight-bold\">"+exampleInfoBean.getExampleSentence().getID()+"</span> </p");

                out.println("<p>Annotator: <span class=\"font-weight-bold\">"+exampleInfoBean.getExampleSentence().getUser()+"</span> </p");
                out.println("<p>Date: <span class=\"font-weight-bold\">"+exampleInfoBean.getExampleSentence().getDate()+"</span> </p");
                out.println("<p>Parser: <span class=\"font-weight-bold\">"+exampleInfoBean.getExampleSentence().getParser()+"</span> </p");

                out.println("<h4>Examples</h4>");
                String examples = "";
                for(int j=0; j< exampleInfoBean.getExamplesNumber(); j++)
                {
                    examples += "<a href=\"patternExpand.jsp?verb="+searchedVerb+"&patternId="+patternId+"&exampleId="+j+"\">" + (j+1) + "</a> ";
                    if(j == 12)
                    {
                        examples += "<br>";
                    }
                    if(j>20)
                    {
                        examples += "<span>...</span>";
                        break;
                    }
                }
                out.println("<p>" + examples + "</p>");
            %>
        </div>
    </div>

    <div class="row">
        <table class="table">
            <tbody>
            <tr>
                <th scope="row">Form:</th>
                <%
                    ArrayList<WordBean> wordList = exampleInfoBean.getExampleSentence().getWordList();
                    for(WordBean w: wordList)
                    {
                        out.println("<td>" + w.getForm() + "</td>");
                    }
                %>

            </tr>
            <tr>
                <th scope="row">POSTag:</th>
                <%
                    for(WordBean w: wordList)
                    {
                        out.println("<td>" + w.getPOSTag() + "</td>");
                    }
                %>

            </tr>

            </tbody>
        </table>

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse2">Collapsible panel</a>
                    </h4>
                </div>

                <div id="collapse2" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table>
                            <tbody>
                            <tr>
                                <th scope="row">DepRel:</th>
                                <%
                                    for(WordBean w: wordList)
                                    {
                                        out.println("<td>" + w.getDepRel() + "</td>");
                                    }
                                %>

                            </tr>
                            <tr>
                                <th scope="row">Head:</th>
                                <%
                                    for(WordBean w: wordList)
                                    {
                                        out.println("<td>" + w.getHead() + "</td>");
                                    }
                                %>

                            </tr>
                            <tr>
                                <th scope="row">Lemma:</th>
                                <%
                                    for(WordBean w: wordList)
                                    {
                                        out.println("<td>" + w.getLemma() + "</td>");
                                    }
                                %>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>


    </div>

    <div class="row align-content-center">
        <img class="border-dark"
        <source src="http://localhost:8080/Backend_war_exploded/searchEngine/getImageResource?graphicsInfo="+<%=exampleInfoBean.getGraphicRepresentationPath()%>> type="PNG">
        <p><%=exampleInfoBean.getGraphicRepresentationPath()%></p>
    </div>
</div>


</body>
</html>

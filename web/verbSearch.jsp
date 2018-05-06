<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.VerbPatternBean" %>
<%@ page import="bean.VerbEntityBean" %><%--
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
        String searchedVerb = request.getParameter("search");
        URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/search?word="+searchedVerb);
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
        VerbEntityBean verbEntitiy = gson.fromJson(jsonStr.toString(), VerbEntityBean.class);
        //TODO: HANDLE THE CASE WHERE THE WORD ISN'T IN THE DATABASE

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
            </div>
            <div class="col-md-2">
                <button>RoWN</button>
            </div>
            <div class="col-md-2">
                <button>VerbNet</button>
            </div>
        </div>


        <div class="tab-content">
            <div id="layer1" class="tab-pane fade in active">
                <div class="row">
                    <div class="tab-content col-md-8 ">
                        <%
                            for(int i= 0; i<verbEntitiy.getPatterns().size(); i++)
                            {
                                if(i==0)
                                {
                                    out.println("<div id=\"preview_pattern"+(i+1)+"\" class=\"tab-pane fade in active\">");
                                }
                                else
                                {
                                    out.println("<div id=\"preview_pattern"+(i+1)+"\" class=\"tab-pane fade\">");
                                }

                                out.println("<h4>Preview</h4>");
                                String arguments = "";
                                for(String s : verbEntitiy.getPatterns().get(i).getArguments())
                                {
                                    arguments += s + " ";
                                }
                                out.println("<p>Arguments: " + arguments + "</p>");

                                String adjuncts = "";
                                for(String s : verbEntitiy.getPatterns().get(i).getAdjuncts())
                                {
                                    adjuncts += s + " ";
                                }
                                out.println("<p>Adjuncts: " + adjuncts + "</p>");
                                out.println("<h4>Statistics</h4>");
                                out.println("<p>Occurrence Rate: </p>");
                                out.println("<form action=\"patternExpand.jsp\" method=\"get\" align=\"right\">");
                                out.println("<input type=\"hidden\" name=\"word\" value=\""+searchedVerb+"\">");
                                out.println("<input type=\"hidden\" name=\"patternId\" value=\""+i+"\">");
                                out.println("<button >More...</button>");
                                out.println("</form>");
                                out.println("</div>");

                            }
                        %>

                    </div>
                    <input type="hidden" name="word" value="searchedWord">
                    <div class="col-md-4">
                        <ul class="nav nav-pills nav-stacked">
                            <%
                                if(verbEntitiy.getPatterns().size()!=0)
                                {
                                    out.println("<li class=\"active\"><a data-toggle=\"tab\" href=\"#preview_pattern1\">Pattern 1</a></li>");
                                }

                                for(int i= 1; i<verbEntitiy.getPatterns().size(); i++)
                                {
                                    out.println("<li><a data-toggle=\"tab\" href=\"#preview_pattern" + (i+1) + "\">Pattern " + (i+1) + "</a></li>");
                                }
                            %>
                        </ul>
                    </div>

                    <div class="clearfix visible-lg"></div>
                </div>
            </div>
            <div id="layer2" class="tab-pane fade">
                <h3>Menu 1</h3>
                <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
            </div>
            <div id="layer3" class="tab-pane fade">
                <h3>Menu 2</h3>
                <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
            </div>
        </div>
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#layer1">Layer1<br>Classical<br>Syntactic</a></li>
            <li><a data-toggle="tab" href="#layer2">Layer2<br>UD<br>Syntactic</a></li>
            <li><a data-toggle="tab" href="#layer3"><br>Layer3<br>Semantic</a></li>
        </ul>
    </div>

</body>
</html>

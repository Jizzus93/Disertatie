<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="bean.VerbPatternBean" %>
<%@ page import="bean.VerbEntityBean" %>
<%@ page import="bean.OccurrenceBean" %><%--
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



        <div class="row">
            <div class="tab-content col-md-10 ">

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
                        String getValue = "?verbId="+verbEntitiy.getId()+"&patternId="+ (i+1) +"&add=true";
                        //<jsp:include page="patternInfo.jsp?verb=arde&patternId=0" flush="true"></jsp:include>
                        //http://localhost:8080/JSPPlayground3_war_exploded/
                        out.println("<iframe src=\"patternInfo.jsp"+getValue+"\" width=\"100%\" height=\"60%\"></iframe>");

                        out.println("</div>");

                    }
                %>
                <div id="add_pattern" class="tab-pane fade<%=(verbEntitiy.getPatterns().size()==0)?"in active":""%>">
                    <iframe src="patternAdd.jsp?verbId=<%=verbEntitiy.getId()%>&patternId=<%=(verbEntitiy.getPatterns().size()+1)%>&verb=<%=searchedVerb%>" width="100%" height="60%"></iframe>
                </div>

            </div>
            <input type="hidden" name="word" value="searchedWord">
            <div class="col-md-2">
                <ul class="nav nav-pills nav-stacked">

                    <%
                        if(verbEntitiy.getPatterns().size()!=0)
                        {
                            out.println("<li ><a data-toggle=\"tab\" href=\"#add_pattern\">Add Pattern</a></li>");
                            out.println("<li class=\"active\"><a data-toggle=\"tab\" href=\"#preview_pattern1\">Pattern 1</a></li>");
                        }
                        else
                        {
                            out.println("<li class=\"active\"><a data-toggle=\"tab\" href=\"#add_pattern\">Add Pattern</a></li>");
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

</body>
</html>

<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.nio.charset.Charset" %><%--
  Created by IntelliJ IDEA.
  User: uidp9046
  Date: 4/10/18
  Time: 2:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <head>
    <title>$Title$</title>
      <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
  </head>
  <body>

  <%

      URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getRoPAASVerbs");
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
      ArrayList<String> RoPAAS_verbs = gson.fromJson(jsonStr.toString(), new TypeToken<ArrayList<String>>(){}.getType());


      url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/getDeltaTreebankVerbs");
      conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");
      conn.setRequestProperty("Accept", "application/json");

      if (conn.getResponseCode() != 200) {

          throw new RuntimeException("Failed : HTTP error code : "
                  + conn.getResponseCode());
      }

       br = new BufferedReader(new InputStreamReader(
              (conn.getInputStream()), Charset.forName("UTF-8")));
      jsonStr = new StringBuilder();

      while ((output = br.readLine()) != null) {
          jsonStr.append(output);
      }

      conn.disconnect();

      gson = new Gson();
      ArrayList<String> deltaTreebank_verbs = gson.fromJson(jsonStr.toString(), new TypeToken<ArrayList<String>>(){}.getType());

  %>

  <div class="container" >
      <header class=" container-fluid row" >
          <img class="col-md-4"  src="img/nlp_logo.png">

          <div class="col-md-4 text-center " >
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
          <form class="text-center" action="verbSearch.jsp" method="get" style="width: 100%" >
              Search <input type="text" name="search" style="width: 45%;"/><br/>
              <button>Search!</button>

          </form>
        </div>
      <div class="row">
          <div class="col-sm">
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in RoPAAS</h3>
                  <h5 class="text-center"> <%=RoPAAS_verbs.size()%></h5>
                  <select class="text-center" size="5" name="search" style="width: 100%">
                    <%
                        for(String s: RoPAAS_verbs)
                        {
                            out.println("<option value=\""+s+"\">"+s+"</a></option>");
                        }
                    %>
                  </select>
                  <button>GO</button>
              </form>
          </div>
          <div class="col-sm">
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in TreeBank</h3>
                  <h5 class="text-center"> <%=deltaTreebank_verbs.size()%></h5>
                  <select class="text-center" size="5" name="search" style="width: 100%">
                      <%
                          for(String s: deltaTreebank_verbs)
                          {
                              out.println("<option value=\""+s+"\">"+s+"</option>");
                          }
                      %>
                  </select>
                  <button>GO</button>
              </form>
          </div>
          <div class="col-sm">
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in TreeBank</h3>
                  <h5 class="text-center"> <%=deltaTreebank_verbs.size()%></h5>
                  <select class="text-center" size="5" name="search" style="width: 100%">
                      <%
                          for(String s: deltaTreebank_verbs)
                          {
                              out.println("<option value=\""+s+"\">"+s+"</option>");
                          }
                      %>
                  </select>
              </form>
          </div>
          <div class="col-sm">
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in TreeBank</h3>
                  <h5 class="text-center"> <%=deltaTreebank_verbs.size()%></h5>
                  <select class="text-center" size="5" name="search" style="width: 100%">
                      <%
                          for(String s: deltaTreebank_verbs)
                          {
                              out.println("<option value=\""+s+"\">"+s+"</option>");
                          }
                      %>
                  </select>
              </form>
          </div>

      </div>

  </div>





  </body>
</html>

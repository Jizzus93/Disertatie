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
      <link rel="stylesheet" href="css/bootstrap.min.css">
  </head>
  <body background="img/background3.png">

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

  <div class="container" style="width: 90%; height: 97%">
      <header class="row" >
          <div class="col-md-4">
              <img style="width: 350px; height: 160px; border-width: 1px; border-color: black; " src="img/nlp_logo.png">
          </div>
          <div class="col-md-4" >

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
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <br>
      <div class="row align-content-center">

          <form class="text-center" action="verbSearch.jsp" method="get" style="width: 100%" >
              <span class="font-weight-bold h1" style="padding-left: 5%;">PDRoV </span> <span class="font-weight-bold h3" ><a href="roDiaHome.jsp" style="color: #28a745;">RODiA</a></span> <br><br>
              <input type="text" name="search" style="width: 45%;"/><br/>
              <button class="btn  btn-primary " type="submit" style="background-color: #28a745; border-color: #28a745; margin-top: 10px;">Search!</button>
          </form>
      </div>
      <br>
      <br>
      <br>
      <br>
      <div class="row">
          <div class="col-md-3">
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in RoPAAS</h3>
                  <h5 class="text-center"> <%=RoPAAS_verbs.size()%></h5>
                  <select class="text-center" size="9" name="search" style="width: 100%">
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
          <div class="col-md-3">
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in TreeBank</h3>
                  <h5 class="text-center"> <%=deltaTreebank_verbs.size()%></h5>
                  <select class="text-center" size="9" name="search" style="width: 100%">
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
          <div class="col-md-3">
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in TreeBank</h3>
                  <h5 class="text-center"> <%=deltaTreebank_verbs.size()%></h5>
                  <select class="text-center" size="9" name="search" style="width: 100%">
                      <%
                          for(String s: deltaTreebank_verbs)
                          {
                              out.println("<option value=\""+s+"\">"+s+"</option>");
                          }
                      %>
                  </select>
              </form>
          </div>
          <div class="col-md-3" >
              <form action="verbSearch.jsp" method="get">
                  <h3 class="text-center"> List of verbs in TreeBank</h3>
                  <h5 class="text-center"> <%=deltaTreebank_verbs.size()%></h5>
                  <select class="text-center" size="9" name="search" style="width: 100%">
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

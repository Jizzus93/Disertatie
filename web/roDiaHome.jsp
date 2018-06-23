<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="bean.ExampleBundleBean" %><%--
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
<body background="img/background3.png" >

<%



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

        <form class="text-center" action="wordSearch.jsp" method="get" style="width: 100%" >
            <span class="font-weight-bold h1" style="padding-left: 5%;"> RODiA </span> <span class="font-weight-bold h3" ><a href="index.jsp" style="color: #28a745;"> PDRoV </a></span> <br><br>
            <input type="text" name="search" style="width: 45%;"/><br/>
            <button class="btn  btn-primary " type="submit" style="background-color: #28a745; border-color: #28a745; margin-top: 10px;">Search!</button>

        </form>
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

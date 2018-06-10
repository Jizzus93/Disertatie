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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>

<%



%>

<div class="container" style="width: 90%;">
    <header class="row" >
        <div class="col-md-4">
            <img style="width: 250px; height: 125px; border-width: 1px; border-color: black; " src="img/nlp_logo.png">
        </div>
        <div class="col-md-4" >

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
    <br>
    <br>
    <br>
    <div class="row align-content-center">

        <form class="text-center" action="wordSearch.jsp" method="get" style="width: 100%" >
            <span class="font-weight-bold h1" > RODiA </span> <span class="font-weight-bold h3" ><a href="index.jsp"> PDRoV </a></span> <br><br>
            Search <input type="text" name="search" style="width: 45%;"/><br/>
            <button>Search!</button>

        </form>
    </div>



</div>





</body>
</html>

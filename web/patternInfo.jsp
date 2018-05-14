<%--
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
    <form>
        <div class="form-group-row">
            <label for="restrictions" class="col-sm-2 col-form-label">Restrictions:</label>
            <input type="text" readonly class="form-control-plaintext" id="restrictions" value="some value">
        </div>
        <div class="form-group-row">
            <label for="advanced_arguments" class="col-sm-2 col-form-label">Advanced Arguments:</label>
            <input type="text" readonly class="form-control-plaintext" id="advanced_arguments" value="some value">
        </div>
        <div class="form-group-row">
            <label for="advanced_adjuncts" class="col-sm-2 col-form-label">Advanced Adjuncts:</label>
            <input type="text" readonly class="form-control-plaintext" id="advanced_adjuncts" value="some value">
        </div>
        <div class="form-group-row">
            <label for="arguments" class="col-sm-2 col-form-label">Arguments:</label>
            <input type="text" readonly class="form-control-plaintext" id="arguments" value="some value">
        </div>
        <div class="form-group-row">
            <label for="adjuncts" class="col-sm-2 col-form-label">Adjuncts:</label>
            <input type="text" readonly class="form-control-plaintext" id="adjuncts" value="some value">
        </div>
    </form>
</body>
</html>
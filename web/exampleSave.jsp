<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ExampleBundleBean" %><%--
  Created by IntelliJ IDEA.
  User: octak
  Date: 5/30/2018
  Time: 9:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Enumeration paramNames = request.getParameterNames();
    int patternId = -1;
    ArrayList<String> arguments = new ArrayList<String>();
    while(paramNames.hasMoreElements())
    {
        String paramName = (String)paramNames.nextElement();
        out.print("<tr><td>" + paramName + "</td>\n");
        if(paramName.equals("patternId"))
        {
            patternId = Integer.parseInt(request.getParameter(paramName));
        }

        if(paramName.contains("exampleBundle"))
        {
            arguments.add(request.getParameter(paramName));
        }
        String paramValue = request.getParameter(paramName);
        out.println("<td> " + paramValue + "</td></tr>\n");
    }

    if(patternId != -1 && !arguments.isEmpty())
    {
        for(String s: arguments)
        {

        }
    }
%>

</body>
</html>

<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ExampleBundleBean" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.net.URLEncoder" %><%--
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
    request.setCharacterEncoding("UTF-8");
    Enumeration paramNames = request.getParameterNames();
    int patternId = -1;
    String verb = "";
    ArrayList<Integer> arguments = new ArrayList<Integer>();

    while(paramNames.hasMoreElements())
    {
        String paramName = (String)paramNames.nextElement();
        out.print("<tr><td>" + paramName + "</td>\n");
        if(paramName.equals("patternId"))
        {
            patternId = Integer.parseInt(request.getParameter(paramName));
        }

        if(paramName.equals("verb"))
        {
            verb = request.getParameter(paramName);
        }

        if(paramName.contains("exampleBundle"))
        {
            arguments.add(Integer.parseInt(request.getParameter(paramName)));
        }
        String paramValue = request.getParameter(paramName);
        out.println("<td> " + paramValue + "</td></tr>\n");
    }
    out.println(patternId + " | " + arguments.isEmpty() + " | " + verb.equals(""));
    if(patternId != -1 && !arguments.isEmpty() && !verb.equals(""))
    {
        for(int bundleId: arguments)
        {
            URL url = new URL("http://localhost:8080/Backend_war_exploded/searchEngine/addExamplesToPattern?verb=" + URLEncoder.encode(verb, "UTF-8") + "&patternId=" + patternId + "&bundleId=" + bundleId);
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

            out.println(jsonStr);

        }
    }
%>

</body>
</html>

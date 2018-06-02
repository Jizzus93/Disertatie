<%@ page import="bean.VerbPatternBean" %>
<%@ page import="bean.VerbPatternTypeBean" %>
<%@ page import="bean.VerbPatternInfoBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.lang.reflect.Executable" %>
<%@ page import="java.io.InputStream" %><%--
  Created by IntelliJ IDEA.
  User: octak
  Date: 5/21/2018
  Time: 7:33 PM
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
    int pattern_id = Integer.parseInt(request.getParameter("pattern_id"));
    int verb_id = Integer.parseInt(request.getParameter("verb_id"));
    String form_ro = request.getParameter("pattern_form_ro");
    String form_en = request.getParameter("pattern_form_en");
    String pwn = request.getParameter("pattern_pwn");

    VerbPatternBean verbPattern = new VerbPatternBean(verb_id,pattern_id,form_ro,form_en);

    verbPattern.setPWN(pwn);

    VerbPatternTypeBean verbPatternType = new VerbPatternTypeBean();
    int type_id = Integer.parseInt(request.getParameter("type_id"));
    verbPatternType.setId(type_id);
    String type_pattern_type = request.getParameter("type_pattern_type");
    if(!type_pattern_type.equals(""))
    {
        verbPatternType.setPatternType(type_pattern_type);
    }
    String type_syntactic_type = request.getParameter("type_syntactic_type");
    if(!type_syntactic_type.equals(""))
    {
        verbPatternType.setSyntacticType(type_syntactic_type);
    }
    String type_head = request.getParameter("type_head");
    if(!type_syntactic_type.equals(""))
    {
        verbPatternType.setHead(type_head);
    }

    verbPattern.setVerbPatternType(verbPatternType);

    VerbPatternInfoBean verbPatternInfo = new VerbPatternInfoBean();

    String classic_restrictions = request.getParameter("classic_restrictions");
    if(!classic_restrictions.equals(""))
    {
        String[] split_str = classic_restrictions.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addClassicRestriction(s);
        }
    }

    String classic_advanced_arguments = request.getParameter("classic_advanced_arguments");
    if(!classic_advanced_arguments.equals(""))
    {
        String[] split_str = classic_advanced_arguments.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addClassicAdvancedArgument(s);
        }
    }

    String classic_advanced_adjuncts = request.getParameter("classic_advanced_adjuncts");
    if(!classic_advanced_adjuncts.equals(""))
    {
        String[] split_str = classic_advanced_adjuncts.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addClassicAdvancedAdjunct(s);
        }
    }

    String classic_arguments = request.getParameter("classic_arguments");
    if(!classic_arguments.equals(""))
    {
        String[] split_str = classic_arguments.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addClassicArgument(s);
        }
    }

    String classic_adjuncts = request.getParameter("classic_adjuncts");
    if(!classic_adjuncts.equals(""))
    {
        String[] split_str = classic_adjuncts.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addClassicAdjunct(s);
        }
    }

    String ud_restrictions = request.getParameter("ud_restrictions");
    if(!ud_restrictions.equals(""))
    {
        String[] split_str = ud_restrictions.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addUDRestriction(s);
        }
    }

    String ud_advanced_arguments = request.getParameter("ud_advanced_arguments");
    if(!ud_advanced_arguments.equals(""))
    {
        String[] split_str = ud_advanced_arguments.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addUDAdvancedArgument(s);
        }
    }

    String ud_advanced_adjuncts = request.getParameter("ud_advanced_adjuncts");
    if(!ud_advanced_adjuncts.equals(""))
    {
        String[] split_str = ud_advanced_adjuncts.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addUDAdvancedAdjunct(s);
        }
    }

    String ud_arguments = request.getParameter("ud_arguments");
    if(!ud_arguments.equals(""))
    {
        String[] split_str = ud_arguments.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addUDArgument(s);
        }
    }

    String ud_adjuncts = request.getParameter("ud_adjuncts");
    if(!ud_adjuncts.equals(""))
    {
        String[] split_str = ud_adjuncts.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addUDAdjunct(s);
        }
    }

    String semantic_restrictions = request.getParameter("semantic_restrictions");
    if(!semantic_restrictions.equals(""))
    {
        String[] split_str = semantic_restrictions.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addSemanticRestriction(s);
        }
    }

    String semantic_advanced_arguments = request.getParameter("semantic_advanced_arguments");
    if(!semantic_advanced_arguments.equals(""))
    {
        String[] split_str = semantic_advanced_arguments.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addSemanticAdvancedArgument(s);
        }
    }

    String semantic_advanced_adjuncts = request.getParameter("semantic_advanced_adjuncts");
    if(!semantic_advanced_adjuncts.equals(""))
    {
        String[] split_str = semantic_advanced_adjuncts.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addSemanticAdvancedAdjunct(s);
        }
    }

    String semantic_arguments = request.getParameter("semantic_arguments");
    if(!semantic_arguments.equals(""))
    {
        String[] split_str = semantic_arguments.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addSemanticArgument(s);
        }
    }

    String semantic_adjuncts = request.getParameter("semantic_adjuncts");
    if(!semantic_adjuncts.equals(""))
    {
        String[] split_str = semantic_adjuncts.split(" ");
        for(String s: split_str)
        {
            verbPatternInfo.addSemanticAdjunct(s);
        }
    }

    verbPattern.setPatternInfo(verbPatternInfo);

    String implicatures = request.getParameter("implicatures");

    if(!implicatures.equals(""))
    {
        String[] split_str = implicatures.split("#");
        ArrayList<String> list = new ArrayList<String>();
        for(String s: split_str)
        {
            list.add(s);
        }
        verbPattern.setImplicatures(list);
    }

    Gson gson = new Gson();

    out.println(gson.toJson(verbPattern).toString());


    String charset = "UTF-8";
    URLConnection connection = new URL("http://localhost:8080/Backend_war_exploded/verbPatternWriter/writePattern").openConnection();
    connection.setDoOutput(true); // Triggers POST.
    connection.setRequestProperty("Accept-Charset", charset);
    connection.setRequestProperty("Content-Type", "application/json");

    try{
        OutputStream output = connection.getOutputStream();
        output.write(gson.toJson(verbPattern).toString().getBytes(charset));
    }
    catch (Exception e)
    {
        out.print(e.getStackTrace());
    }

    InputStream responsepost = connection.getInputStream();
    //out.println(responsepost);




%>

</body>
</html>

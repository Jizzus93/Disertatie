
<%@page import="bean.LoginDao"%>
<jsp:useBean id="obj" class="bean.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%

boolean status=LoginDao.validate(obj);
out.println("Validate result : \n" + LoginDao.validateErrorLog + "\n END RESULT");
if(status){
out.println("You r successfully logged in");
session.setAttribute("session","TRUE");
}
else
{
out.print("Sorry, email or password error");
%>
<jsp:include page="HelloJSp.jsp"></jsp:include>
<%
}
%>
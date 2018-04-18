<%--
  Created by IntelliJ IDEA.
  User: uidp9046
  Date: 4/10/18
  Time: 2:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body style="padding: 5px;">
  <header style="text-align: center; border-width: 2px; border-color: black; ">
        <img style="width: 250px; height: 125px; border-width: 1px; border-color: black; float: left;">

        <img style="width: 500px; height: 125px; border-width: 1px; border-color: black; vertical-align: middle;">

        <form action="loginprocess.jsp" style="float: right;">
          Email:<input type="text" name="email"/><br/><br/>
          Password:<input type="password" name="pass"/><br/><br/>
          <input type="submit" value="login"/>
        </form>
  </header>

  <div id = "mainContent" style="border-width: 1px; border-color: black; padding: 5px;">

      <form action="" style="text-align: center; margin: auto;" >
          Search <input type="text" name="search" style="width: 45%;"/><br/>
          <button>Search!</button>

      </form>

      <form action="" style="text-align: center; margin: auto;">
            <div style = "width: 15%; margin-left: 20px; float: left;">
                <h3 > List of verbs in RoPAAS</h3>
                <h5> Nr. of elements</h5>
                <select size="5" name="RoPAAS_vb" style = "width: 85%; " >
                    <option>Abandona</option>
                    <option>Abate</option>
                    <option>Abdica</option>
                    <option>Abera</option>
                    <option>Accepta</option>
                    <option>Activa</option>
                </select>
                <button>Download List</button>
            </div>
            <div style = "width: 15%; margin-left: 20px; float: left;">
                <h3 > List of verbs in RoPAAS</h3>
                <h5> Nr. of elements</h5>
                <select size="5" name="TreeBank_vb" style = "width: 85%;">
                <option>Abandona</option>
                <option>Abate</option>
                <option>Abdica</option>
                <option>Abera</option>
                <option>Accepta</option>
                <option>Activa</option>
                </select>
                <button>Download List</button>
            </div>
            <div style = "width: 15%; margin-left: 20px; float: left;">
                <h3 > List of verbs in RoPAAS</h3>
                <h5> Nr. of elements</h5>
                <select size="5" name="NotStarted_vb" style = "width: 85%;">
                <option>Abandona</option>
                <option>Abate</option>
                <option>Abdica</option>
                <option>Abera</option>
                <option>Accepta</option>
                <option>Activa</option>
                </select>
                <button>Download List</button>
            </div>
            <div style = "width: 15%; margin-left: 20px; float: left;">
                <h3 > List of verbs in RoPAAS</h3>
                <h5> Nr. of elements</h5>
                <select size="5" name="NDU_vb" style = "width: 85%; ">
                <option>Abandona</option>
                <option>Abate</option>
                <option>Abdica</option>
                <option>Abera</option>
                <option>Accepta</option>
                <option>Activa</option>
                </select>
                <button>Download List</button>
            </div>

        </form>

  </div>

  </body>
</html>

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
      <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
  </head>
  <body>


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

      <form action="verbSearch.jsp" method="get" style="text-align: center; margin: auto;" >
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

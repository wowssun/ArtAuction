<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userLogout.jsp</title>
</head>
<body>

<form role="form" action="/userLogout" method="post">
                   <fieldset>
                       <!-- Change this to a button or input when using this as a form -->
                       <input type="submit" value="Logout" class="btn btn-lg btn-success btn-block">
                   </fieldset>
                 <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
               </form>

</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<script>
// 우리 사이트 경로라서 그냥 /로 경로만 표시하면 된다.
// 그럼 home.jsp가 http://localhost:8090/ 로 들어왔을때 이 사이트가 뜨니까 여기로 들어오면 location을 통해 borad/list로 가게 한다
window.location.href = '/artauction/main';  // window 생략가능
// self.location.href = '/board/list'; self를 사용해서
</script>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>

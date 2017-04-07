<%@ page import="com.gushxue.wechat.cp.CPUserInformation" %>
<%@ page import="com.gushxue.jfs.utils.ServiceManager" %>
<%@ page import="com.daosheng.field.common.result.ResultService" %>
<%@ page import="com.gushxue.wechat.common.ResultKeyService" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src='../js/jquery-3.1.1.min.js'></script>
	<script type="text/javascript" src='../bootstrap-3.3.7/js/bootstrap.min.js'></script>
	<title>用户信息</title>

	<script type="text/javascript">
		  function getUserToken(name,password) {
			jQuery.ajax({
				url: "${ctx}/api/v1/device/login?deviceToken=deviceToken&mac=mac&name=" + name + "&password=" + password,   // 提交的页面
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
				async: false,
				error: function (request) {      // 设置表单提交出错

				},
				success: function (data) {

					if(data.success==true){
						var token = (data.message);
						window.location.replace("../publicNotice/publicNotice.jsp?token=" + token );
						//window.location.replace("../publicNotice/publicNotice.jsp?token=" + token );
					}
					else{
						alert(data.message);
					}
				}
			});
		}
		var userName = "admin";
		//getUserToken(userName,"37990088");

	</script>

</head>
<body>
<%
	try {
	//	out.println("code is " + request.getParameter("code"));
	//	out.println("state is " + request.getParameter("state"));
		CPUserInformation cpUserInformation = new CPUserInformation();
		ResultService resultService=cpUserInformation.getUserInformation(request.getParameter("code"));
		String userId = ResultKeyService.getResultString(resultService, "userid");
		//out.println(userId);
%>
<script language="javascript">
	getUserToken(<%=userId%>,"123456");
</script>
<%
	}
	catch (Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>


<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>


<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8" />
		<title>Session详情 </title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="http://img.wenyifan.net/images/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="http://img.wenyifan.net/images/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css?${_v}" rel="stylesheet"/>
		<script  src="http://open.sojson.com/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
		<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="<%=basePath%>/js/shiro.demo.js"></script>
		<script>
		$(document).ready(function(){
			$('#user2').addClass('active');
			$('#usercenter').addClass('active');
		});
		</script>
		
	</head>
	<body data-target="#one" data-spy="scroll">
		<%--引入头部--%>
		<jsp:include page="../common/config/top.jsp"></jsp:include>
		<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
			<div class="row">
				<%--引入左侧菜单--%>
				<jsp:include page="../common/config/left_usercenter.jsp"></jsp:include>
				<div class="col-md-10">
					<h2>Session详情</h2>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th>Session Id</th>
							<td>${empty bo.sessionId?'—':bo.sessionId}</td>
						</tr>
						<tr>
							<th>Session创建时间</th>
							<td><fmt:formatDate value="${bo.startTime}" pattern="yyyy年MM月dd日 HH:mm:ss" /></td>
						</tr>
						<tr>
							<th>Session最后交互时间</th>
							<td><fmt:formatDate value="${bo.lastAccess}" pattern="yyyy年MM月dd日 HH:mm:ss" /></td>
						</tr>
						<tr>
							<th>Session 状态</th>
							<td>${bo.sessionStatus?'有效':'已踢出'}</td>
						</tr>
						<tr>
							<th>Session Host</th>
							<td>${empty bo.host?'—':bo.host}</td>
						</tr>
						<tr>
							<th>Session timeout</th>
							<td>${bo.timeout}&nbsp;(毫秒) = ${bo.timeout/1000}(秒) = ${bo.timeout/1000/60}(分钟)</td>
						</tr>
						<tr>
							<th>昵称</th>
							<td>${empty bo.nickname?'—':bo.nickname}</td>
						</tr>
						<tr>
							<th>Email/帐号</th>
							<td>${empty bo.email?'—':bo.email}</td>
						</tr>
						<tr>
							<th>创建时间</th>
							<td><fmt:formatDate value="${bo.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
						<tr>
							<th>最后登录时间</th>
							<td><fmt:formatDate value="${bo.lastLoginTime}" pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
			
	</body>
</html>
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
		<title>当前在线</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="http://img.wenyifan.net/images/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="http://img.wenyifan.net/images/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css?${_v}" rel="stylesheet"/>
		<script  src="<%=basePath%>/js/jquery1.8.3.min.js"></script>
		<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
		<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="<%=basePath%>/js/shiro.demo.js"></script>
		<script >
		$(document).ready(function(){
			$('#user2').addClass('active');
			$('#usercenter').addClass('active');
		});
			<shiro:hasPermission name="/member/changeSessionStatus.shtml">
			$(function(){
				$("a[v=onlineDetails]").on('click',function(){
					var self = $(this);
					var text = $.trim(self.text());
					var index = layer.confirm("确定"+ text +"？",function(){
						changeSessionStatus(self.attr('sessionId'),self.attr('status'),self);
						layer.close(index);
					});
				});
			});
			//改变状态
			function changeSessionStatus(sessionIds,status,self){
				status = !parseInt(status);
				//loading
				var load = layer.load();
				$.post("<%=basePath%>/member/changeSessionStatus.shtml",{status:status,sessionIds:sessionIds},function(result){
					layer.close(load);
					if(result && result.status == 200){
						return self.text(result.sessionStatusText),
									self.attr('status',result.sessionStatus),
										self.parent().prev().text(result.sessionStatusTextTd);
										layer.msg('操作成功'),!1;
					}else{
						return layer.msg(result.message,function(){}),!1;
					}		
				},'json');
			}
			</shiro:hasPermission>
			
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
					<h2>当前在线用户</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent}" 
					        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
					      </div>
					     <span class=""> 
				         	<button type="submit" class="btn btn-primary">查询</button>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th>SessionID</th>
							<th>昵称</th>
							<th>Email/帐号</th>
							<th>创建回话</th>
							<th>回话最后活动</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
						<c:choose>
							<c:when test="${userList != null}">
								<c:forEach items="${userList}" var="it">
								<tr>
									<td>${empty it.sessionId?'未设置':it.sessionId}</td>
									<td>${empty it.nickname?'未设置':it.nickname}</td>
									<td>${empty it.email?'未设置':it.email}</td>
									<td><fmt:formatDate value="${it.startTime}" pattern="HH:mm:ss yy-MM-dd" /></td>
									<td><fmt:formatDate value="${it.lastAccess}" pattern="HH:mm:ss yy-MM-dd" /></td>
									
									<td>${it.sessionStatus?'有效':'已踢出'}</td>
									<td>
										<a href="<%=basePath%>/member/onlineDetails/${it.sessionId}.shtml">详情</a>
										<shiro:hasPermission name="/member/changeSessionStatus.shtml">
											<a v="onlineDetails"href="javascript:void(0);" sessionId="${it.sessionId}" status="${it.sessionStatus?'1':'0'}">${it.sessionStatus?'踢出':'激活'}</a>
										</shiro:hasPermission>
									</td>
								</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td class="text-center" colspan="7">没有找到用户</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</table>
							
				</div>
			</div>
		</div>
			
	</body>
</html>
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
		<title>用户列表 —个人中心</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
		<link   rel="icon" href="http://img.wenyifan.net/images/favicon.ico" type="image/x-icon" />
		<link   rel="shortcut icon" href="http://img.wenyifan.net/images/favicon.ico" />
		<link href="<%=basePath%>/js/common/bootstrap/3.3.5/css/bootstrap.min.css?${_v}" rel="stylesheet"/>
		<link href="<%=basePath%>/css/common/base.css?${_v}" rel="stylesheet"/>
		<script  src="http://open.sojson.com/common/jquery/jquery1.8.3.min.js"></script>
		<script  src="<%=basePath%>/js/common/layer/layer.js"></script>
		<script  src="<%=basePath%>/js/common/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script  src="<%=basePath%>/js/shiro.demo.js"></script>
		<script >
		$(document).ready(function(){
			$('#user1').addClass('active');
			$('#usercenter').addClass('active');
		});

			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission name="/member/deleteUserById.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return _delete(array);
				});
				</shiro:hasPermission>
			});
			<shiro:hasPermission name="/member/deleteUserById.shtml">
			//根据ID数组，删除
			function _delete(ids){
				var index = layer.confirm("确定这"+ ids.length +"个用户？",function(){
					var load = layer.load();
					$.post('<%=basePath%>/member/deleteUserById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg('删除成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
			<shiro:hasPermission name="/member/forbidUserById.shtml">
			/*
			*激活 | 禁止用户登录
			*/
			function forbidUserById(status,id){
				var text = status?'激活':'禁止';
				var index = layer.confirm("确定"+text+"这个用户？",function(){
					var load = layer.load();
					$.post('<%=basePath%>/member/forbidUserById.shtml',{status:status,id:id},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(text +'成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
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
					<h2>用户列表</h2>
					<hr>
					<form method="post" action="" id="formId" class="form-inline">
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent}" 
					        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
					      </div>
					     <span class=""> <%--pull-right --%>
				         	<button type="submit" class="btn btn-primary">查询</button>
				         	<shiro:hasPermission name="/member/deleteUserById.shtml">
				         		<button type="button" id="deleteAll" class="btn  btn-danger">Delete</button>
				         	</shiro:hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>昵称</th>
							<th>Email/帐号</th>
							<th>登录状态</th>
							<th>创建时间</th>
							<th>最后登录时间</th>
							<th>操作</th>
						</tr>
						<c:choose>
							<c:when test="${page != null && fn:length(page.list) gt 0}">
								<c:forEach items="${page.list}" var="it">
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${empty it.nickname? '未设置': it.nickname}</td>
									<td>${empty it.email? '未设置': it.email}</td>
									<td>
									<c:choose>
										<c:when test="${it.status==1}">有效</c:when>
										<c:otherwise>禁止</c:otherwise>
									</c:choose>
									</td>
									<td><fmt:formatDate value="${it.createTime}" pattern="HH:mm:ss yy-MM-dd" /></td>
									<td><fmt:formatDate value="${it.lastLoginTime}" pattern="HH:mm:ss yy-MM-dd" /></td>
												
									<td>
										<shiro:hasPermission name="/member/forbidUserById.shtml">
										<c:choose>
										<c:when test="${it.status==1}"><i class="glyphicon glyphicon-eye-close"></i>&nbsp;</c:when>
										<c:otherwise><i class="glyphicon glyphicon-eye-open"></i>&nbsp;</c:otherwise>
										</c:choose>
										
										<a href="javascript:forbidUserById(
										<c:choose><c:when test="${it.status==1}">'0'</c:when><c:otherwise>'1'</c:otherwise></c:choose>
										,${it.id})">
											${it.status==1?'禁止登录':'激活登录'}
										</a>
										</shiro:hasPermission>
										<shiro:hasPermission name="/member/deleteUserById.shtml">
										<a href="javascript:_delete([${it.id}]);">删除</a>
										</shiro:hasPermission>
									</td>
								</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td class="text-center danger" colspan="4">没有找到用户</td>
							</tr>
							</c:otherwise>
						</c:choose>
					</table>
					<c:if test="${page != null && fn:length(page.list) gt 0}">
						<div class="pagination pull-right">
							${page.pageHtml}
						</div>
					</c:if>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>
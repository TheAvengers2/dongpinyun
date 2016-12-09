<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">


<shiro:hasAnyRoles name='888888,100003'>  
	<div id="one" class="col-md-2">
		<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
	 	<shiro:hasPermission name="/role/index.shtml">
		  <li id="auth1" class="dropdown">
		      <a href="<%=basePath%>role/index.shtml">
		    	 <i class="glyphicon glyphicon-chevron-right"></i>角色列表
		      </a>
		  </li>
	  	</shiro:hasPermission>
 		<shiro:hasPermission name="/role/allocation.shtml">
		  <li id="auth2" class="dropdown">
		      <a href="<%=basePath%>role/allocation.shtml">
		    	 <i class="glyphicon glyphicon-chevron-right"></i>角色分配
		      </a>
		  </li>
	  	</shiro:hasPermission>
	  	<shiro:hasPermission name="/permission/index.shtml">
		  <li id="auth3" class="dropdown">
		      <a href="<%=basePath%>permission/index.shtml">
		    	 <i class="glyphicon glyphicon-chevron-right"></i>权限列表
		      </a>
		  </li>
	  	</shiro:hasPermission>
	  	<shiro:hasPermission name="/permission/allocation.shtml">
		  <li id="auth4" class="dropdown">
		      <a href="<%=basePath%>permission/allocation.shtml">
		    	 <i class="glyphicon glyphicon-chevron-right"></i>权限分配
		      </a>
		  </li>
	  	</shiro:hasPermission>
		</ul>
	</div>
</shiro:hasAnyRoles>  
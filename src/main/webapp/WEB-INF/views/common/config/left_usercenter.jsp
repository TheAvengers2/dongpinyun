<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">


<shiro:hasAnyRoles name='888888,100002'>          
	<div id="one" class="col-md-2">
		<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
		  <li id="user1" class="dropdown">
		      <a href="<%=basePath%>member/list.shtml">
		    	 <i class="glyphicon glyphicon-chevron-right"></i>用户列表
		      </a>
		  </li>
		  <li id="user2" class="dropdown">
		      <a href="<%=basePath%>member/online.shtml">
		    	 <i class="glyphicon glyphicon-chevron-right"></i>在线用户
		      </a>
		  </li>
		</ul>
	</div>
</shiro:hasAnyRoles>   
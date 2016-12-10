<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path; %> 
<base href="<%=basePath%>">


<div id="one" class="col-md-2">
	<ul data-spy="affix" class="nav nav-list nav-tabs nav-stacked bs-docs-sidenav dropdown affix" style="top: 100px; z-index: 100;">
	  <li id="pi1" class="dropdown">
	      <a href="<%=basePath%>/user/index.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>个人资料
	      </a>
	       <ul class="dropdown-menu" aria-labelledby="dLabel" style="margin-left: 160px; margin-top: -40px;">
              <li><a href="<%=basePath%>/user/updateSelf.shtml">资料修改</a></li>
              <li><a href="<%=basePath%>/user/updatePswd.shtml">密码修改</a></li>
          </ul>
	  </li>
	  <li id="pi2" class="dropdown">
	      <a href="<%=basePath%>/role/mypermission.shtml">
	    	 <i class="glyphicon glyphicon-chevron-right"></i>我的权限
	      </a>
	  </li>
	</ul>
</div> 
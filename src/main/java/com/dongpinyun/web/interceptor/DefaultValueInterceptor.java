package com.dongpinyun.web.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sojson.common.model.UUser;
import com.sojson.common.utils.LoggerUtils;

import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.core.statics.Constant;

public class DefaultValueInterceptor extends HandlerInterceptorAdapter{

	
	public void postHandle(final HttpServletRequest request,
            final HttpServletResponse response, final Object handler,
            final ModelAndView modelAndView){
		
		if (modelAndView == null || modelAndView.getModelMap() == null) {
			LoggerUtils.debug(getClass(), "!!!!!!!!!!!!!!!!!!!!!");
			return;
		}
		ModelMap map = modelAndView.getModelMap();
		UUser token = TokenManager.getToken();
		//String ip = IPUtils.getIP(request);
		LoggerUtils.debug(getClass(), token.toString());

		map.addAttribute("token", token);//登录的token
		map.addAttribute("_time", new Date().getTime());
		map.addAttribute("NOW_YEAY", Constant.NOW_YEAY);//今年
		
		map.addAttribute("_v", Constant.VERSION);//版本号，重启的时间
		map.addAttribute("cdn", Constant.DOMAIN_CDN);//CDN域名
		map.addAttribute("basePath", request.getContextPath());//base目录。
		
	}
}

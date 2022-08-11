package com.spring.javagreenS_jmk.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ProductInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		int authority = session.getAttribute("sAuthority")==null ? 2 : (int) session.getAttribute("sAuthority");
		RequestDispatcher dispatcher;
		if(authority > 1) {
			dispatcher = request.getRequestDispatcher("/msg/unLogin");
			dispatcher.forward(request, response);
		}
		return super.preHandle(request, response, handler);
	}
	
}

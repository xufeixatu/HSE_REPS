package com.thinkgem.jeesite.modules.zsk.interceptor;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.thinkgem.jeesite.modules.zsk.entity.ZskDocument;
import com.thinkgem.jeesite.modules.zsk.service.ZskDocumentService;

public class ZskInterceptor implements HandlerInterceptor{

	@Autowired
	private ZskDocumentService zskDocumentService;
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object arg2, Exception arg3)
			throws Exception {
	
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
		
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		String filePath=request.getParameter("filePath");
		String moduls_name=request.getParameter("moduls_name");
		if(filePath!=null){
			System.out.println(filePath);
			ZskDocument zskDocument=new ZskDocument();
			zskDocument.setFileName(UUID.randomUUID().toString());
			zskDocument.setClassid(moduls_name);
			zskDocument.setFilePath(filePath);
			zskDocument.setDocType("233");
			zskDocumentService.save(zskDocument);
		}
		request.setAttribute("aaaaa", "eesfgddsg");
		return true;
	}

}

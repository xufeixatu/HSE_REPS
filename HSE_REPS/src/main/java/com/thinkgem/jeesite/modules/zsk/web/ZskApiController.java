package com.thinkgem.jeesite.modules.zsk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.zsk.service.ZskDocumentService;

/**
 * 
 * 知识库分类Controller
 * @author 郭凯凯
 * @version 2017-04-20
 */
@RequestMapping(value = "${adminPath}/zsk/zskApi")
public class ZskApiController extends BaseController {
	
	@Autowired	
	private ZskDocumentService zskDocumentService;
	
	@RequestMapping(value = {"get"})
	@ResponseBody
	public String get(@RequestParam(required=false)String id){
		return zskDocumentService.get(id).getFilePath();
	}
    
	

}

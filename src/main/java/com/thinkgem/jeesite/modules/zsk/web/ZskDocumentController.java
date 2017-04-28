/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.zsk.entity.ZskDocument;
import com.thinkgem.jeesite.modules.zsk.service.ZskDocumentService;

/**
 * 知识库文档Controller
 * @author 郭凯凯
 * @version 2017-04-26
 */
@Controller
@RequestMapping(value = "${adminPath}/zsk/zskDocument")
public class ZskDocumentController extends BaseController {

	@Autowired
	private ZskDocumentService zskDocumentService;
	
	@ModelAttribute
	public ZskDocument get(@RequestParam(required=false) String id,HttpServletRequest request) {
		ZskDocument entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = zskDocumentService.get(id);
		}
		if (entity == null){
			entity = new ZskDocument();
		}
		return entity;
	}
	
	@RequiresPermissions("zsk:zskDocument:view")
	@RequestMapping(value = {"list", ""})
	public String list(ZskDocument zskDocument, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ZskDocument> page = zskDocumentService.findPage(new Page<ZskDocument>(request, response), zskDocument); 
		model.addAttribute("page", page);
		return "modules/zsk/zskDocumentList";
	}

	@RequiresPermissions("zsk:zskDocument:view")
	@RequestMapping(value = "form")
	public String form(ZskDocument zskDocument, Model model) {
		model.addAttribute("zskDocument", zskDocument);
		return "modules/zsk/zskDocumentForm";
	}

	@RequiresPermissions("zsk:zskDocument:edit")
	@RequestMapping(value = "save")
	public String save(ZskDocument zskDocument, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zskDocument)){
			return form(zskDocument, model);
		}
		zskDocumentService.save(zskDocument);
		addMessage(redirectAttributes, "保存文档成功");
		return "redirect:"+Global.getAdminPath()+"/zsk/zskDocument/?repage";
	}
	
	@RequiresPermissions("zsk:zskDocument:edit")
	@RequestMapping(value = "delete")
	public String delete(ZskDocument zskDocument, RedirectAttributes redirectAttributes) {
		zskDocumentService.delete(zskDocument);
		addMessage(redirectAttributes, "删除文档成功");
		return "redirect:"+Global.getAdminPath()+"/zsk/zskDocument/?repage";
	}
	

}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.web;

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
import com.thinkgem.jeesite.modules.check.entity.CheckTypeClass;
import com.thinkgem.jeesite.modules.check.service.CheckTypeClassService;

/**
 * 检查类别管理Controller
 * @author hehui
 * @version 2017-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/check/checkTypeClass")
public class CheckTypeClassController extends BaseController {

	@Autowired
	private CheckTypeClassService checkTypeClassService;
	
	@ModelAttribute
	public CheckTypeClass get(@RequestParam(required=false) String id) {
		CheckTypeClass entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = checkTypeClassService.get(id);
		}
		if (entity == null){
			entity = new CheckTypeClass();
		}
		return entity;
	}
	
	@RequiresPermissions("check:checkTypeClass:view")
	@RequestMapping(value = {"list", ""})
	public String list(CheckTypeClass checkTypeClass, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CheckTypeClass> page = checkTypeClassService.findPage(new Page<CheckTypeClass>(request, response), checkTypeClass); 
		model.addAttribute("page", page);
		return "modules/check/checkTypeClassList";
	}

	@RequiresPermissions("check:checkTypeClass:view")
	@RequestMapping(value = "form")
	public String form(CheckTypeClass checkTypeClass, Model model) {
		model.addAttribute("checkTypeClass", checkTypeClass);
		return "modules/check/checkTypeClassForm";
	}

	@RequiresPermissions("check:checkTypeClass:edit")
	@RequestMapping(value = "save")
	public String save(CheckTypeClass checkTypeClass, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, checkTypeClass)){
			return form(checkTypeClass, model);
		}
		checkTypeClassService.save(checkTypeClass);
		addMessage(redirectAttributes, "保存检查类别成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTypeClass/?repage";
	}
	
	@RequiresPermissions("check:checkTypeClass:edit")
	@RequestMapping(value = "delete")
	public String delete(CheckTypeClass checkTypeClass, RedirectAttributes redirectAttributes) {
		checkTypeClassService.delete(checkTypeClass);
		addMessage(redirectAttributes, "删除检查类别成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTypeClass/?repage";
	}

}
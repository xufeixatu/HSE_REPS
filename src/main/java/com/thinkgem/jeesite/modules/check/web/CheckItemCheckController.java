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
import com.thinkgem.jeesite.modules.check.entity.CheckItemCheck;
import com.thinkgem.jeesite.modules.check.service.CheckItemCheckService;

/**
 * 检查项检查管理Controller
 * @author hehui
 * @version 2017-05-12
 */
@Controller
@RequestMapping(value = "${adminPath}/check/checkItemCheck")
public class CheckItemCheckController extends BaseController {

	@Autowired
	private CheckItemCheckService checkItemCheckService;
	
	@ModelAttribute
	public CheckItemCheck get(@RequestParam(required=false) String id) {
		CheckItemCheck entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = checkItemCheckService.get(id);
		}
		if (entity == null){
			entity = new CheckItemCheck();
		}
		return entity;
	}
	
	@RequiresPermissions("check:checkItemCheck:view")
	@RequestMapping(value = {"list", ""})
	public String list(CheckItemCheck checkItemCheck, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CheckItemCheck> page = checkItemCheckService.findPage(new Page<CheckItemCheck>(request, response), checkItemCheck); 
		model.addAttribute("page", page);
		return "modules/check/checkItemCheckList";
	}

	@RequiresPermissions("check:checkItemCheck:view")
	@RequestMapping(value = "form")
	public String form(CheckItemCheck checkItemCheck, Model model) {
		model.addAttribute("checkItemCheck", checkItemCheck);
		return "modules/check/checkItemCheckForm";
	}

	@RequiresPermissions("check:checkItemCheck:edit")
	@RequestMapping(value = "save")
	public String save(CheckItemCheck checkItemCheck, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, checkItemCheck)){
			return form(checkItemCheck, model);
		}
		checkItemCheckService.save(checkItemCheck);
		addMessage(redirectAttributes, "保存检查项检查管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkItemCheck/?repage";
	}
	
	@RequiresPermissions("check:checkItemCheck:edit")
	@RequestMapping(value = "delete")
	public String delete(CheckItemCheck checkItemCheck, RedirectAttributes redirectAttributes) {
		checkItemCheckService.delete(checkItemCheck);
		addMessage(redirectAttributes, "删除检查项检查管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkItemCheck/?repage";
	}

}
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
import com.thinkgem.jeesite.modules.check.entity.Inspct;
import com.thinkgem.jeesite.modules.check.service.InspctService;

/**
 * 检查记录管理Controller
 * @author hehui
 * @version 2017-05-10
 */
@Controller
@RequestMapping(value = "${adminPath}/check/inspct")
public class InspctController extends BaseController {

	@Autowired
	private InspctService inspctService;
	
	@ModelAttribute
	public Inspct get(@RequestParam(required=false) String id) {
		Inspct entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = inspctService.get(id);
		}
		if (entity == null){
			entity = new Inspct();
		}
		return entity;
	}
	
	@RequiresPermissions("check:inspct:view")
	@RequestMapping(value = {"list", ""})
	public String list(Inspct inspct, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Inspct> page = inspctService.findPage(new Page<Inspct>(request, response), inspct); 
		model.addAttribute("page", page);
		return "modules/check/inspctList";
	}

	@RequiresPermissions("check:inspct:view")
	@RequestMapping(value = "form")
	public String form(Inspct inspct, Model model) {
		model.addAttribute("inspct", inspct);
		return "modules/check/inspctForm";
	}

	@RequiresPermissions("check:inspct:edit")
	@RequestMapping(value = "save")
	public String save(Inspct inspct, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, inspct)){
			return form(inspct, model);
		}
		inspctService.save(inspct);
		addMessage(redirectAttributes, "保存检查记录管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/inspct/?repage";
	}
	
	@RequiresPermissions("check:inspct:edit")
	@RequestMapping(value = "delete")
	public String delete(Inspct inspct, RedirectAttributes redirectAttributes) {
		inspctService.delete(inspct);
		addMessage(redirectAttributes, "删除检查记录管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/inspct/?repage";
	}

}
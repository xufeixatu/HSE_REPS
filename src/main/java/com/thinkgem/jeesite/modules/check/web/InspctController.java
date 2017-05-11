/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.web;

import java.util.List;

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
import com.thinkgem.jeesite.modules.check.entity.CheckTemplate;
import com.thinkgem.jeesite.modules.check.entity.CheckTypeClass;
import com.thinkgem.jeesite.modules.check.entity.Inspct;
import com.thinkgem.jeesite.modules.check.service.CheckTemplateService;
import com.thinkgem.jeesite.modules.check.service.CheckTypeClassService;
import com.thinkgem.jeesite.modules.check.service.InspctService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

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
	
	@Autowired
	private CheckTypeClassService typeClassService;
	
	@Autowired
	private CheckTemplateService checkTemplateService;
	
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
		CheckTypeClass checkTypeClass = new CheckTypeClass();
		List<CheckTypeClass> typeClasses = typeClassService.findList(checkTypeClass);
		model.addAttribute("checkTypes", typeClasses);
		return "modules/check/inspctList";
	}

	@RequiresPermissions("check:inspct:view")
	@RequestMapping(value = "form")
	public String form(Inspct inspct, Model model) {
		model.addAttribute("inspct", inspct);
		CheckTypeClass checkTypeClass = new CheckTypeClass();
		List<CheckTypeClass> typeClasses = typeClassService.findList(checkTypeClass);
		model.addAttribute("checkTypes", typeClasses);
		CheckTemplate checkTemplate = new CheckTemplate();
		List<CheckTemplate> templates = checkTemplateService.findList(checkTemplate);
		model.addAttribute("templates", templates);
		return "modules/check/inspctForm";
	}

	@RequiresPermissions("check:inspct:edit")
	@RequestMapping(value = "save")
	public String save(Inspct inspct, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, inspct)){
			return form(inspct, model);
		}
		User currentUser = UserUtils.getUser();
		inspct.setCheckPerson(currentUser.getId());
		inspctService.save(inspct);
		addMessage(redirectAttributes, "添加检查记录成功");
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
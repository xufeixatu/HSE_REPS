/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.web;

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
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafe;
import com.thinkgem.jeesite.modules.actcard.service.ActcardUnsafeService;

/**
 * actcard_unsafe关联表Controller
 * @author 岳鑫
 * @version 2017-06-07
 */
@Controller
@RequestMapping(value = "${adminPath}/actcard/actcardUnsafe")
public class ActcardUnsafeController extends BaseController {

	@Autowired
	private ActcardUnsafeService actcardUnsafeService;
	
	@ModelAttribute
	public ActcardUnsafe get(@RequestParam(required=false) String id) {
		ActcardUnsafe entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = actcardUnsafeService.get(id);
		}
		if (entity == null){
			entity = new ActcardUnsafe();
		}
		return entity;
	}
	
	@RequiresPermissions("actcard:actcardUnsafe:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActcardUnsafe actcardUnsafe, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActcardUnsafe> page = actcardUnsafeService.findPage(new Page<ActcardUnsafe>(request, response), actcardUnsafe); 
		model.addAttribute("page", page);
		return "modules/actcard/actcardUnsafeList";
	}

	@RequiresPermissions("actcard:actcardUnsafe:view")
	@RequestMapping(value = "form")
	public String form(ActcardUnsafe actcardUnsafe, Model model) {
		model.addAttribute("actcardUnsafe", actcardUnsafe);
		return "modules/actcard/actcardUnsafeForm";
	}

	@RequiresPermissions("actcard:actcardUnsafe:edit")
	@RequestMapping(value = "save")
	public String save(ActcardUnsafe actcardUnsafe, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, actcardUnsafe)){
			return form(actcardUnsafe, model);
		}
		actcardUnsafeService.save(actcardUnsafe);
		addMessage(redirectAttributes, "保存actcard_unsafe关联表成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardUnsafe/?repage";
	}
	
	@RequiresPermissions("actcard:actcardUnsafe:edit")
	@RequestMapping(value = "delete")
	public String delete(ActcardUnsafe actcardUnsafe, RedirectAttributes redirectAttributes) {
		actcardUnsafeService.delete(actcardUnsafe);
		addMessage(redirectAttributes, "删除actcard_unsafe关联表成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardUnsafe/?repage";
	}

}
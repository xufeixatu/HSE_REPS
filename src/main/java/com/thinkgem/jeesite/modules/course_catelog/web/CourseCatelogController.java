/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catelog.web;

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
import com.thinkgem.jeesite.modules.course_catelog.entity.CourseCatelog;
import com.thinkgem.jeesite.modules.course_catelog.service.CourseCatelogService;

/**
 * 课件目录Controller
 * @author 王少昌
 * @version 2017-06-07
 */
@Controller
@RequestMapping(value = "${adminPath}/course_catelog/courseCatelog")
public class CourseCatelogController extends BaseController {

	@Autowired
	private CourseCatelogService courseCatelogService;
	
	@ModelAttribute
	public CourseCatelog get(@RequestParam(required=false) String id) {
		CourseCatelog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = courseCatelogService.get(id);
		}
		if (entity == null){
			entity = new CourseCatelog();
		}
		return entity;
	}
	
	@RequiresPermissions("course_catelog:courseCatelog:view")
	@RequestMapping(value = {"list", ""})
	public String list(CourseCatelog courseCatelog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CourseCatelog> page = courseCatelogService.findPage(new Page<CourseCatelog>(request, response), courseCatelog); 
		model.addAttribute("page", page);
		return "modules/course_catelog/courseCatelogList";
	}

	@RequiresPermissions("course_catelog:courseCatelog:view")
	@RequestMapping(value = "form")
	public String form(CourseCatelog courseCatelog, Model model) {
		model.addAttribute("courseCatelog", courseCatelog);
		return "modules/course_catelog/courseCatelogForm";
	}

	@RequiresPermissions("course_catelog:courseCatelog:edit")
	@RequestMapping(value = "save")
	public String save(CourseCatelog courseCatelog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, courseCatelog)){
			return form(courseCatelog, model);
		}
		courseCatelogService.save(courseCatelog);
		addMessage(redirectAttributes, "保存课件目录成功");
		return "redirect:"+Global.getAdminPath()+"/course_catelog/courseCatelog/?repage";
	}
	
	@RequiresPermissions("course_catelog:courseCatelog:edit")
	@RequestMapping(value = "delete")
	public String delete(CourseCatelog courseCatelog, RedirectAttributes redirectAttributes) {
		courseCatelogService.delete(courseCatelog);
		addMessage(redirectAttributes, "删除课件目录成功");
		return "redirect:"+Global.getAdminPath()+"/course_catelog/courseCatelog/?repage";
	}

}
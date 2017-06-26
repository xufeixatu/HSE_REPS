/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_study.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;
import com.thinkgem.jeesite.modules.course_study.service.CourseStudyService;

/**
 * 学习记录Controller
 * @author 王少昌
 * @version 2017-06-10
 */
@Controller
@RequestMapping(value = "${adminPath}/course_study/courseStudy")
public class CourseStudyController extends BaseController {

	@Autowired
	private CourseStudyService courseStudyService;
	@ModelAttribute
	public CourseStudy get(@RequestParam(required=false) String id) {
		CourseStudy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = courseStudyService.get(id);
		}
		if (entity == null){
			entity = new CourseStudy();
		}
		return entity;
	}
	
	@RequiresPermissions("course_study:courseStudy:view")
	@RequestMapping(value = {"list", ""})
	public String list(CourseStudy courseStudy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CourseStudy> page = courseStudyService.findPage(new Page<CourseStudy>(request, response), courseStudy); 
		model.addAttribute("page", page);
		return "modules/course_study/courseStudyList";
	}

	@RequiresPermissions("course_study:courseStudy:view")
	@RequestMapping(value = "form")
	public String form(CourseStudy courseStudy, Model model) {
		model.addAttribute("courseStudy", courseStudy);
		return "modules/course_study/courseStudyForm";
	}

	@RequiresPermissions("course_study:courseStudy:edit")
	@RequestMapping(value = "save")
	public String save(CourseStudy courseStudy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, courseStudy)){
			return form(courseStudy, model);
		}
		courseStudyService.save(courseStudy);
		addMessage(redirectAttributes, "保存学习记录成功");
		return "redirect:"+Global.getAdminPath()+"/course_study/courseStudy/?repage";
	}
	
	@RequiresPermissions("course_study:courseStudy:edit")
	@RequestMapping(value = "delete")
	public String delete(CourseStudy courseStudy, RedirectAttributes redirectAttributes) {
		courseStudyService.delete(courseStudy);
		addMessage(redirectAttributes, "删除学习记录成功");
		return "redirect:"+Global.getAdminPath()+"/course_study/courseStudy/?repage";
	}

	@ResponseBody
    @RequiresPermissions("course_study:courseStudy:edit")
	@RequestMapping(value = "setGrade")//  grade打分
	public String setGrade(CourseStudy courseStudy) {
		System.out.println(courseStudy.getGrade());
		System.out.println(courseStudy.getId());
		return courseStudyService.avg(courseStudy);
		
	}

	
	
	
	
//=======
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.thinkgem.jeesite.common.config.Global;
//import com.thinkgem.jeesite.common.persistence.Page;
//import com.thinkgem.jeesite.common.web.BaseController;
//import com.thinkgem.jeesite.common.utils.StringUtils;
//import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;
//import com.thinkgem.jeesite.modules.course_study.service.CourseStudyService;
//
///**
// * 课程用户学习记录表Controller
// * @author 曹洪运
// * @version 2017-06-09
// */
//@Controller
//@RequestMapping(value = "${adminPath}/course_study/courseStudy")
//public class CourseStudyController extends BaseController {
//
//	@Autowired
//	private CourseStudyService courseStudyService;
//	
//	@ModelAttribute
//	public CourseStudy get(@RequestParam(required=false) String id) {
//		CourseStudy entity = null;
//		if (StringUtils.isNotBlank(id)){
//			entity = courseStudyService.get(id);
//		}
//		if (entity == null){
//			entity = new CourseStudy();
//		}
//		return entity;
//	}
//	
//	@RequiresPermissions("course_study:courseStudy:view")
//	@RequestMapping(value = {"list", ""})
//	public String list(CourseStudy courseStudy, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<CourseStudy> page = courseStudyService.findPage(new Page<CourseStudy>(request, response), courseStudy); 
//		model.addAttribute("page", page);
//		return "modules/course_study/courseStudyList";
//	}
//
//	@RequiresPermissions("course_study:courseStudy:view")
//	@RequestMapping(value = "form")
//	public String form(CourseStudy courseStudy, Model model) {
//		model.addAttribute("courseStudy", courseStudy);
//		return "modules/course_study/courseStudyForm";
//	}
//
//	@RequiresPermissions("course_study:courseStudy:edit")
//	@RequestMapping(value = "save")
//	public String save(CourseStudy courseStudy, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, courseStudy)){
//			return form(courseStudy, model);
//		}
//		courseStudyService.save(courseStudy);
//		addMessage(redirectAttributes, "保存课程用户学习记录表成功");
//		return "redirect:"+Global.getAdminPath()+"/course_study/courseStudy/?repage";
//	}
//	
//	@RequiresPermissions("course_study:courseStudy:edit")
//	@RequestMapping(value = "delete")
//	public String delete(CourseStudy courseStudy, RedirectAttributes redirectAttributes) {
//		courseStudyService.delete(courseStudy);
//		addMessage(redirectAttributes, "删除课程用户学习记录表成功");
//		return "redirect:"+Global.getAdminPath()+"/course_study/courseStudy/?repage";
//	}
//
//>>>>>>> branch 'trainCourse' of https://github.com/xufeixatu/HSE_REPS.git
}
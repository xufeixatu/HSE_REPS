/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_review.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.thinkgem.jeesite.modules.course_review.entity.CourseReview;
import com.thinkgem.jeesite.modules.course_review.service.CourseReviewService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 课件评论Controller
 * @author 曹洪运
 * @version 2017-06-02
 */
@Controller
@RequestMapping(value = "${adminPath}/course_review/courseReview")
public class CourseReviewController extends BaseController {

	@Autowired
	private CourseReviewService courseReviewService;
	
	@ModelAttribute
	public CourseReview get(@RequestParam(required=false) String id) {
		CourseReview entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = courseReviewService.get(id);
			
		}
		if (entity == null){
			entity = new CourseReview();
		}
		return entity;
	}
	
	@RequiresPermissions("course_review:courseReview:view")
	@RequestMapping(value = {"list", ""})
	public String list(CourseReview courseReview, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CourseReview> page = courseReviewService.findPage(new Page<CourseReview>(request, response), courseReview); 
		model.addAttribute("page", page);
		return "modules/course_review/courseReviewList";
	}

	@RequiresPermissions("course_review:courseReview:view")
	@RequestMapping(value = "form")
	public String form(CourseReview courseReview, Model model) {
/*		courseReview.setAssessById(UserUtils.getUser().getName());
		Date upload_time = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.format(upload_time);
		courseReview.setAssessTime(upload_time);*/	
		model.addAttribute("courseReview", courseReview);
		return "modules/course_review/courseReviewForm";
	}

	@RequiresPermissions("course_review:courseReview:edit")
	@RequestMapping(value = "save")
	public String save(CourseReview courseReview, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, courseReview)){
			return form(courseReview, model);
		}
		courseReviewService.save(courseReview);
		addMessage(redirectAttributes, "保存课件评论成功");
		return "redirect:"+Global.getAdminPath()+"/course_review/courseReview/?repage";
	}
	
	/*评论*/
	@RequiresPermissions("course_review:courseReview:edit")
	@RequestMapping(value = "save1")
	public String save1(CourseReview courseReview,HttpServletRequest request,Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, courseReview)){
			return form(courseReview, model);
		}
		System.out.println(courseReview.getCourseId());
		courseReviewService.save(courseReview);
//		courseReview.setCourseId(request.getParameter("id"));
		System.out.println(courseReview.getCourseId());
		System.out.println("评论层");
		addMessage(redirectAttributes, "保存课件评论成功");
		return "redirect:"+Global.getAdminPath()+"/train_course/trainCourse2/list?id="+courseReview.getCourseId();
	}
	
	@RequiresPermissions("course_review:courseReview:edit")
	@RequestMapping(value = "delete")
	public String delete(CourseReview courseReview, RedirectAttributes redirectAttributes) {
		courseReviewService.delete(courseReview);
		addMessage(redirectAttributes, "删除课件评论成功");
		return "redirect:"+Global.getAdminPath()+"/course_review/courseReview/?repage";
	}

}
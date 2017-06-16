/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train_course.web;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.course_review.entity.CourseReview;
import com.thinkgem.jeesite.modules.course_review.service.CourseReviewService;
//<<<<<<< HEAD
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;
import com.thinkgem.jeesite.modules.course_study.service.CourseStudyService;
//=======
//>>>>>>> branch 'trainCourse' of https://github.com/xufeixatu/HSE_REPS.git
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;
import com.thinkgem.jeesite.modules.train_course.service.TrainCourseService;

/**
 * 培训课件Controller
 * @author 王少昌
 * @version 2017-05-17
 */
@Controller
@RequestMapping(value = "${adminPath}/train_course/trainCourse2")
public class TrainCourse2Controller extends BaseController {

	@Autowired
	private TrainCourseService trainCourseService;
	@Autowired
	private CourseReviewService courseReviewService;
//<<<<<<< HEAD
	@Autowired
	private CourseStudyService courseStudyService;
//=======
//>>>>>>> branch 'trainCourse' of https://github.com/xufeixatu/HSE_REPS.git
	@ModelAttribute
	public TrainCourse get(@RequestParam(required=false) String id) {
		TrainCourse entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainCourseService.get(id);
		}
		if (entity == null){
			entity = new TrainCourse();
		}
		return entity;
	}
	
	@RequiresPermissions("train_course:trainCourse2:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainCourse trainCourse, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Page<TrainCourse> page = trainCourseService.findPage(new Page<TrainCourse>(request, response), trainCourse); 
		model.addAttribute("page", page);
		
		CourseReview courseReview =new CourseReview();
//<<<<<<< HEAD
		//补充
		courseReview.setCourseId(request.getParameter("id"));
	 
	    //courseReview.setAssessGrade("1");
	    Page<CourseReview> page1 = courseReviewService.findPage(new Page<CourseReview>(request, response), courseReview); 
		courseReview.setAssessById(UserUtils.getUser().getName());
		Date upload_time = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.format(upload_time);
		courseReview.setAssessTime(upload_time);
		
		courseReview.setCourseId(trainCourse.getId());
		model.addAttribute("courseReview", courseReview);
		model.addAttribute("page1", page1);
		
		//传打分参数
		CourseStudy courseStudy =  new CourseStudy();
		courseStudy.setCourseId(trainCourse.getId());
		courseStudy.setCreateBy(UserUtils.getUser());
		System.out.println("===============================");
		model.addAttribute("courseStudy", courseStudyService.findByCourseIdAndUserId(courseStudy));
		System.out.println("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
//=======
//		Page<CourseReview> page1 = courseReviewService.findPage(new Page<CourseReview>(request, response), courseReview); 
//		courseReview.setAssessById(UserUtils.getUser().getName());
//		Date upload_time = new Date();
//		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		dateFormat.format(upload_time);
//		courseReview.setAssessTime(upload_time);
//		
//		courseReview.setCourseId(trainCourse.getId());
//		model.addAttribute("courseReview", courseReview);
//		model.addAttribute("page1", page1);
//>>>>>>> branch 'trainCourse' of https://github.com/xufeixatu/HSE_REPS.git
		return "modules/train_course/trainCourse2List";
	}

	@RequiresPermissions("train_course:trainCourse2:view")
	@RequestMapping(value = "form")
	public String form(TrainCourse trainCourse, Model model) {
		model.addAttribute("trainCourse", trainCourse);
		//model.addAttribute("courseReview", courseReview);
		return "modules/train_course/trainCourse2Form";
	}

	@RequiresPermissions("train_course:trainCourse2:edit")
	@RequestMapping(value = "save")
	public String save(TrainCourse trainCourse, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainCourse)){
			return form(trainCourse, model);
		}
		trainCourseService.save(trainCourse);
		addMessage(redirectAttributes, "保存培训课件上传与查看成功");
		return "redirect:"+Global.getAdminPath()+"/train_course/trainCourse2/?repage";
	}
	
	@RequiresPermissions("train_course:trainCourse2:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainCourse trainCourse, RedirectAttributes redirectAttributes) {
		trainCourseService.delete(trainCourse);
		addMessage(redirectAttributes, "删除培训课件上传与查看成功");
		return "redirect:"+Global.getAdminPath()+"/train_course/trainCourse2/?repage";
	}
	
	
	

}
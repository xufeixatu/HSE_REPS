/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train_course.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

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
import com.thinkgem.jeesite.modules.course_study.dao.CourseStudyDao;
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;
import com.thinkgem.jeesite.modules.course_study.service.CourseStudyService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;
import com.thinkgem.jeesite.modules.train_course.service.TrainCourseService;

/**
 * 培训课件Controller
 * @author 王少昌
 * @version 2017-05-17
 */
@Controller
@RequestMapping(value = "${adminPath}/train_course/trainCourse3")
public class TrainCourse3Controller extends BaseController {

	@Autowired
	private TrainCourseService trainCourseService;
	
	@Autowired
	private CourseStudyService courseStudyService;
	
	
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
	
	@RequiresPermissions("train_course:trainCourse3:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainCourse trainCourse,HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainCourse> page = trainCourseService.findPage(new Page<TrainCourse>(request, response), trainCourse); 
		model.addAttribute("page", page);
		
		
		//开始学习存入学习课件ID和学习时间
		CourseStudy courseStudy = new CourseStudy();
		courseStudy.setCourseId(trainCourse.getId());
		courseStudy.setCreateBy(UserUtils.getUser());
		courseStudy = courseStudyService.findByCourseIdAndUserId(courseStudy);
		if(courseStudy==null){
			 courseStudy = new CourseStudy();
			courseStudy.setStatus("0");
			courseStudy.setCourseId(trainCourse.getId());
			Date study_start_time = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dateFormat.format(study_start_time);
			courseStudy.setStudyStartTime(study_start_time);
			courseStudyService.save(courseStudy);
		}else{
			courseStudy.setStatus("0");
			courseStudy.setCourseId(trainCourse.getId());
			Date study_start_time = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dateFormat.format(study_start_time);
			courseStudy.setStudyStartTime(study_start_time);
			courseStudy.preUpdate();
			courseStudyService.save(courseStudy);
		}
		
		
		
		return "modules/train_course/trainCourse3List";
	}

	@RequiresPermissions("train_course:trainCourse3:view")
	@RequestMapping(value = "form")
	public String form(TrainCourse trainCourse, Model model) {
		model.addAttribute("trainCourse", trainCourse);
		return "modules/train_course/trainCourse3Form";
	}

	@RequiresPermissions("train_course:trainCourse3:edit")
	@RequestMapping(value = "save")
	public String save(TrainCourse trainCourse, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainCourse)){
			
			return form(trainCourse, model);
		}
		trainCourseService.save(trainCourse);
		addMessage(redirectAttributes, "保存培训课件上传与查看成功");
		return "redirect:"+Global.getAdminPath()+"/train_course/trainCourse3/?repage";
	}
	
	@RequiresPermissions("train_course:trainCourse3:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainCourse trainCourse, RedirectAttributes redirectAttributes) {
		trainCourseService.delete(trainCourse);
		addMessage(redirectAttributes, "删除培训课件上传与查看成功");
		return "redirect:"+Global.getAdminPath()+"/train_course/trainCourse3/?repage";
	}

}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train_course.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServlet;
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
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;
import com.thinkgem.jeesite.modules.train_course.service.TrainCourseService;

/**
 * 培训课件Controller
 * @author 王少昌
 * @version 2017-05-17
 */
@Controller
@RequestMapping(value = "${adminPath}/train_course/trainCourse")
public class TrainCourseController extends BaseController {

	@Autowired
	private TrainCourseService trainCourseService;
	
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
	
	@RequiresPermissions("train_course:trainCourse:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainCourse trainCourse, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainCourse> page = trainCourseService.findPage(new Page<TrainCourse>(request, response), trainCourse); 
		model.addAttribute("page", page);
		return "modules/train_course/trainCourseList";
	}

	@RequiresPermissions("train_course:trainCourse:view")
	@RequestMapping(value = "form")
	public String form(TrainCourse trainCourse, Model model) {
		
		trainCourse.setUploadBy(UserUtils.getUser().getName());
		
		Date upload_time = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.format(upload_time);
		trainCourse.setUploadTime(upload_time);
		
		model.addAttribute("trainCourse", trainCourse);
		return "modules/train_course/trainCourseForm";
	}

	@RequiresPermissions("train_course:trainCourse:edit")
	@RequestMapping(value = "save")
	public String save(TrainCourse trainCourse, Model model, RedirectAttributes redirectAttributes, HttpServletRequest httpServletRequest) {
		if (!beanValidator(model, trainCourse)){
			return form(trainCourse, model);
		}
		trainCourseService.vedioConvert(trainCourse, httpServletRequest.getSession().getServletContext().getRealPath("/"));
		trainCourseService.save(trainCourse);
		addMessage(redirectAttributes, "保存培训课件上传与查看成功");
		return "redirect:"+Global.getAdminPath()+"/train_course/trainCourse/?repage";
	}
	
	@RequiresPermissions("train_course:trainCourse:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainCourse trainCourse, RedirectAttributes redirectAttributes) {
		trainCourseService.delete(trainCourse);
		addMessage(redirectAttributes, "删除培训课件上传与查看成功");
		return "redirect:"+Global.getAdminPath()+"/train_course/trainCourse/?repage";
	}

}
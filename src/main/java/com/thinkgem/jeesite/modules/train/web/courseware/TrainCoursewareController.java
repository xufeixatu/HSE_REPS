/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.web.courseware;

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
import com.thinkgem.jeesite.modules.train.entity.courseware.TrainCourseware;
import com.thinkgem.jeesite.modules.train.service.courseware.TrainCoursewareService;

/**
 * 培训课件Controller
 * @author peizhen
 * @version 2017-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/train/courseware/trainCourseware")
public class TrainCoursewareController extends BaseController {

	@Autowired
	private TrainCoursewareService trainCoursewareService;
	
	@ModelAttribute
	public TrainCourseware get(@RequestParam(required=false) String id) {
		TrainCourseware entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainCoursewareService.get(id);
		}
		if (entity == null){
			entity = new TrainCourseware();
		}
		return entity;
	}
	
	@RequiresPermissions("train:courseware:trainCourseware:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainCourseware trainCourseware, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainCourseware> page = trainCoursewareService.findPage(new Page<TrainCourseware>(request, response), trainCourseware); 
		model.addAttribute("page", page);
		return "modules/train/courseware/trainCoursewareList";
	}

	@RequiresPermissions("train:courseware:trainCourseware:view")
	@RequestMapping(value = "form")
	public String form(TrainCourseware trainCourseware, Model model) {
		model.addAttribute("trainCourseware", trainCourseware);
		return "modules/train/courseware/trainCoursewareForm";
	}

	@RequiresPermissions("train:courseware:trainCourseware:edit")
	@RequestMapping(value = "save")
	public String save(TrainCourseware trainCourseware, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainCourseware)){
			return form(trainCourseware, model);
		}
		trainCoursewareService.save(trainCourseware);
		addMessage(redirectAttributes, "保存培训课件成功");
		return "redirect:"+Global.getAdminPath()+"/train/courseware/trainCourseware/?repage";
	}
	
	@RequiresPermissions("train:courseware:trainCourseware:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainCourseware trainCourseware, RedirectAttributes redirectAttributes) {
		trainCoursewareService.delete(trainCourseware);
		addMessage(redirectAttributes, "删除培训课件成功");
		return "redirect:"+Global.getAdminPath()+"/train/courseware/trainCourseware/?repage";
	}

}
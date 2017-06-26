/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.web.matrix;

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
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainJob;
import com.thinkgem.jeesite.modules.train.service.matrix.TrainJobService;

/**
 * 培训岗位信息Controller
 * @author peizhen
 * @version 2017-05-17
 */
@Controller
@RequestMapping(value = "${adminPath}/train/matrix/trainJob")
public class TrainJobController extends BaseController {

	@Autowired
	private TrainJobService trainJobService;
	
	@ModelAttribute
	public TrainJob get(@RequestParam(required=false) String id) {
		TrainJob entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainJobService.get(id);
		}
		if (entity == null){
			entity = new TrainJob();
		}
		return entity;
	}
	
	@RequiresPermissions("train:matrix:trainJob:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainJob trainJob, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainJob> page = trainJobService.findPage(new Page<TrainJob>(request, response), trainJob); 
		model.addAttribute("page", page);
		return "modules/train/matrix/trainJobList";
	}

	@RequiresPermissions("train:matrix:trainJob:view")
	@RequestMapping(value = "form")
	public String form(TrainJob trainJob, Model model) {
		model.addAttribute("trainJob", trainJob);
		return "modules/train/matrix/trainJobForm";
	}

	@RequiresPermissions("train:matrix:trainJob:edit")
	@RequestMapping(value = "save")
	public String save(TrainJob trainJob, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainJob)){
			return form(trainJob, model);
		}
		trainJobService.save(trainJob);
		addMessage(redirectAttributes, "保存培训岗位成功");
		return "redirect:"+Global.getAdminPath()+"/train/matrix/trainJob/?repage";
	}
	
	@RequiresPermissions("train:matrix:trainJob:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainJob trainJob, RedirectAttributes redirectAttributes) {
		trainJobService.delete(trainJob);
		addMessage(redirectAttributes, "删除培训岗位成功");
		return "redirect:"+Global.getAdminPath()+"/train/matrix/trainJob/?repage";
	}

}
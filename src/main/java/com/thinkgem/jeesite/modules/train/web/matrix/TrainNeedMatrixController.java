/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.web.matrix;

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
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainContent;
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainJob;
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainNeedMatrix;
import com.thinkgem.jeesite.modules.train.service.matrix.TrainContentService;
import com.thinkgem.jeesite.modules.train.service.matrix.TrainJobService;
import com.thinkgem.jeesite.modules.train.service.matrix.TrainNeedMatrixService;

/**
 * 培训需求矩阵Controller
 * @author peizhen
 * @version 2017-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/train/matrix/trainNeedMatrix")
public class TrainNeedMatrixController extends BaseController {

	@Autowired
	private TrainNeedMatrixService trainNeedMatrixService;
	@Autowired
	private TrainJobService trainJobService;
	@Autowired
	private TrainContentService trainContentService;

	
		
	@ModelAttribute
	public TrainNeedMatrix get(@RequestParam(required=false) String id) {
		TrainNeedMatrix entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainNeedMatrixService.get(id);
		}
		if (entity == null){
			entity = new TrainNeedMatrix();
		}
		return entity;
	}
	@RequiresPermissions("train:matrix:trainNeedMatrix:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainNeedMatrix trainNeedMatrix, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainNeedMatrix> page = trainNeedMatrixService.findPage(new Page<TrainNeedMatrix>(request, response), trainNeedMatrix); 
		model.addAttribute("page", page);
		// 获取培训岗位列表
		List<TrainJob> trainJobList = trainJobService.findList(new TrainJob());
		model.addAttribute("trainJobList", trainJobList);
		// 获取培训知识内容列表
		List<TrainContent> trainContentList = trainContentService.findList(new TrainContent());
		model.addAttribute("trainContentList", trainContentList);
		return "modules/train/matrix/trainNeedMatrixList";
	}
	
	@RequiresPermissions("train:matrix:trainNeedMatrix:view")
	@RequestMapping(value = {"matrix"})
	public String matrix(TrainNeedMatrix trainNeedMatrix, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<TrainNeedMatrix> trainNeedMatrixList = trainNeedMatrixService.findList(trainNeedMatrix);
		model.addAttribute("trainNeedMatrixList", trainNeedMatrixList);
		// 获取培训岗位列表
		List<TrainJob> trainJobList = trainJobService.findList(new TrainJob());
		model.addAttribute("trainJobList", trainJobList);
		// 获取培训知识内容列表
		List<TrainContent> trainContentList = trainContentService.findList(new TrainContent());
		model.addAttribute("trainContentList", trainContentList);
		return "modules/train/matrix/trainNeedMatrix";
	}

	@RequiresPermissions("train:matrix:trainNeedMatrix:view")
	@RequestMapping(value = "form")
	public String form(TrainNeedMatrix trainNeedMatrix, Model model) {
		model.addAttribute("trainNeedMatrix", trainNeedMatrix);
		// 获取培训岗位列表
		List<TrainJob> trainJobList = trainJobService.findList(new TrainJob());
		model.addAttribute("trainJobList", trainJobList);
		// 获取培训知识内容列表
		List<TrainContent> trainContentList = trainContentService.findList(new TrainContent());
		model.addAttribute("trainContentList", trainContentList);
		return "modules/train/matrix/trainNeedMatrixForm";
	}

	@RequiresPermissions("train:matrix:trainNeedMatrix:edit")
	@RequestMapping(value = "save")
	public String save(TrainNeedMatrix trainNeedMatrix, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainNeedMatrix)){
			return form(trainNeedMatrix, model);
		}
		trainNeedMatrixService.save(trainNeedMatrix);
		addMessage(redirectAttributes, "保存培训需求成功");
		return "redirect:"+Global.getAdminPath()+"/train/matrix/trainNeedMatrix/?repage";
	}
	
	@RequiresPermissions("train:matrix:trainNeedMatrix:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainNeedMatrix trainNeedMatrix, RedirectAttributes redirectAttributes) {
		trainNeedMatrixService.delete(trainNeedMatrix);
		addMessage(redirectAttributes, "删除培训需求成功");
		return "redirect:"+Global.getAdminPath()+"/train/matrix/trainNeedMatrix/?repage";
	}

}
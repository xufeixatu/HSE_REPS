/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.web.record;

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
import com.thinkgem.jeesite.modules.train.entity.plan.TrainPlan;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecord;
import com.thinkgem.jeesite.modules.train.service.plan.TrainPlanService;
import com.thinkgem.jeesite.modules.train.service.record.TrainRecordService;

/**
 * 培训记录Controller
 * @author peizhen
 * @version 2017-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/train/record/trainRecord")
public class TrainRecordController extends BaseController {

	@Autowired
	private TrainRecordService trainRecordService;
	@Autowired
	private TrainPlanService trainPlanService;
	
	@ModelAttribute
	public TrainRecord get(@RequestParam(required=false) String id) {
		TrainRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainRecordService.get(id);
		}
		if (entity == null){
			entity = new TrainRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("train:record:trainRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainRecord trainRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainRecord> page = trainRecordService.findPage(new Page<TrainRecord>(request, response), trainRecord); 
		model.addAttribute("page", page);
		
		//选择有培训计划
		List<TrainPlan> trainPlanList = trainPlanService.findList(new TrainPlan());
		model.addAttribute("trainPlanList", trainPlanList);
		
		return "modules/train/record/trainRecordList";
	}

	@RequiresPermissions("train:record:trainRecord:view")
	@RequestMapping(value = "form")
	public String form(TrainRecord trainRecord, Model model) {
		
		//选择有培训计划
		List<TrainPlan> trainPlanList = trainPlanService.findList(new TrainPlan());
		model.addAttribute("trainPlanList", trainPlanList);
		
		model.addAttribute("trainRecord", trainRecord);
		return "modules/train/record/trainRecordForm";
	}

	@RequiresPermissions("train:record:trainRecord:edit")
	@RequestMapping(value = "save")
	public String save(TrainRecord trainRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainRecord)){
			return form(trainRecord, model);
		}
		trainRecordService.save(trainRecord);
		addMessage(redirectAttributes, "保存培训记录成功");
		return "redirect:"+Global.getAdminPath()+"/train/record/trainRecord/?repage";
	}
	
	@RequiresPermissions("train:record:trainRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainRecord trainRecord, RedirectAttributes redirectAttributes) {
		trainRecordService.delete(trainRecord);
		addMessage(redirectAttributes, "删除培训记录成功");
		return "redirect:"+Global.getAdminPath()+"/train/record/trainRecord/?repage";
	}

}
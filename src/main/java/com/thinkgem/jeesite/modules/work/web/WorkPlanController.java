/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;
import com.thinkgem.jeesite.modules.work.entity.WorkType;
import com.thinkgem.jeesite.modules.work.service.WorkPlanService;

/**
 * 工作计划管理Controller
 * @author 何其锟
 * @version 2017-04-05
 */
@Controller
@RequestMapping(value = "${adminPath}/work/workPlan")
public class WorkPlanController extends BaseController {

	@Autowired
	private WorkPlanService workPlanService;
	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute
	public WorkPlan get(@RequestParam(required=false) String id) {
		WorkPlan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = workPlanService.get(id);
		}
		if (entity == null){
			entity = new WorkPlan();
		}
		return entity;
	}
	
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"list", ""})
	public String list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WorkPlan> page = workPlanService.findPage(new Page<WorkPlan>(request, response), workPlan); 
		model.addAttribute("page", page);
		return "modules/work/workPlanList";
	}

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "form")
	public String form(WorkPlan workPlan, Model model) {
		List<Office> depts = officeService.findAll();
		model.addAttribute("workPlan", workPlan);
		model.addAttribute("depts",depts);
		return "modules/work/workPlanForm";
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "save")
	public String save(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, workPlan)){
			return form(workPlan, model);
		}
		workPlanService.save(workPlan);
		addMessage(redirectAttributes, "保存工作计划成功");
		return "redirect:"+Global.getAdminPath()+"/work/workPlan/?repage";
	}
	
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "delete")
	public String delete(WorkPlan workPlan, RedirectAttributes redirectAttributes) {
		workPlanService.delete(workPlan);
		addMessage(redirectAttributes, "删除工作计划成功");
		return "redirect:"+Global.getAdminPath()+"/work/workPlan/?repage";
	}

	
}
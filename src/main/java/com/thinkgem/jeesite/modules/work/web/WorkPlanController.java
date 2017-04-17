/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;
import com.thinkgem.jeesite.modules.work.service.WorkPlanService;
import com.thinkgem.jeesite.modules.work.service.WorkTypeService;
import com.thinkgem.jeesite.modules.work.workSqlMapFilter.WorkPlanSqlMapFilter;

/**
 * 工作计划管理Controller
 * 
 * @author 何其锟
 * @version 2017-04-07
 */
@Controller
@RequestMapping(value = "${adminPath}/work/workPlan")
public class WorkPlanController extends BaseController {

	@Autowired
	private WorkPlanService workPlanService;

	@Autowired
	private WorkTypeService workTypeService;

	@ModelAttribute
	public WorkPlan get(@RequestParam(required = false) String id) {
		WorkPlan entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = workPlanService.get(id);
		}
		if (entity == null) {
			entity = new WorkPlan();
		}
		return entity;
	}

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "list", "" })
	public String list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 根据工作计划中的计划类别（个人计划，部门计划，公司计划）生成过滤条件保存在sqlMap.dsf中
		WorkPlanSqlMapFilter.getFilter().typePersonFilterSqlMapDsf(workPlan, model);

		List<WorkPlan> list = workPlanService.findList(workPlan);

		model.addAttribute("list", list);
		return "modules/work/workPlanList";
	}

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "workList" })
	public String workList(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		if("personal".equals(workPlan.getPlanType())){
			WorkPlanSqlMapFilter.getFilter().typeliableFilter(workPlan, model);
		}else if("department".equals(workPlan.getPlanType())){
			WorkPlanSqlMapFilter.getFilter().typeDeptFilter(workPlan, model);
		}else if("company".equals(workPlan.getPlanType())){
			WorkPlanSqlMapFilter.getFilter().typeCompnayFilter(workPlan, model);
		}
		
		

		List<WorkPlan> list = workPlanService.findList(workPlan);

		model.addAttribute("list", list);
		return "modules/work/exec/workPlanExecList";
	}

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "form")
	public String form(WorkPlan workPlan, Model model) {
		// 根据工作计划中的计划类别（个人计划，部门计划，公司计划）生成过滤条件保存在sqlMap.dsf中
		WorkPlanSqlMapFilter.getFilter().typePersonFilterSqlMapDsf(workPlan, model);

		if (workPlan.getParent() != null && StringUtils.isNotBlank(workPlan.getParent().getId())) {
			workPlan.setParent(workPlanService.get(workPlan.getParent().getId()));
			// 获得工作计划的完整工作类型
			if (workPlan.getWorkType() != null && StringUtils.isNotBlank(workPlan.getWorkType().getId())) {
				workPlan.setWorkType(workTypeService.get(workPlan.getWorkType().getId()));
			}
			// 获得工作计划的完整责任人
			if (workPlan.getPersonLiable() != null && StringUtils.isNotBlank(workPlan.getPersonLiable().getId())) {
				workPlan.setPersonLiable(UserUtils.get(workPlan.getPersonLiable().getId()));
			}

			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(workPlan.getId())) {
				WorkPlan workPlanChild = new WorkPlan();
				workPlanChild.setParent(new WorkPlan(workPlan.getParent().getId()));
				List<WorkPlan> list = workPlanService.findList(workPlan);
				if (list.size() > 0) {
					workPlan.setSort(list.get(list.size() - 1).getSort());
					if (workPlan.getSort() != null) {
						workPlan.setSort(workPlan.getSort() + 30);
					}
				}
			}
		}
		if (workPlan.getSort() == null) {
			workPlan.setSort(30);
		}

		model.addAttribute("workPlan", workPlan);
		return "modules/work/workPlanForm";
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "save")
	public String save(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
		// 保存当前工作类别（个人，公司，部门等类别）的数据字典对象
		Dict planTypeDict = DictUtils.getDictByID(workPlan.getPlanType());
		// 如何个人工作计划，直接把当前用户所在部门设置到工作计划中
		if ("personal".equals(planTypeDict.getValue())) {
			workPlan.setDepts(UserUtils.getUser().getOffice());
		}

		if (!beanValidator(model, workPlan)) {
			workPlan.setPlanType(planTypeDict.getValue());
			return form(workPlan, model);
		}
		workPlanService.save(workPlan);
		addMessage(redirectAttributes, "保存工作计划成功");

		return "redirect:" + Global.getAdminPath() + "/work/workPlan/?repage&planType=" + planTypeDict.getValue();
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "delete")
	public String delete(WorkPlan workPlan, RedirectAttributes redirectAttributes) {
		workPlanService.delete(workPlan);
		addMessage(redirectAttributes, "删除工作计划成功");
		return "redirect:" + Global.getAdminPath() + "/work/workPlan/?repage";
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "upload")
	public String upload(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {

		return "modules/work/workPlanForm";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required = false) String extId,
			HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<WorkPlan> list = workPlanService.findList(new WorkPlan());
		for (int i = 0; i < list.size(); i++) {
			WorkPlan e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId != null && !extId.equals(e.getId())
					&& e.getParentIds().indexOf("," + extId + ",") == -1)) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}

}
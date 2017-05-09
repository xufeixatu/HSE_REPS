/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.web;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.OfficeUtil;
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
	/**
	 * 保存在model中的工作计划类别（个人，公司，部门等类别）数据字典对象的键
	 */
	private final static String PLAN_TYPE_DICT_KEY = "planTypeDict";

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
		if ("personal".equals(workPlan.getPlanType())) {
			WorkPlanSqlMapFilter.getFilter().typeliableFilter(workPlan, model);
		} else if ("department".equals(workPlan.getPlanType())) {
			WorkPlanSqlMapFilter.getFilter().typeDeptFilter(workPlan, model);
		} else if ("company".equals(workPlan.getPlanType())) {
			WorkPlanSqlMapFilter.getFilter().typeCompnayFilter(workPlan, model);
		}

		List<WorkPlan> list = workPlanService.findList(workPlan);

		model.addAttribute("list", list);
		return "modules/work/exec/workPlanExecuteList";
	}

	/**
	 * 查询待受理工作
	 * 
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "remain_list" })
	public String remain_list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		/**
		 * 过滤出所有待受理状态的公司级工作计划
		 */
		WorkPlanSqlMapFilter.getFilter().typeRemainCompanyWorkPlanyFilter(workPlan, model);
		List<WorkPlan> list = workPlanService.findList(workPlan);
		/**
		 * 查出当前登陆人任负责人的部门
		 */
		User cu = UserUtils.getUser();
		workPlan.setUserId(cu.getId());
		List<Office> cos = OfficeUtil.getCurrentUserOfficeById(workPlan);

		/**
		 * 找出指派单位是当前登陆人负责的部门的工作置入列表
		 */
		Set<WorkPlan> lst = new HashSet<WorkPlan>();
		for (WorkPlan wrkPln : list) {
			for (Office o : cos) {
				if (wrkPln.getDepts().getId().contains(o.getId())) {
					// 判断在受理表中当前用户未受理过该工作再添加进待审核列表
					if (workPlanService.remainsCount(wrkPln.getId(), cu.getId(), o.getId()) == 0) {
						wrkPln.setCurrentRemainDeptId(o.getId());
						lst.add(wrkPln);
					}
				}
			}
		}
		model.addAttribute("list", lst);
		return "modules/work/exec/workRemainList";
	}

	/**
	 * 进入受理工作表单
	 * 
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "remain_form" })
	public String remain_form(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);

		WorkPlan wpn = workPlanService.get(workPlan.getId());
		wpn.setCurrentRemainDeptId(workPlan.getCurrentRemainDeptId());
		model.addAttribute("workPlan", wpn);
		return "modules/work/exec/workRemainForm";
	}

	/**
	 * 已受理工作列表
	 * 
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "remainned_list" })
	public String remainned_list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		List<WorkPlan> list = workPlanService.findRemainnedWorkPlanList(UserUtils.getUser().getId());

		model.addAttribute("list", list);
		return "modules/work/exec/workRemainnedList";
	}

	/**
	 * 受理(修改end_state为"已受理"状态)工作
	 * 
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "remain_save" })
	public String remain_save(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response,
			Model model) {

		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		workPlanService.remain(workPlan);
		return "redirect:" + Global.getAdminPath() + "/work/workPlan/remain_list?repage&planType=company";
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
			// 如果责任部门为空并且当前计划类型是部门则指定责任部门为当前用户所在部门
			if (workPlan.getDepts() == null && workPlan.getPlanType().equals("department")) {
				workPlan.setDepts(UserUtils.getUser().getOffice());
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

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "exec_form")
	public String exec_form(WorkPlan workPlan, Model model) {
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
			// 如果责任部门为空并且当前计划类型是部门则指定责任部门为当前用户所在部门
			if (workPlan.getDepts() == null && workPlan.getPlanType().equals("department")) {
				workPlan.setDepts(UserUtils.getUser().getOffice());
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
		return "modules/work/exec/workPlanForm";
	}

	
	/**
	 * 进入分配公司工作给部门的表单
	 * 
	 * @param workPlan
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "assigned_work")
	public String assigned_work(WorkPlan workPlan, Model model) {

		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);

		workPlan = workPlanService.get(workPlan.getId());

		model.addAttribute("workPlan", workPlan);
		return "modules/work/assignedWorkForm";
	}

	/**
	 * 分配任务给部门
	 * 
	 * @param workPlan
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "assigned")
	public String assigned(WorkPlan workPlan, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		workPlanService.asigned(workPlan);
		workPlan = new WorkPlan();
		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_list?playType=compnay";// "modules/work/exec/workPendingList";
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "submitPlan")
	public String submitPlan(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		String[] ids = request.getParameterValues("ids");
		if (ids != null && ids.length > 0) {
			for (String id : ids) {
				WorkPlan w = new WorkPlan();
				w.setId(id);
				workPlanService.submit_company_plan(w);// 提交计划
			}
		} else {
			workPlanService.submit_company_plan(workPlan);// 提交计划
		}
		WorkPlan wp = new WorkPlan();
		wp.setPlanType(workPlan.getPlanType());
		return list(wp, request, response, model);
	}

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "detail")
	public String detail(WorkPlan workPlan, Model model) {
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
		return "modules/work/exec/workPlanDetail";
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "save")
	public String save(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
		// 保存当前工作类别（个人，公司，部门等类别）的数据字典对象
		Dict planTypeDict = DictUtils.getDictByID(workPlan.getPlanType());
		// 如何个人工作计划，直接把当前用户所在部门设置到工作计划中
		if ("personal".equals(planTypeDict.getValue()) || "department".equals(planTypeDict.getValue())) {
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
	@RequestMapping(value = "pending_save")
	public String pending_save(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
		save(workPlan, model, redirectAttributes);
		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_list?repage&id=" + workPlan.getId()
				+ "&repage&planType=company";
	}

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "pending_list" })
	public String pending_list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		/**
		 * 过滤出所有已提交状态的公司级工作计划
		 */
		WorkPlanSqlMapFilter.getFilter().typeSubmittedCompanyWorkPlanyFilter(workPlan, model);

		List<WorkPlan> list = workPlanService.findList(workPlan);

		model.addAttribute("list", list);
		System.out.println("redirect:" + Global.getAdminPath() + "/work/exec/workPendingList?repage&planType=company");
		return "modules/work/exec/workPendingList";
	}

	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "pending_form")
	public String pending_form(WorkPlan workPlan, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);

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
		return "modules/work/exec/workPendingForm";
	}

	/**
	 * 审核拒绝的方法（还未实现）
	 * 
	 * @param workPlan
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "reject")
	public String reject(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
		workPlanService.reject(workPlan);

		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_list?repage&planType=company";
	}

	/**
	 * 审核同意的方法（还未实现）
	 * 
	 * @param workPlan
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "agree")
	public String agree(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
		workPlanService.agree(workPlan);
		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_list?repage&planType=company";
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
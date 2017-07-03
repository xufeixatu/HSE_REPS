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
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
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

	/**
	 * 进入工作计划页面
	 * 
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "index" })
	public String index(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);

		return "modules/work/workIndex";
	}

	/**
	 * 我负责工作的列表
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "myResponsibleList"})
	public String myResponsibleList(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 根据责任人查询我负责的工作
		WorkPlanSqlMapFilter.getFilter().typeMyWorkPlanFilterSqlMapDsf(workPlan, model);
		
		List<WorkPlan> list = workPlanService.findList(workPlan);

		model.addAttribute("list", list);
		model.addAttribute("myType","responsible");
		return "modules/work/workPlanList";
	}
	
	/**
	 * 我负责工作的列表
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "myAssignedList"})
	public String myAssignedList(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 根据创建人是我并且工作状态为审核通过的工作
		WorkPlanSqlMapFilter.getFilter().typeMyAssignedFilterSqlMapDsf(workPlan, model);
		
		List<WorkPlan> list = workPlanService.findList(workPlan);

		model.addAttribute("list", list);
		model.addAttribute("myType","assigned");
		return "modules/work/workPlanList";
	}
	
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = { "list", "" })
	public String list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		// 根据工作计划中的计划类别（个人计划，部门计划，公司计划）生成过滤条件保存在sqlMap.dsf中
		WorkPlanSqlMapFilter.getFilter().typePersonFilterSqlMapDsf(workPlan, model);
		
		// 根据工作计划中的分类生成过滤条件
		if (workPlan.getWorkType() != null) {
			WorkPlanSqlMapFilter.getFilter().typeWorkTypeFilterSqlMapDsf(workPlan, model);
		}
		List<WorkPlan> list = workPlanService.findList(workPlan);
		
		model.addAttribute("list", list);
		return "modules/work/workPlanList";
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "save")
	public String save(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
		// 保存当前工作类别（个人，公司，部门等类别）的数据字典对象
		Dict planTypeDict = DictUtils.getDictByID(workPlan.getPlanType());
		// 如何个人工作计划，直接把当前用户所在部门设置到工作计划中
		if ("personal".equals(planTypeDict.getValue()) || "department".equals(planTypeDict.getValue()) || "action".equals(planTypeDict.getValue())) {
			workPlan.setDepts(UserUtils.getUser().getOffice());
		}
		// 个人工作计划和个人行动计划的责任人是自己
		if("personal".equals(planTypeDict.getValue()) || "action".equals(planTypeDict.getValue())){
			workPlan.setPersonLiable(UserUtils.getUser());
		}
		if (!beanValidator(model, workPlan)) {
			workPlan.setPlanType(planTypeDict.getValue());
			return form(workPlan, model);
		}
		workPlanService.save(workPlan);
		addMessage(redirectAttributes, "保存工作计划成功");

		return "redirect:" + Global.getAdminPath() + "/work/workPlan/?repage&planType=" + planTypeDict.getValue();
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
			// 把当前用户设置为工作计划指派人
			workPlan.setAssignerId(UserUtils.getUser().getId());
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
	@RequestMapping(value = "workPlanDetail")
	public String workPlanDetail(WorkPlan workPlan, Model model) {
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
			// 把当前用户设置为工作计划指派人
			workPlan.setAssignerId(UserUtils.getUser().getId());
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
		return "modules/work/workPlanDetail";
	}

	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "submitPlan")
	public String submitPlan(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
		
		String[] ids = request.getParameterValues("ids");
		if (ids != null && ids.length > 0) {
			for (String id : ids) {
				WorkPlan w = new WorkPlan();
				w.setId(id);
				workPlanService.submit_plan(w);// 提交计划
			}
		} else {
			workPlanService.submit_plan(workPlan);// 提交计划
		}
		addMessage(redirectAttributes, "提交工作计划'" + workPlan.getName() + "'成功");
		WorkPlan wp = new WorkPlan();
		wp.setPlanType(workPlan.getPlanType());
		
		return list(wp, request, response, model);
	}
	
	/**
	 * 分配工作给责任人
	 * 
	 * @param workPlan
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = "assigne_work")
	public String assigne_work(WorkPlan workPlan, Model model, HttpServletRequest request, HttpServletResponse response) {

		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		
		if(workPlan.getParent() != null && !"0".equals(workPlan.getParent().getId()) && (request.getParameter("child") == null || "".equals(request.getParameter("child")))){
			return "modules/work/assignedWorkForm";
		}
		workPlanService.assigne(workPlan);
		model.addAttribute("workPlan", workPlan);
		WorkPlan wp = new WorkPlan();
		if("true".equals(request.getParameter("child"))){
			workPlanService.updatepersonLiable(workPlan.getPersonLiable().getId(),workPlan.getId());
			wp.setPlanType(DictUtils.getDictByID(workPlan.getPlanType()).getValue());
		}else{
			wp.setPlanType(workPlan.getPlanType());
		}
		
		return list(wp, request, response, model);
		
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

		return "modules/work/workRemainForm";
	}
	
	
	/**
	 * 工作受理
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"remain_save"})
	public String remain_save(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		
		workPlanService.remain(workPlan);
		
		return "modules/work/list";
	}

	
	/**
	 * 进入工作反馈表单
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"discuss_form"})
	public String discuss_form(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		
		List<WorkPlan> discusses = workPlanService.findDiscusses(workPlan.getRemainId());
		model.addAttribute("discusses",discusses);
		return "modules/work/discussForm";
	}
	
	/**
	 * 讨论保存
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = {"discuss_save"})
	public String discuss_save(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		workPlanService.feedbackSave(workPlan.getRemainId(),workPlan.getNewReply(),UserUtils.getUser().getId(),workPlan.getType());
		return discuss_form(workPlan, request, response, model);
	}
	
	/**
	 * 关闭工作
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"close_work"})
	public String close_work(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		workPlanService.closeWorkPlan(workPlan.getId());
		return list(workPlan, request, response, model);
	}
	
	/**
	 * 催办工作
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"urge_work"})
	public String urge_work(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		workPlanService.closeWorkPlan(workPlan.getId());
		return list(workPlan, request, response, model);
	}
	
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = { "workList" })
//	public String workList(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		if ("personal".equals(workPlan.getPlanType())) {
//			WorkPlanSqlMapFilter.getFilter().typeliableFilter(workPlan, model);
//		} else if ("department".equals(workPlan.getPlanType())) {
//			WorkPlanSqlMapFilter.getFilter().typeDeptFilter(workPlan, model);
//		} else if ("company".equals(workPlan.getPlanType())) {
//			WorkPlanSqlMapFilter.getFilter().typeCompnayFilter(workPlan, model);
//		}
//
//		List<WorkPlan> list = workPlanService.findList(workPlan);
//
//		model.addAttribute("list", list);
//		return "modules/work/workPlanList";
//	}

	
	
	
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

//	/**
//	 * 进入分配公司工作给部门的表单
//	 * 
//	 * @param workPlan
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = "assigned_work")
//	public String assigned_work(WorkPlan workPlan, Model model) {
//
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//
//		workPlan = workPlanService.get(workPlan.getId());
//
//		model.addAttribute("workPlan", workPlan);
//		return "modules/work/assignedWorkForm";
//	}

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
		workPlanService.assigne(workPlan);
		workPlan = new WorkPlan();
		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_list?playType=compnay";// "modules/work/exec/workPendingList";
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
	
	

	/**
	 * 导出用户数据
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<WorkPlan> data = workPlanService.findList(new WorkPlan());
			new ExportExcel("用户数据", WorkPlan.class).setDataList(data).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/work/workPlan/list?planType=" + request.getParameter("planType") + "&repage";
	}

	/**
	 * 导入用户数据
	 * 
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(HttpServletRequest request, MultipartFile file, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/work/workPlan/list?repage";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<WorkPlan> list = ei.getDataList(WorkPlan.class);
			for (WorkPlan workPlan : list) {
				try {
					workPlanService.save(workPlan);
					successNum++;
				} catch (ConstraintViolationException ex) {
					failureMsg.append("<br/>工作任务 " + workPlan.getName() + " 导入失败：");
					List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList) {
						failureMsg.append(message + "; ");
						failureNum++;
					}
				} catch (Exception ex) {
					failureMsg.append("<br/>工作任务 " + workPlan.getName() + " 导入失败：" + ex.getMessage());
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条工作任务，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条工作任务" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入工作计划失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/work/workPlan/list?planType=" + request.getParameter("planType") + "&repage";
	}

	/**
	 * 下载导入用户数据模板
	 * 
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "工作计划数据导入模板.xlsx";
			List<WorkPlan> list = Lists.newArrayList();
			WorkPlan wp = workPlanService.findList(new WorkPlan()).get(0);
			list.add(wp);
			new ExportExcel("工作任务数据", WorkPlan.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			System.out.println("导入模板下载失败！失败信息：" + e.getMessage());
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/work/workPlan/list?planType=" + request.getParameter("planType") + "&repage";
	}

	/**
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ****************************************************** *
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * ******************************************************
	 * 
	 * @param workPlan
	 * @param model
	 * @return
	 */
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
		return "redirect:" + Global.getAdminPath() + "/work/workPlan/?planType=" + workPlan.getPlanType() + "&repage";
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

	// <<<<<<< HEAD
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
}
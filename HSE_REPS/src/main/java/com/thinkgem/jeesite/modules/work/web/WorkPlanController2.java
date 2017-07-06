/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.web;

import java.util.Date;
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
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;
import com.thinkgem.jeesite.modules.work.service.WorkPlanService;
import com.thinkgem.jeesite.modules.work.workSqlMapFilter.WorkPlanSqlMapFilter;

/**
 * 工作计划管理Controller
 * 
 * @author 何其锟
 * @version 2017-04-07
 */
@Controller
@RequestMapping(value = "${adminPath}/work/workPlan2")
public class WorkPlanController2 extends BaseController {
	/**
	 * 保存在model中的工作计划类别（个人，公司，部门等类别）数据字典对象的键
	 */
	//private final static String PLAN_TYPE_DICT_KEY = "planTypeDict";

	@Autowired
	private WorkPlanService workPlanService;

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
	 * 进入工作受理的表单页
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"my_asigned_work_list"})
	public String my_asigned_work_list(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		
		return "modules/work/workIndex";
	}
	
	/**
	 * 进入工作受理的表单页
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"remain_form"})
	public String remain_form(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		
		return "modules/work/remainForm";
	}
	
	/**
	 * 部门工作受理
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
		
		workPlan.setDepts(UserUtils.getUser().getOffice());
		workPlanService.remain(workPlan);
		
		return "modules/work/workPlanList";
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
	@RequestMapping(value = {"feedback_form"})
	public String feedback_form(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		WorkPlan wpn = workPlanService.get(workPlan.getId());
		wpn.setCurrentRemainDeptId(workPlan.getCurrentRemainDeptId());
		wpn.setRemainId(workPlan.getRemainId());
		model.addAttribute("workPlan",wpn);
		
		return "modules/work/feedbackForm";
	}
	
	/**
	 * 部门工作反馈保存
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:edit")
	@RequestMapping(value = {"feedback_save"})
	public String feedback_save(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		workPlanService.feedbackSave(workPlan.getRemainId(),workPlan.getFeedbackDesc(),UserUtils.getUser().getId());
		return "redirect:" + Global.getAdminPath() + "/work/workPlan2/dept_remainned_list?repage&planType=company";
	}
	
	
	/**
	 * 查看一条部门工作记录的一条受理信息的所有反馈列表
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"feedback_list"})
	public String feedback_list(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		List<WorkPlan> list  = workPlanService.findWorkPlanRemainAllFeedback(workPlan.getId(),workPlan.getRemainId()); 
		model.addAttribute("list", list);
		return "modules/work/feedbackList"; 
	}
	
	/**
	 * 查看一条部门工作记录的一个受理的一个工作反馈的所有回复列表
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"reply_list"})
	public String reply_list(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		List<WorkPlan> list  = workPlanService.findWorkPlanRemainFeedbackAllRefly(workPlan.getId(),workPlan.getRemainId(),workPlan.getFeedbackId());
		model.addAttribute("list", list);
		return "modules/work/reply_list";
	}
	
	/**
	 * 回复已反馈待关闭部门工作
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"replay_save"})
	public String replay_save(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		//保存反馈的回复信息
		workPlanService.saveRemainFeedbackReplay(workPlan.getFeedbackId(),workPlan.getReplyContent(),UserUtils.getUser().getId());
		
		return "modules/work/exec/deptRemainFeedbackList";
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
		return "redirect:" + Global.getAdminPath() + "/work/workPlan2/work_list?planType=department";
	}
	
	

	
	/**
	 * 进入已关闭已受理反馈部门工作点评表单
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"comment_form"})
	public String comment_form(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		model.addAttribute("workPlan", workPlan);
		return "modules/work/exec/deptWorkplanCommentForm";
	}
	
	/**
	 * 对已关闭已受理反馈部门工作点评
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"comment_save"})
	public String comment_save(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		
		workPlanService.commentSave(UserUtils.getUser().getId(),workPlan.getRemainId(),workPlan.getCommentContent(),workPlan.getScore());
		
		return "redirect:" + Global.getAdminPath() + "/work/workPlan2/dept_closed_remain_feedback_list?planType=department";
	}
	
	/**
	 * 查询工作点评
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"comment_detail"})
	public String comment_detail(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		WorkPlan wln = workPlanService.findComment(workPlan.getRemainId());
		model.addAttribute("workPlan", wln);
		return "modules/work/exec/deptWorkplanCommentDetail";
	}
	
	/**
	 * 进入工作回复的表单
	 * @param workPlan
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("work:workPlan:view")
	@RequestMapping(value = {"reply_form"})
	public String reply_form(WorkPlan workPlan, HttpServletRequest request, 
			HttpServletResponse response, Model model) {
		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
		
//		WorkPlan wpn = workPlanService.findClosingReply(userid)
//		wpn.setCurrentRemainDeptId(workPlan.getCurrentRemainDeptId());
//		wpn.setRemainId(workPlan.getRemainId());
//		model.addAttribute("workPlan",wpn);
		return "modules/work/replyForm";
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
	

//	/**
//	 * 待关闭受理工作反馈列表
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"remainned_feedback_list"})
//	public String remainned_feedback_list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		/**
//		 * 查找 已受理的受理状态为已处理的反馈记录且反馈记录的已回复状态（isReply）为否(false)且工作的指派人为当前用户的工作、受理及最新反馈信息列表
//		 *     列表字段包括：
//		 *     
//		 */
//		List<WorkPlan> list = workPlanService.findClosingReply(UserUtils.getUser().getId());
//		model.addAttribute("list",list);
//		return "modules/work/exec/workRemainnedFeedbackList";
//	}	
	
//	/**
//	 * 进入已关闭已受理反馈部门工作列表
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"dept_closed_remainned_feedback_list"})
//	public String dept_closed_remainned_feedback_list(WorkPlan workPlan, HttpServletRequest request, 
//			HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		//查找已关闭的工作列表
//		List<WorkPlan> list = workPlanService.findAllClosedRemainWorkPlan(UserUtils.getUser().getOffice().getId(),DictUtils.getDictByValue("department", "type_plan").getId());
//		model.addAttribute("list", list);
//		return "modules/work/exec/deptClosedRemainFeedbackList";
//	}
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = { "list", "" })
//	public String list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		// 根据工作计划中的计划类别（个人计划，部门计划，公司计划）生成过滤条件保存在sqlMap.dsf中
//
//		WorkPlanSqlMapFilter.getFilter().typePersonFilterSqlMapDsf(workPlan, model);
//
//		List<WorkPlan> list = workPlanService.findList(workPlan);
//
//		model.addAttribute("list", list);
//		return "modules/work/workPlanList";
//	}
//
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = { "workList" })
//	public String workList(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		if("personal".equals(workPlan.getPlanType())){
//			WorkPlanSqlMapFilter.getFilter().typeliableFilter(workPlan, model);
//		}else if("department".equals(workPlan.getPlanType())){
//			WorkPlanSqlMapFilter.getFilter().typeDeptFilter(workPlan, model);
//		}else if("company".equals(workPlan.getPlanType())){
//			WorkPlanSqlMapFilter.getFilter().typeCompnayFilter(workPlan, model);
//		}
//
//		List<WorkPlan> list = workPlanService.findList(workPlan);
//
//		model.addAttribute("list", list);
//		return "modules/work/exec/workPlanExecList";
//	}
//	
//	/**
//	 * 查询待受理工作
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"remain_list"})
//	public String remain_list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		/**
//		 *	过滤出所有待受理状态的公司级工作计划
//		 */
//		WorkPlanSqlMapFilter.getFilter().typeRemainCompanyWorkPlanyFilter(workPlan, model);
//		List<WorkPlan> list = workPlanService.findList(workPlan);
//		/**
//		 * 查出当前登陆人任负责人的部门
//		 */
//		User cu = UserUtils.getUser();
//		workPlan.setUserId(cu.getId());
//		List<Office> cos = OfficeUtil.getCurrentUserOfficeById(workPlan);
//		
//		/**
//		 * 找出指派单位是当前登陆人负责的部门的工作置入列表
//		 */
//		Set<WorkPlan> lst = new HashSet<WorkPlan>();
//		for(WorkPlan wrkPln : list){
//			for(Office o : cos){
//				if(wrkPln.getDepts().getId().contains(o.getId())){
//					//判断在受理表中当前用户未受理过该工作再添加进待审核列表
//					if(workPlanService.remainsCount(wrkPln.getId(),cu.getId(),o.getId()) == 0){
//						wrkPln.setCurrentRemainDeptId(o.getId());
//						lst.add(wrkPln);
//					}
//				}
//			}
//		}
//		model.addAttribute("list", lst);
//		return "modules/work/exec/workRemainList";
//	}
//	
//	/**
//	 * 进入受理工作表单
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"remain_form"})
//	public String remain_form(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		
//		WorkPlan wpn = workPlanService.get(workPlan.getId());
//		wpn.setCurrentRemainDeptId(workPlan.getCurrentRemainDeptId());
//		model.addAttribute("workPlan",wpn);
//		return "modules/work/exec/workRemainForm";
//	}
//	
//	/**
//	 * 已受理工作列表
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"remainned_list"})
//	public String remainned_list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		List<WorkPlan> list = workPlanService.findRemainnedWorkPlanList(UserUtils.getUser().getId());
//		
//		model.addAttribute("list", list);
//		return "modules/work/exec/workRemainnedList";
//	}
//	
//	
//	/**
//	 * 受理(修改end_state为"已受理"状态)工作
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"remain_save"})
//	public String remain_save(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		workPlanService.remain(workPlan);
//		return "redirect:" + Global.getAdminPath() + "/work/workPlan/remain_list?repage&planType=company";
//	}
//	
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = "form")
//	public String form(WorkPlan workPlan, Model model) {
//		// 根据工作计划中的计划类别（个人计划，部门计划，公司计划）生成过滤条件保存在sqlMap.dsf中
//		WorkPlanSqlMapFilter.getFilter().typePersonFilterSqlMapDsf(workPlan, model);
//
//		if (workPlan.getParent() != null && StringUtils.isNotBlank(workPlan.getParent().getId())) {
//			workPlan.setParent(workPlanService.get(workPlan.getParent().getId()));
//			// 获得工作计划的完整工作类型
//			if (workPlan.getWorkType() != null && StringUtils.isNotBlank(workPlan.getWorkType().getId())) {
//				workPlan.setWorkType(workTypeService.get(workPlan.getWorkType().getId()));
//			}
//			// 获得工作计划的完整责任人
//			if (workPlan.getPersonLiable() != null && StringUtils.isNotBlank(workPlan.getPersonLiable().getId())) {
//				workPlan.setPersonLiable(UserUtils.get(workPlan.getPersonLiable().getId()));
//			}
//
//			// 获取排序号，最末节点排序号+30
//			if (StringUtils.isBlank(workPlan.getId())) {
//				WorkPlan workPlanChild = new WorkPlan();
//				workPlanChild.setParent(new WorkPlan(workPlan.getParent().getId()));
//				List<WorkPlan> list = workPlanService.findList(workPlan);
//				if (list.size() > 0) {
//					workPlan.setSort(list.get(list.size() - 1).getSort());
//					if (workPlan.getSort() != null) {
//						workPlan.setSort(workPlan.getSort() + 30);
//					}
//				}
//			}
//		}
//		if (workPlan.getSort() == null) {
//			workPlan.setSort(30);
//		}
//
//		model.addAttribute("workPlan", workPlan);
//		return "modules/work/workPlanForm";
//	}
//	/**
//	 * 进入分配公司工作给部门的表单
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
//	
//	/**
//	 * 分配任务给部门
//	 * @param workPlan
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = "assigned")
//	public String assigned(WorkPlan workPlan, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		workPlanService.asigned(workPlan);
//		workPlan = new WorkPlan();
//		return "modules/work/exec/workPendingList";
//	}
//	
//	
//
//	@RequiresPermissions("work:workPlan:edit")
//	@RequestMapping(value = "submitPlan")
//	public String submitPlan(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model){
//		String[] ids = request.getParameterValues("ids");
//		if(ids != null && ids.length > 0){
//			for(String id : ids){
//				WorkPlan w = new WorkPlan();
//				w.setId(id);
//				workPlanService.submit_company_plan(w);//提交公司计划
//			}
//		}else{			
//			workPlanService.submit_company_plan(workPlan);//提交公司计划
//		}
//		WorkPlan wp = new WorkPlan();
//		wp.setPlanType(workPlan.getPlanType());
//		return list(wp, request, response, model);
//	}
//	
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = "detail")
//	public String detail(WorkPlan workPlan, Model model) {
//		// 根据工作计划中的计划类别（个人计划，部门计划，公司计划）生成过滤条件保存在sqlMap.dsf中
//		WorkPlanSqlMapFilter.getFilter().typePersonFilterSqlMapDsf(workPlan, model);
//
//		if (workPlan.getParent() != null && StringUtils.isNotBlank(workPlan.getParent().getId())) {
//			workPlan.setParent(workPlanService.get(workPlan.getParent().getId()));
//			// 获得工作计划的完整工作类型
//			if (workPlan.getWorkType() != null && StringUtils.isNotBlank(workPlan.getWorkType().getId())) {
//				workPlan.setWorkType(workTypeService.get(workPlan.getWorkType().getId()));
//			}
//			// 获得工作计划的完整责任人
//			if (workPlan.getPersonLiable() != null && StringUtils.isNotBlank(workPlan.getPersonLiable().getId())) {
//				workPlan.setPersonLiable(UserUtils.get(workPlan.getPersonLiable().getId()));
//			}
//
//			// 获取排序号，最末节点排序号+30
//			if (StringUtils.isBlank(workPlan.getId())) {
//				WorkPlan workPlanChild = new WorkPlan();
//				workPlanChild.setParent(new WorkPlan(workPlan.getParent().getId()));
//				List<WorkPlan> list = workPlanService.findList(workPlan);
//				if (list.size() > 0) {
//					workPlan.setSort(list.get(list.size() - 1).getSort());
//					if (workPlan.getSort() != null) {
//						workPlan.setSort(workPlan.getSort() + 30);
//					}
//				}
//			}
//		}
//		if (workPlan.getSort() == null) {
//			workPlan.setSort(30);
//		}
//
//		model.addAttribute("workPlan", workPlan);
//		return "modules/work/exec/workPlanDetail";
//	}
//	
//	@RequiresPermissions("work:workPlan:edit")
//	@RequestMapping(value = "save")
//	public String save(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
//		// 保存当前工作类别（个人，公司，部门等类别）的数据字典对象
//		Dict planTypeDict = DictUtils.getDictByID(workPlan.getPlanType());
//		// 如何个人工作计划，直接把当前用户所在部门设置到工作计划中
//		if ("personal".equals(planTypeDict.getValue())) {
//			workPlan.setDepts(UserUtils.getUser().getOffice());
//		}
//
//		if (!beanValidator(model, workPlan)) {
//			workPlan.setPlanType(planTypeDict.getValue());
//			return form(workPlan, model);
//		}
//		workPlanService.save(workPlan);
//		addMessage(redirectAttributes, "保存工作计划成功");
//
//		return "redirect:" + Global.getAdminPath() + "/work/workPlan/?repage&planType=" + planTypeDict.getValue();
//	}
//	
//	@RequiresPermissions("work:workPlan:edit")
//	@RequestMapping(value = "pending_save")
//	public String pending_save(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
//		save(workPlan, model, redirectAttributes);
//		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_form?repage&id=" + workPlan.getId() + "&repage&planType=company";
//	}
//	
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"pending_list"})
//	public String pending_list(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		/**
//		 *	过滤出所有已提交状态的公司级工作计划
//		 */
//		WorkPlanSqlMapFilter.getFilter().typeSubmittedCompanyWorkPlanyFilter(workPlan, model);
//		
//
//		List<WorkPlan> list = workPlanService.findList(workPlan);
//
//		model.addAttribute("list", list);
//		return "modules/work/exec/workPendingList";
//	}
//	
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = "pending_form")
//	public String pending_form(WorkPlan workPlan, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		
//		if (workPlan.getParent() != null && StringUtils.isNotBlank(workPlan.getParent().getId())) {
//			workPlan.setParent(workPlanService.get(workPlan.getParent().getId()));
//			// 获得工作计划的完整工作类型
//			if (workPlan.getWorkType() != null && StringUtils.isNotBlank(workPlan.getWorkType().getId())) {
//				workPlan.setWorkType(workTypeService.get(workPlan.getWorkType().getId()));
//			}
//			// 获得工作计划的完整责任人
//			if (workPlan.getPersonLiable() != null && StringUtils.isNotBlank(workPlan.getPersonLiable().getId())) {
//				workPlan.setPersonLiable(UserUtils.get(workPlan.getPersonLiable().getId()));
//			}
//
//			// 获取排序号，最末节点排序号+30
//			if (StringUtils.isBlank(workPlan.getId())) {
//				WorkPlan workPlanChild = new WorkPlan();
//				workPlanChild.setParent(new WorkPlan(workPlan.getParent().getId()));
//				List<WorkPlan> list = workPlanService.findList(workPlan);
//				if (list.size() > 0) {
//					workPlan.setSort(list.get(list.size() - 1).getSort());
//					if (workPlan.getSort() != null) {
//						workPlan.setSort(workPlan.getSort() + 30);
//					}
//				}
//			}
//		}
//		if (workPlan.getSort() == null) {
//			workPlan.setSort(30);
//		}
//
//		model.addAttribute("workPlan", workPlan);
//		return "modules/work/exec/workPendingForm";
//	}
//	
//	/**
//	 * 审核拒绝的方法（还未实现）
//	 * @param workPlan
//	 * @param model
//	 * @param redirectAttributes
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:edit")
//	@RequestMapping(value = "reject")
//	public String reject(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
//		workPlanService.reject(workPlan);
//		
//		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_list?repage&planType=company";
//	}
//	
//	/**
//	 * 审核同意的方法（还未实现）
//	 * @param workPlan
//	 * @param model
//	 * @param redirectAttributes
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:edit")
//	@RequestMapping(value = "agree")
//	public String agree(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
//		workPlanService.agree(workPlan);
//		return "redirect:" + Global.getAdminPath() + "/work/workPlan/pending_list?repage&planType=company";
//	}
//
//	@RequiresPermissions("work:workPlan:edit")
//	@RequestMapping(value = "delete")
//	public String delete(WorkPlan workPlan, RedirectAttributes redirectAttributes) {
//		workPlanService.delete(workPlan);
//		addMessage(redirectAttributes, "删除工作计划成功");
//		return "redirect:" + Global.getAdminPath() + "/work/workPlan/?repage";
//	}
//
//	@RequiresPermissions("work:workPlan:edit")
//	@RequestMapping(value = "upload")
//	public String upload(WorkPlan workPlan, Model model, RedirectAttributes redirectAttributes) {
//
//		return "modules/work/workPlanForm";
//	}

//	/**
//	 * 进入部门工作待受理的列表页
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"dept_remain_list"})
//	public String dept_remain_list(WorkPlan workPlan, HttpServletRequest request, 
//			HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().typeDeptRemainListFilter(workPlan, model);
//		
//        Page<WorkPlan> page = workPlanService.findPage(new Page<WorkPlan>(request, response), workPlan); 
//        model.addAttribute("page", page);
//		model.addAttribute("curRemainDeptId",UserUtils.getUser().getOffice().getId());
//		return "modules/work/exec/deptRemainList";
//	}
	
//	/**
//	 * 进入已受理部门工作列表页面
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"dept_remainned_list"})
//	public String dept_remainned_list(WorkPlan workPlan, HttpServletRequest request, 
//			HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		List<WorkPlan> list = workPlanService.findRemainnedWorkPlanList(UserUtils.getUser().getId());
//		model.addAttribute("list", list);
//		return "modules/work/exec/deptRemainnedList";
//	}
	
//	/**
//	 * 进入公司工作反馈表单
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"feedback_form"})
//	public String feedback_form(WorkPlan workPlan, HttpServletRequest request, 
//			HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		
//		WorkPlan wpn = workPlanService.get(workPlan.getId());
//		wpn.setCurrentRemainDeptId(workPlan.getCurrentRemainDeptId());
//		wpn.setRemainId(workPlan.getRemainId());
//		model.addAttribute("workPlan",wpn);
//		return "modules/work/exec/workFeedbackForm";
//	}
	
//	/**
//	 * 存工作反馈
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"feedback_save"})
//	public String feedback_save(WorkPlan workPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		workPlanService.feedbackSave(workPlan.getRemainId(),workPlan.getFeedbackDesc(),UserUtils.getUser().getId()/*,workPlan.getIsOver()*/);
//		return "redirect:" + Global.getAdminPath() + "/work/workPlan/remainned_list?repage&planType=company";
//	}
//	/**
//	 * 进入回复已反馈部门工作表单
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"feedback_form"})
//	public String feedback_form(WorkPlan workPlan, HttpServletRequest request, 
//			HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		workPlan = workPlanService.findReplayBy3Id(workPlan.getId(),workPlan.getRemainId(),workPlan.getFeedbackId());
//		model.addAttribute("workPlan",workPlan);
//		return "modules/work/exec/deptReplayRemainFeedbackForm";
//	}
	
//	/**
//	 * 进入待关闭回复已反馈部门工作列表页面
//	 * @param workPlan
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("work:workPlan:view")
//	@RequestMapping(value = {"dept_clos_remainned_feedback_list"})
//	public String dept_clos_remainned_feedback_list(WorkPlan workPlan, HttpServletRequest request, 
//			HttpServletResponse response, Model model) {
//		WorkPlanSqlMapFilter.getFilter().common(workPlan, model);
//		List<WorkPlan> list = workPlanService.findAllWaitClosingRemainWorkPlan(UserUtils.getUser().getOffice().getId(),DictUtils.getDictByValue("department", "type_plan").getId());
//		model.addAttribute("list", list);
//		return "modules/work/exec/deptClosRemainnedFeedbackList";
//	}
}
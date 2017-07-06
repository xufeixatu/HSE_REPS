/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.act.utils.ActUtils;
import com.thinkgem.jeesite.modules.message.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.OfficeUtil;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.dao.WorkPlanDao;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;

/**
 * 工作计划管理Service
 * 
 * @author 何其锟
 * @version 2017-04-07
 */
@Service
@Transactional(readOnly = true)
public class WorkPlanService extends TreeService<WorkPlanDao, WorkPlan> {

	private static final String String = null;

	@Autowired
	private ActTaskService actTaskService = null;

	public WorkPlan get(String id) {
		return super.get(id);
	}

	public List<WorkPlan> findList(WorkPlan workPlan) {
		if (StringUtils.isNotBlank(workPlan.getParentIds())) {
			workPlan.setParentIds("," + workPlan.getParentIds() + ",");
		}
		return super.findList(workPlan);
	}

	@Transactional(readOnly = false)
	public void save(WorkPlan workPlan) {
		super.save(workPlan);
	}

	@Transactional(readOnly = false)
	public void delete(WorkPlan workPlan) {
		super.delete(workPlan);
	}

	@Transactional(readOnly = false)
	public void submit_plan(WorkPlan workPlan) {
		dao.updateWorkState(workPlan.getId(), DictUtils.getDictByValue("submit", "work_state").getId());
		Dict d = DictUtils.getDictByValue(workPlan.getPlanType(), "type_plan");
		String planType = workPlan.getPlanType();
		// 如果时间为频次则创建子任务

		if (d.getValue().equals("personal") && workPlan.getFrequency() != null && !"".equals(workPlan.getFrequency())) {
			// 如果个人工作计划无需审核，直接将结束状态修改为“处理中”
			dao.updateWorkState(workPlan.getId(), DictUtils.getDictByValue("handing", "work_state").getId());
			// 创建子工作计划
			createPlanChilds(workPlan);
			
		} else {
			if ("true".equals(DictUtils.getDictList("type_audited").get(0).getValue())) {
				User user = workPlan.getCurrentAuditUse();// .getId()).getLoginName();
				String assignee = null;
				if (user == null) {
					switch (planType) {
					case "action":
						User currUser = UserUtils.getUser();
						if (!currUser.getName().equals(currUser.getOffice().getPrimaryPerson().getName())) {
							assignee = currUser.getOffice().getPrimaryPerson().getName();
						} else {
							assignee = OfficeUtil.getOfficeById(currUser.getOffice().getParent().getId())
									.getPrimaryPerson().getName();
						}
						break;
					case "department":
					case "company":
						assignee = UserUtils.getUser().getOffice().getPrimaryPerson().getName();
						break;
					}
				} else {
					assignee = UserUtils.get(user.getId()).getLoginName();
				}

				// 非个人工作计划均创建工作流
				Map<String, Object> vars = Maps.newHashMap();
				vars.put("assignee", assignee);
				vars.put("planType", d.getValue());
				vars.put("current_user", UserUtils.getUser().getName());
				// 创建并提交审核工作流程
				String pi = actTaskService.startProcess(ActUtils.PD_WORKPLAN_AUDIT[0], ActUtils.PD_WORKPLAN_AUDIT[1],
						workPlan.getId(), "工作计划审核", vars);
				// 更新流程实例ID
				dao.updateProcessInstanceId(workPlan.getId(), pi);
				dao.updateWorkState(workPlan.getId(), DictUtils.getDictByValue("auditing", "work_state").getId());
			}else{
				dao.updateWorkState(workPlan.getId(), DictUtils.getDictByValue("pass", "work_state").getId());
			}
		}
	}

	@Transactional(readOnly = false)
	public void assigne(WorkPlan workPlan) {
		dao.updateWorkState(workPlan.getId(), DictUtils.getDictByValue("allocated", "work_state").getId());
		if (workPlan.getFrequency() != null && !"".equals(workPlan.getFrequency())) {
			createPlanChilds(workPlan);
		}
	}
	
	@Transactional(readOnly = false)
	public void reject(WorkPlan workPlan) {
		dao.reject(workPlan);
	}

	@Transactional(readOnly = false)
	public void agree(WorkPlan workPlan) {
		dao.agree(workPlan);
	}

	/**
	 * 创建子计划
	 * 
	 * @param workPlan
	 */
	@Transactional(readOnly = false)
	public void createPlanChilds(WorkPlan workPlan) {
		String[] ids = workPlan.getDepts().getId().split(",");
		String[] months = workPlan.getFrequency().split(",");
		if (!(ids.length <= 1 && months.length <= 1)) {
			for (int i = 0; i < ids.length; i++) {
				for (int j = 0; j < months.length; j++) {
					WorkPlan child = workPlan.clone();
					child.setName(child.getName() + "-" + months[j] + "月子任务");
				
					child.setPlanType(DictUtils.getDictByValue(workPlan.getPlanType(), "type_plan").getId());
					child.setParent(workPlan);
					child.setParentIds(workPlan.getParentIds() + workPlan.getId() + ",");
					child.setId(null);
					child.setFrequency(months[j]);
					child.getDepts().setId(ids[i]);
					if("personal".equals(workPlan.getPlanType()) || "action".equals(workPlan.getPlanType())){
						child.setWorkStateId(DictUtils.getDictByValue("handing", "work_state").getId());
					}else{
						child.setWorkStateId(DictUtils.getDictByValue("pass", "work_state").getId());
					}
					save(child);
				}
			}
		}
	}

	

	/**
	 * 受理工作
	 * 
	 * @param workPlan
	 */
	@Transactional(readOnly = false)
	public void remain(WorkPlan workPlan) {
		WorkPlan wrkpln = new WorkPlan();
		wrkpln.setRemainId(IdGen.uuid());
		wrkpln.setRemainDesc(workPlan.getRemainDesc());
		wrkpln.setRemainnerId(UserUtils.getUser().getId());
		wrkpln.setRemainDeptId(workPlan.getCurrentRemainDeptId());
		wrkpln.setRemainWorkPlanId(workPlan.getId());
		dao.remain_insert(wrkpln);
		/**
		 * 受理状态改为已受理
		 */
		dao.updateWorkState(workPlan.getId(), DictUtils.getDictByValue("received", "work_state").getId());
	}

	/**
	 * 查询是否
	 * 
	 * @param id
	 * @param id2
	 * @return
	 */
	@Transactional(readOnly = false)
	public int remainsCount(String workPlanId, String remainnerId, String officeId) {
		return dao.remainsCount(workPlanId, remainnerId, officeId);
	}

	@Transactional(readOnly = false)
	public List<WorkPlan> findRemainnedWorkPlanList(String id) {
		return dao.findCurrentRemainnedWorkPlanList(id);
	}

	@Transactional(readOnly = false)
	public void feedbackSave(String id,String remainId, String newReply,
			String replyPeopleId,String type) {
		dao.feedbackSave(remainId, newReply, replyPeopleId,type);
		if("urge".equals(type)){
			dao.updateWorkState(id,  DictUtils.getDictByValue("urge", "work_state").getId());
		}
		// if(isOver){
		// dao.feedback_over(remainId,WorkPlanDao.REMAIN_STATE_PROCESSED);
		// }
	}

	/**
	 * 查找
	 * 已受理的受理状态为已处理的反馈记录且反馈记录的已回复状态（isReply）为否(false)且工作的指派人为当前用户的工作、受理及最新反馈信息列表
	 * 
	 * @param id
	 *            当前用户的ID
	 */
	@Transactional(readOnly = false)
	public List<WorkPlan> findClosingReply(String userid) {

		return dao.findClosingReply(userid);
	}

	/**
	 * 查看一条部门工作记录的一条受理信息的所有反馈列表
	 * 
	 * @param id
	 * @param remainId
	 * @return
	 */
	public List<WorkPlan> findWorkPlanRemainAllFeedback(String id, String remainId) {

		return dao.findWorkPlanRemainAllFeedback(id, remainId);
	}

	public List<WorkPlan> findWorkPlanRemainFeedbackAllRefly(String id, String remainId, String feedback_id) {
		return dao.findWorkPlanRemainFeedbackAllRefly(id, remainId, feedback_id);
	}

	/**
	 * 查看一条工作记录的受理的反馈的信息
	 * 
	 * @param id
	 * @param remainId
	 * @param feedback_id
	 * @return
	 */
	public WorkPlan findReplayBy3Id(String id, String remainId, String feedback_id) {
		return dao.findReplayBy3Id(id, remainId, feedback_id);
	}

	/**
	 * 保存反馈的回复信息
	 * 
	 * @param feedback_id
	 *            反馈的ID
	 * @param replyContent
	 *            回复内容
	 * @param id
	 *            回复人ID
	 */
	@Transactional(readOnly = false)
	public void saveRemainFeedbackReplay(String feedback_id, String replyContent, String userId) {
		dao.saveRemainFeedbackReplay(feedback_id, replyContent, userId);
	}

	/**
	 * 查看所有已受理待关闭工作
	 * 
	 * @param id
	 * @return
	 */
	public List<WorkPlan> findAllWaitClosingRemainWorkPlan(String officeid, String planType) {
		return dao.findAllWaitClosingRemainWorkPlan(officeid, planType);
	}

	/**
	 * 关闭工作的方法
	 * 
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void closeWorkPlan(String workState,String id) {
		if("催办".equals(workState)){
			dao.updateWorkState(id, DictUtils.getDictByValue("urge_closed", "work_state").getId());
			return;
		}
		dao.updateWorkState(id, DictUtils.getDictByValue("closed", "work_state").getId());
	}

	/**
	 * 查找所有已关闭的工作计划
	 * 
	 * @param id
	 * @param id2
	 * @return
	 */
	public List<WorkPlan> findAllClosedRemainWorkPlan(String officid, String planType) {
		return dao.findAllClosedRemainWorkPlan(officid, planType);
	}

	/**
	 * 点评
	 * 
	 * @param id
	 * @param remainId
	 * @param commentContent
	 * @param score
	 */
	@Transactional(readOnly = false)
	public void commentSave(String id,String commentContent, int score) {
		dao.commentSave(UserUtils.getUser().getId(),id, commentContent, score);
	}

	public WorkPlan findComment(String remainId) {
		return dao.findComment(remainId);
	}
	
	@Transactional(readOnly = false)
	public void updatepersonLiable(String personLiableId,String id) {
		dao.updatepersonLiable(personLiableId,id);
	}
	
	public List<WorkPlan> findDiscusses(String id) {
		return dao.findDiscusses(id);
	}

	public List<WorkPlan> findCommentList(String id) {
		return dao.findCommentList(id);
	}

}
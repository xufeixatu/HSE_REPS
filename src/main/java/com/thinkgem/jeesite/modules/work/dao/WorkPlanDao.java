/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;
import com.thinkgem.jeesite.modules.work.entity.WorkPlanRemain;

/**
 * 工作计划管理DAO接口
 * @author 何其锟
 * @version 2017-04-07
 */
@MyBatisDao
public interface WorkPlanDao extends TreeDao<WorkPlan> {
	/**
	 * 结束状态：已分派
	 *          指派人将工作分派给多个部门后结束状态为已分派
	 */
	public static String END_STATE_ALLOCATED = "042bb2ce059249729da41c7995e4381b";
	/**
	 * 结束状态：已受理
	 *         指派人指派的多个部门责任人均受理了工作则结束状态为已受理
	 */
	public static String END_STATE_RECEIVED = "1564424ef256499bb3faa03033924b2f";
	/**
	 * 结束状态：处理中
	 *         
	 */
	@Deprecated
	public static String END_STATE_HANDLING = "45b05804a9744a7e8f2503a164f201f1";
	/**
	 * 结束状态：已处理
	 * 			
	 */
	@Deprecated
	public static String END_STATE_PROCESSED = "fe1e5eae0adb4033befdc24c7180c5be";
	/**
	 * 结束状态：已关闭
	 * 			指派人指派人部门受理的任务均已关闭则结束状态改为已关闭
	 */
	public static String END_STATE_CLOSED = "94236754111945de90fe6a1418edb8e4";
	/**
	 * 工作状态：审核通过
	 */
	public static String WORK_STATE_PASS = "0374ed53f5034055943e0381aca4c22a";
	/**
	 * 工作状态：审核未通过
	 */
	public static String WORK_STATE_NOT_PASS = "8332da35c3e3419caf094f53e7a6c58c";
	/**
	 * 工作状态：未提交
	 */
	public static String WORK_STATE_UNSUBMIT = "f3aa6747844045e0ad00605e60b8b5c1";
	/**
	 * 工作状态：提交
	 */
	public static String WORK_STATE_SUBMIT = "45d756f45bb04155adb95e66b6a0d1c1";
	
	/**
	 * 受理状态：已受理
	 *         任务指派给多个部门，指派的特定部门负责人受理工作后受理表中的受理状态
	 */
	public static String REMAIN_STATE_RECEIVED = "8cee3cf155744bf6bb2a6295d72fad1b";
	/**
	 * 受理状态：处理中
	 *         任务指派给多个部门，指派的特定部门负责人受理工作反馈后如指派人拒绝则受理表中的受理状态为处理中状态
	 */
	public static String REMAIN_STATE_HANDLING = "6b47a2b7fd9d4d13969befe3746d71df";
	/**
	 * 受理状态：已处理
	 *         任务指派给多个部门，指派的特定部门负责人受理工作反馈后受理状态为已处理状态
	 */
	public static String REMAIN_STATE_PROCESSED = "842994c380da4d39803c83a293856066";
	/**
	 * 受理状态：已关闭
	 *         任务指派给多个部门，指派的特定部门负责人受理工作反馈后如指派人接受结果并关闭则受理表中的受理状态为已关闭状态
	 */
	public static String REMAIN_STATE_CLOSED = "8cca32f9c7c44d31a31fbcbf57142147";
	/**
	 * 更新工作状态
	 * @param workPlan
	 * @param workStateId
	 */
	public void updateWorkState(@Param("id") String id,@Param("workStateId") String workStateId);
	
	/**
	 * 更新结束状态
	 * @param workPlan
	 * @param workStateId
	 */
	public void updateEndState(WorkPlan workPlan,@Param("endStateId") String endStateId);

	public void reject(WorkPlan workPlan);

	public void agree(WorkPlan workPlan);

	public void assigne(WorkPlan workPlan);

	public void remain_insert(WorkPlan workPlan);

	public void remain(@Param("id") String id);

	public int remainsCount(@Param("workPlanId") String workPlanId,@Param("remainnerId") String remainnerId,@Param("officeId") String officeId);

	public int isRemainOver(@Param("depts") String depts, @Param("remainWorkPlanId") String remainWorkPlanId);

	public List<WorkPlan> findCurrentRemainnedWorkPlanList(@Param("userid") String userid);
	
	/**
	 * 保存反馈信息
	 * @param workRemainId
	 * @param feedbackDesc
	 * @param userid
	 */
	public void feedbackSave(@Param("remainId") String remainId,@Param("replyContent") String replyContent, @Param("replyPeopleId") String replyPeopleId,@Param("type") String type);
	/**
	 * 修改结束状态为已处理状态
	 * @param workplanId
	 * @param endStateClosed
	 */
	public void feedback_over(@Param("remainId") String remainId, @Param("endStateProcessed") String endStateProcessed);
	/**
	 *  查找 已受理的受理状态为已处理的反馈记录且反馈记录的已回复状态（isReply）为否(false)且工作的指派人为当前用户的工作、受理及最新反馈信息列表
	 * @param string
	 * @return
	 */
	public List<WorkPlan> findClosingReply(@Param("assignerId") String assignerId);
	/**
	 *  查看一条部门工作记录的一条受理信息的所有反馈列表
	 * @param id
	 * @param remainId
	 * @return
	 */
	public List<WorkPlan> findWorkPlanRemainAllFeedback(@Param("id") java.lang.String id, @Param("remainId") java.lang.String remainId);

	public List<WorkPlan> findWorkPlanRemainFeedbackAllRefly(@Param("id") java.lang.String id,  @Param("remainId") java.lang.String remainId,
			 @Param("feedback_id") java.lang.String feedback_id);

	public WorkPlan findReplayBy3Id(@Param("id") java.lang.String id,  @Param("remainId") java.lang.String remainId,
			 @Param("feedback_id") java.lang.String feedback_id);

	public void saveRemainFeedbackReplay(@Param("feedback_id") String feedback_id,@Param("replyContent") String replyContent,
			@Param("userId") String userId);

	public List<WorkPlan> findAllWaitClosingRemainWorkPlan(@Param("officeid") java.lang.String officeid, @Param("plan_type") java.lang.String plan_type);

	public void closeWorkPlan(@Param("id") String id);

	public List<WorkPlan> findAllClosedRemainWorkPlan(@Param("officeid") String officeid, @Param("plan_type") String plan_type);
	/**
	 * 
	 * @param userid 点评人ID
	 * @param remainId 工作受理ID
	 * @param commentContent 点评内容
	 * @param score 成绩
	 */
	public void commentSave(@Param("userid") String userid, @Param("remainId") String remainId, @Param("commentContent") String commentContent, @Param("score") int score);

	public WorkPlan findComment(@Param("remainId") String remainId);

	public void updateProcessInstanceId(@Param("id") String id,@Param("processInstanceId") java.lang.String pi);

	public void updatepersonLiable(@Param("personLiableId") String personLiableId,@Param("id") String id);

	public List<WorkPlan> findDiscusses(@Param("id") java.lang.String id);
}
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
	 */
	public static String END_STATE_ALLOCATED = "042bb2ce059249729da41c7995e4381b";
	/**
	 * 结束状态：已受理
	 */
	public static String END_STATE_RECEIVED = "1564424ef256499bb3faa03033924b2f";
	/**
	 * 结束状态：处理中
	 */
	public static String END_STATE_HANDLING = "45b05804a9744a7e8f2503a164f201f1";
	/**
	 * 结束状态：已处理
	 */
	public static String END_STATE_PROCESSED = "fe1e5eae0adb4033befdc24c7180c5be";
	
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
	
	public void submit_company_plan(WorkPlan workPlan);

	public void reject(WorkPlan workPlan);

	public void agree(WorkPlan workPlan);

	public void asigned(WorkPlan workPlan);

	public void remain_insert(WorkPlan workPlan);

	public void remain();

	public int remainsCount(@Param("workPlanId") String workPlanId,@Param("remainnerId") String remainnerId,@Param("officeId") String officeId);

	public int isRemainOver(@Param("depts") String depts, @Param("remainWorkPlanId") String remainWorkPlanId);

	public List<WorkPlan> findCurrentRemainnedWorkPlanList(@Param("userid") String userid);
	/**
	 * 修改工作结束状态的方法
	 * @param endStateId 
	 */
	public void updateEndState(String endStateId);
	
	public void feedbackSave(@Param("workplanId") String workplanId,@Param("feedbackDesc") String feedbackDesc, @Param("userid") String userid);
}
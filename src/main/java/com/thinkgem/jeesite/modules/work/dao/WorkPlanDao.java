/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.dao;

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

	public void submit_company_plan(WorkPlan workPlan);

	public void reject(WorkPlan workPlan);

	public void agree(WorkPlan workPlan);

	public void asigned(WorkPlan workPlan);

	public void remain_insert(WorkPlanRemain wpr);
}
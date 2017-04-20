/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;
import com.thinkgem.jeesite.modules.work.entity.WorkPlanRemain;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.dao.WorkPlanDao;

/**
 * 工作计划管理Service
 * @author 何其锟
 * @version 2017-04-07
 */
@Service
@Transactional(readOnly = true)
public class WorkPlanService extends TreeService<WorkPlanDao, WorkPlan> {

	public WorkPlan get(String id) {
		return super.get(id);
	}
	
	public List<WorkPlan> findList(WorkPlan workPlan) {
		if (StringUtils.isNotBlank(workPlan.getParentIds())){
			workPlan.setParentIds(","+workPlan.getParentIds()+",");
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
	public void submit_company_plan(WorkPlan workPlan) {
		dao.submit_company_plan(workPlan);
	}
	
	@Transactional(readOnly = false)
	public void reject(WorkPlan workPlan) {
		dao.reject(workPlan);
	}
	
	@Transactional(readOnly = false)
	public void agree(WorkPlan workPlan) {
		dao.agree(workPlan);
	}
	
	@Transactional(readOnly = false)
	public void asigned(WorkPlan workPlan) {
		dao.asigned(workPlan);
	}
	/**
	 * 受理工作
	 * @param workPlan
	 */
	@Transactional(readOnly = false)
	public void remain(WorkPlan workPlan) {
		WorkPlanRemain wpr = new WorkPlanRemain();
		wpr.setRemainnerId(UserUtils.getUser().getId());
		wpr.setRemainDeptId(workPlan.getCurrentRemainDeptId());
		wpr.setRemainDesc(workPlan.getReminderDesc());
		dao.remain_insert(wpr);
	}

}
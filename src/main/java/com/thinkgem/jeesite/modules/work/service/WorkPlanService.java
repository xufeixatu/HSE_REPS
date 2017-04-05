/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;
import com.thinkgem.jeesite.modules.work.dao.WorkPlanDao;

/**
 * 工作计划管理Service
 * @author 何其锟
 * @version 2017-04-05
 */
@Service
@Transactional(readOnly = true)
public class WorkPlanService extends CrudService<WorkPlanDao, WorkPlan> {

	public WorkPlan get(String id) {
		return super.get(id);
	}
	
	public List<WorkPlan> findList(WorkPlan workPlan) {
		return super.findList(workPlan);
	}
	
	public Page<WorkPlan> findPage(Page<WorkPlan> page, WorkPlan workPlan) {
		return super.findPage(page, workPlan);
	}
	
	@Transactional(readOnly = false)
	public void save(WorkPlan workPlan) {
		super.save(workPlan);
	}
	
	@Transactional(readOnly = false)
	public void delete(WorkPlan workPlan) {
		super.delete(workPlan);
	}
	
}
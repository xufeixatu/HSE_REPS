/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.dao.WorkPlanDao;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;

/**
 * 工作计划管理Service
 * @author 何其锟
 * @version 2017-04-07
 */
@Service
@Transactional(readOnly = true)
public class WorkPlanService extends TreeService<WorkPlanDao, WorkPlan> {

	private static final String String = null;

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
		WorkPlan wrkpln = new WorkPlan();
		wrkpln.setRemainId(IdGen.uuid());
		wrkpln.setRemainDesc(workPlan.getRemainDesc());
		wrkpln.setRemainnerId(UserUtils.getUser().getId());
		wrkpln.setRemainDeptId(workPlan.getCurrentRemainDeptId());
		wrkpln.setRemainWorkPlanId(workPlan.getId());
		dao.remain_insert(wrkpln);
		
		/**
		 * 如果所有分配该工作的部门均已接受，则将受理状态改为已受理
		 */
		String depts = workPlan.getDepts().getId();
		if(dao.isRemainOver(depts,wrkpln.getId()) == depts.split(",").length ){
			dao.remain();
		}
	}

	/**
	 * 查询是否
	 * @param id
	 * @param id2
	 * @return
	 */
	@Transactional(readOnly = false)
	public int remainsCount(String workPlanId, String remainnerId,String officeId) {
		
		return dao.remainsCount(workPlanId,remainnerId,officeId);
	}
	@Transactional(readOnly = false)
	public List<WorkPlan> findRemainnedWorkPlanList(String id) {
		
		return dao.findCurrentRemainnedWorkPlanList(id);
	}
	@Transactional(readOnly = false)
	public void feedbackSave(String workplanId, String feedbackDesc, String userid) {
		dao.feedbackSave(workplanId,feedbackDesc,userid);
		
	}

}
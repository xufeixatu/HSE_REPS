/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.dao.plan;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.train.entity.plan.TrainPlan;

/**
 * 培训计划信息DAO接口
 * @author peizhen
 * @version 2017-05-20
 */
@MyBatisDao
public interface TrainPlanDao extends CrudDao<TrainPlan> {
	
}
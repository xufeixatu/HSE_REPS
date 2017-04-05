/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;

/**
 * 工作计划管理DAO接口
 * @author 何其锟
 * @version 2017-04-05
 */
@MyBatisDao
public interface WorkPlanDao extends CrudDao<WorkPlan> {
	
}
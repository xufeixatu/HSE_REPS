/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.dao;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.work.entity.WorkType;

/**
 * 工作计划DAO接口
 * @author 何老师
 * @version 2017-03-29
 */
@MyBatisDao
public interface WorkTypeDao extends TreeDao<WorkType> {
	
}

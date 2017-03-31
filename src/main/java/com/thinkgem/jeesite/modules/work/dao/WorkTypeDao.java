/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.work.entity.WorkType;

/**
 * 增删改查工作类别DAO接口
 * @author 何其锟
 * @version 2017-03-30
 */
@MyBatisDao
public interface WorkTypeDao extends CrudDao<WorkType> {
	
}
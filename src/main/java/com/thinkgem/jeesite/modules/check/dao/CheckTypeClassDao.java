/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.dao;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.check.entity.CheckTypeClass;

/**
 * 检查类别管理DAO接口
 * @author hehui
 * @version 2017-05-07
 */
@MyBatisDao
public interface CheckTypeClassDao extends TreeDao<CheckTypeClass> {
	
}
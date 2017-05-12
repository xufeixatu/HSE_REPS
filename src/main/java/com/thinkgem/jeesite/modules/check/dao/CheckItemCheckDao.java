/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.check.entity.CheckItemCheck;

/**
 * 检查项检查管理DAO接口
 * @author hehui
 * @version 2017-05-12
 */
@MyBatisDao
public interface CheckItemCheckDao extends CrudDao<CheckItemCheck> {
	
}
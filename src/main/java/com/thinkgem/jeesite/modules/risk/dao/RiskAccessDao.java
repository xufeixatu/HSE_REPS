/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.risk.entity.RiskAccess;

/**
 * riskDAO接口
 * @author lily
 * @version 2017-05-18
 */
@MyBatisDao
public interface RiskAccessDao extends CrudDao<RiskAccess> {
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.dao.risk;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.risk.entity.risk.RiskAccess;

/**
 * riskDAO接口
 * @author lily
 * @version 2017-05-11
 */
@MyBatisDao
public interface RiskAccessDao extends CrudDao<RiskAccess> {
	
}
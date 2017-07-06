/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.risk.entity.RiskEnvirresult;

/**
 * 环境评价得分DAO接口
 * @author 郭凯凯
 * @version 2017-06-26
 */
@MyBatisDao
public interface RiskEnvirresultDao extends CrudDao<RiskEnvirresult> {
	
}
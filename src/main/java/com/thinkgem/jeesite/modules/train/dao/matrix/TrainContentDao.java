/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.dao.matrix;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainContent;

/**
 * 培训知识内容信息DAO接口
 * @author peizhen
 * @version 2017-05-18
 */
@MyBatisDao
public interface TrainContentDao extends CrudDao<TrainContent> {
	
}
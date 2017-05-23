/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.dao.record;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordScore;

/**
 * 培训记录DAO接口
 * @author peizhen
 * @version 2017-05-20
 */
@MyBatisDao
public interface TrainRecordScoreDao extends CrudDao<TrainRecordScore> {
	
}
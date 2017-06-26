/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.service.record;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordScore;
import com.thinkgem.jeesite.modules.train.dao.record.TrainRecordScoreDao;

/**
 * 受培人员成绩Service
 * @author peizhen
 * @version 2017-05-20
 */
@Service
@Transactional(readOnly = true)
public class TrainRecordScoreService extends CrudService<TrainRecordScoreDao, TrainRecordScore> {

	public TrainRecordScore get(String id) {
		return super.get(id);
	}
	
	public List<TrainRecordScore> findList(TrainRecordScore trainRecordScore) {
		return super.findList(trainRecordScore);
	}
	
	public Page<TrainRecordScore> findPage(Page<TrainRecordScore> page, TrainRecordScore trainRecordScore) {
		return super.findPage(page, trainRecordScore);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainRecordScore trainRecordScore) {
		super.save(trainRecordScore);
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainRecordScore trainRecordScore) {
		super.delete(trainRecordScore);
	}
	
}
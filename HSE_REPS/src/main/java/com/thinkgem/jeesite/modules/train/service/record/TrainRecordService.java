/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.service.record;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecord;
import com.thinkgem.jeesite.modules.train.dao.record.TrainRecordDao;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordCourseware;
import com.thinkgem.jeesite.modules.train.dao.record.TrainRecordCoursewareDao;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordScore;
import com.thinkgem.jeesite.modules.train.dao.record.TrainRecordScoreDao;

/**
 * 培训记录Service
 * @author peizhen
 * @version 2017-05-20
 */
@Service
@Transactional(readOnly = true)
public class TrainRecordService extends CrudService<TrainRecordDao, TrainRecord> {

	@Autowired
	private TrainRecordCoursewareDao trainRecordCoursewareDao;
	@Autowired
	private TrainRecordScoreDao trainRecordScoreDao;
	
	public TrainRecord get(String id) {
		TrainRecord trainRecord = super.get(id);
		trainRecord.setTrainRecordCoursewareList(trainRecordCoursewareDao.findList(new TrainRecordCourseware(trainRecord)));
		trainRecord.setTrainRecordScoreList(trainRecordScoreDao.findList(new TrainRecordScore(trainRecord)));
		return trainRecord;
	}
	
	public List<TrainRecord> findList(TrainRecord trainRecord) {
		return super.findList(trainRecord);
	}
	
	public Page<TrainRecord> findPage(Page<TrainRecord> page, TrainRecord trainRecord) {
		return super.findPage(page, trainRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainRecord trainRecord) {
		super.save(trainRecord);
		for (TrainRecordCourseware trainRecordCourseware : trainRecord.getTrainRecordCoursewareList()){
			if (trainRecordCourseware.getId() == null){
				continue;
			}
			if (TrainRecordCourseware.DEL_FLAG_NORMAL.equals(trainRecordCourseware.getDelFlag())){
				if (StringUtils.isBlank(trainRecordCourseware.getId())){
					trainRecordCourseware.setRecord(trainRecord);
					trainRecordCourseware.preInsert();
					trainRecordCoursewareDao.insert(trainRecordCourseware);
				}else{
					trainRecordCourseware.preUpdate();
					trainRecordCoursewareDao.update(trainRecordCourseware);
				}
			}else{
				trainRecordCoursewareDao.delete(trainRecordCourseware);
			}
		}
		
		for (TrainRecordScore trainRecordScore : trainRecord.getTrainRecordScoreList()){
			if (trainRecordScore.getId() == null){
				continue;
			}
			if (TrainRecordScore.DEL_FLAG_NORMAL.equals(trainRecordScore.getDelFlag())){
				if (StringUtils.isBlank(trainRecordScore.getId())){
					trainRecordScore.setRecord(trainRecord);
					trainRecordScore.preInsert();
					trainRecordScoreDao.insert(trainRecordScore);
				}else{
					trainRecordScore.preUpdate();
					trainRecordScoreDao.update(trainRecordScore);
				}
			}else{
				trainRecordScoreDao.delete(trainRecordScore);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainRecord trainRecord) {
		super.delete(trainRecord);
		trainRecordCoursewareDao.delete(new TrainRecordCourseware(trainRecord));
		trainRecordScoreDao.delete(new TrainRecordScore(trainRecord));
	}
	
}
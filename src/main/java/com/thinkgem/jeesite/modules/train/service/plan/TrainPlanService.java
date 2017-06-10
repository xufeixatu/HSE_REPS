/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.service.plan;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.train.entity.plan.TrainPlan;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecord;
import com.thinkgem.jeesite.modules.train.service.record.TrainRecordService;
import com.thinkgem.jeesite.modules.train.dao.plan.TrainPlanDao;

/**
 * 培训计划信息Service
 * @author peizhen
 * @version 2017-05-20
 */
@Service
@Transactional(readOnly = true)
public class TrainPlanService extends CrudService<TrainPlanDao, TrainPlan> {

	@Autowired
	private TrainRecordService trainRecordService;
	@Autowired
	private TrainPlanDao trainPlanDao;
	
	public TrainPlan get(String id) {
		return super.get(id);
	}
	
	public List<TrainPlan> findList(TrainPlan trainPlan) {
		return super.findList(trainPlan);
	}
	
	public Page<TrainPlan> findPage(Page<TrainPlan> page, TrainPlan trainPlan) {
		return super.findPage(page, trainPlan);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainPlan trainPlan) {
		super.save(trainPlan);
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainPlan trainPlan) {
		super.delete(trainPlan);
	}
	
	@Transactional(readOnly = false)
	public void start(TrainPlan trainPlan) {
		TrainRecord trainRecord  = new TrainRecord();
		trainRecord.setStatus("0");//草稿
		trainRecord.setName(DateUtils.getDate()+trainPlan.getName());
		trainRecord.setIsExam("0");//不考试
		trainRecord.setContact(trainPlan.getCurrentUser());
		trainRecord.setPlanNumber(trainPlan.getPlanNumber());
		trainRecord.setTrainDuration(trainPlan.getPeriod());
		trainRecord.setSubjectOffice(trainPlan.getSubjectOffice());
		trainRecord.setObjectOffice(trainPlan.getObjectOffice());
		trainRecord.setTrainObject(trainPlan.getTrainObject());
		trainRecord.setTrainMethod(trainPlan.getTrainMethod());
		trainRecord.setClassify(trainPlan.getClassify());
		trainRecord.setBeginTrainTime(new Date());
		trainRecord.setTrainTime(trainPlan.getTrainTime());
		trainRecord.setIsPlan("1");//是计划
		trainRecord.setPlan(trainPlan);
		trainRecord.preInsert();
		trainRecord.setIsNewRecord(true);
		trainRecordService.save(trainRecord);
		
		trainPlan.preUpdate();
		trainPlan.setStatus("1");
		super.save(trainPlan);
	}

	public Page<TrainPlan> findTrainPlan(Page<TrainPlan> page, TrainPlan trainPlan) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		trainPlan.getSqlMap().put("dsf", dataScopeFilter(trainPlan.getCurrentUser(), "o", "a"));
		// 设置分页参数
		trainPlan.setPage(page);
		// 执行分页查询		
		page.setList(trainPlanDao.findList(trainPlan));
		return page;
	}

	
	
}
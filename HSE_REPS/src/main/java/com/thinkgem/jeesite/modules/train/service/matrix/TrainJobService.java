/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.service.matrix;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.train.entity.matrix.TrainJob;
import com.thinkgem.jeesite.modules.train.dao.matrix.TrainJobDao;

/**
 * 培训岗位信息Service
 * @author peizhen
 * @version 2017-05-17
 */
@Service
@Transactional(readOnly = true)
public class TrainJobService extends CrudService<TrainJobDao, TrainJob> {

	public TrainJob get(String id) {
		return super.get(id);
	}
	
	public List<TrainJob> findList(TrainJob trainJob) {
		return super.findList(trainJob);
	}
	
	public Page<TrainJob> findPage(Page<TrainJob> page, TrainJob trainJob) {
		return super.findPage(page, trainJob);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainJob trainJob) {
		super.save(trainJob);
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainJob trainJob) {
		super.delete(trainJob);
	}
	
}
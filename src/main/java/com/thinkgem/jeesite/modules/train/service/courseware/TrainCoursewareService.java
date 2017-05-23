/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.service.courseware;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.train.entity.courseware.TrainCourseware;
import com.thinkgem.jeesite.modules.train.dao.courseware.TrainCoursewareDao;

/**
 * 培训课件Service
 * @author peizhen
 * @version 2017-05-20
 */
@Service
@Transactional(readOnly = true)
public class TrainCoursewareService extends CrudService<TrainCoursewareDao, TrainCourseware> {

	public TrainCourseware get(String id) {
		return super.get(id);
	}
	
	public List<TrainCourseware> findList(TrainCourseware trainCourseware) {
		return super.findList(trainCourseware);
	}
	
	public Page<TrainCourseware> findPage(Page<TrainCourseware> page, TrainCourseware trainCourseware) {
		return super.findPage(page, trainCourseware);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainCourseware trainCourseware) {
		super.save(trainCourseware);
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainCourseware trainCourseware) {
		super.delete(trainCourseware);
	}
	
}
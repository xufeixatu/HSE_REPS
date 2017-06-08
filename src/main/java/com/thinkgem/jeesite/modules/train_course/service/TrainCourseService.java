/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train_course.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;
import com.thinkgem.jeesite.modules.course_catelog.dao.CourseCatelogDao;
import com.thinkgem.jeesite.modules.course_catelog.entity.CourseCatelog;
import com.thinkgem.jeesite.modules.train_course.dao.TrainCourseDao;

/**
 * 培训课件Service
 * @author 王少昌
 * @version 2017-05-17
 */
@Service
@Transactional(readOnly = true)
public class TrainCourseService extends CrudService<TrainCourseDao, TrainCourse> {
	@Autowired
	private CourseCatelogDao courseCatelogDao;
	
	public TrainCourse get(String id) {
		TrainCourse trainCourse = super.get(id);
		trainCourse.setCourseCatelogList(courseCatelogDao.findList(new CourseCatelog(trainCourse)));
		return trainCourse;
	}

/*	public TrainCourse get(String id) {
		return super.get(id);
	}*/
	
	public List<TrainCourse> findList(TrainCourse trainCourse) {
		return super.findList(trainCourse);
	}
	
	public Page<TrainCourse> findPage(Page<TrainCourse> page, TrainCourse trainCourse) {
		return super.findPage(page, trainCourse);
	}
	
	@Transactional(readOnly = false)
	public void save(TrainCourse trainCourse) {
		super.save(trainCourse);
		for (CourseCatelog courseCatelog : trainCourse.getCourseCatelogList()){
			if (courseCatelog.getId() == null){
				continue;
			}
			if (CourseCatelog.DEL_FLAG_NORMAL.equals(courseCatelog.getDelFlag())){
				if (StringUtils.isBlank(courseCatelog.getId())){
					courseCatelog.setTrainCourse(trainCourse);
					courseCatelog.preInsert();
					courseCatelogDao.insert(courseCatelog);
				}else{
					courseCatelog.preUpdate();
					courseCatelogDao.update(courseCatelog);
				}
			}else{
				courseCatelogDao.delete(courseCatelog);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(TrainCourse trainCourse) {
		super.delete(trainCourse);
	}
	
}
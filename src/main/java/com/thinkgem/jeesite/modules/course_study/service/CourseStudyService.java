/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_study.service;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.adobe.xmp.impl.Utils;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;
import com.thinkgem.jeesite.modules.course_study.dao.CourseStudyDao;

/**
 * 课程用户学习记录表Service
 * @author 曹洪运
 * @version 2017-06-09
 */
@Service
@Transactional(readOnly = true)
public class CourseStudyService extends CrudService<CourseStudyDao, CourseStudy> {

	
	public CourseStudy get(String id) {
		CourseStudy courseStudy = super.get(id);
		return courseStudy;
	}
	
	public List<CourseStudy> findList(CourseStudy courseStudy) {
		return super.findList(courseStudy);
	}
	
	public Page<CourseStudy> findPage(Page<CourseStudy> page, CourseStudy courseStudy) {
		return super.findPage(page, courseStudy);
	}
	
	@Transactional(readOnly = false)
	public void save(CourseStudy courseStudy) {
		super.save(courseStudy);
	}
	
	@Transactional(readOnly = false)
	public void delete(CourseStudy courseStudy) {
		super.delete(courseStudy);
	}
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_study.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;

/**
 * 学习记录DAO接口
 * @author 王少昌
 * @version 2017-06-10
 */
@MyBatisDao
public interface CourseStudyDao extends CrudDao<CourseStudy> {

	CourseStudy getByCourseIdAndUserId(CourseStudy courseStudy);
	
}
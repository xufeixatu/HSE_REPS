/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catelog.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.course_catelog.entity.CourseCatelog;
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;

/**
 * 课件目录DAO接口
 * @author 王少昌
 * @version 2017-06-07
 */
@MyBatisDao
public interface CourseCatelogDao extends CrudDao<CourseCatelog> {
	CourseCatelog getByCourseId(CourseCatelog courseCatelog);
}
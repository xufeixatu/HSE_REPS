/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train_course.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;

/**
 * 培训课件DAO接口
 * @author 王少昌
 * @version 2017-05-17
 */
@MyBatisDao
public interface TrainCourseDao extends CrudDao<TrainCourse> {
	
}
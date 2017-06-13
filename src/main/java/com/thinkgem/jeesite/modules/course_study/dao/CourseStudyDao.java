/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_study.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;

/**
 * 课程用户学习记录表DAO接口
 * @author 曹洪运
 * @version 2017-06-09
 */
@MyBatisDao
public interface CourseStudyDao extends CrudDao<CourseStudy> {
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_review.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.course_review.entity.CourseReview;

/**
 * 课件评论DAO接口
 * @author 曹洪运
 * @version 2017-06-02
 */
@MyBatisDao
public interface CourseReviewDao extends CrudDao<CourseReview> {
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course_review.entity.CourseReview;
import com.thinkgem.jeesite.modules.course_review.dao.CourseReviewDao;

/**
 * 课件评论Service
 * @author 曹洪运
 * @version 2017-06-02
 */
@Service
@Transactional(readOnly = true)
public class CourseReviewService extends CrudService<CourseReviewDao, CourseReview> {

	
	public CourseReview get(String id) {
		CourseReview courseReview = super.get(id);
		return courseReview;
	}
	
	public List<CourseReview> findList(CourseReview courseReview) {
		return super.findList(courseReview);
	}
	
	public Page<CourseReview> findPage(Page<CourseReview> page, CourseReview courseReview) {
		return super.findPage(page, courseReview);
	}
	
	@Transactional(readOnly = false)
	public void save(CourseReview courseReview) {
		super.save(courseReview);
	}
	
	@Transactional(readOnly = false)
	public void delete(CourseReview courseReview) {
		super.delete(courseReview);
	}
	
}
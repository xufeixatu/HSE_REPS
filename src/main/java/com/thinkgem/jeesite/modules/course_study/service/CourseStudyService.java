/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_study.service;

//<<<<<<< HEAD
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;
import com.thinkgem.jeesite.modules.train_course.dao.TrainCourseDao;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;
import com.thinkgem.jeesite.modules.train_course.service.TrainCourseService;
import com.thinkgem.jeesite.modules.course_study.dao.CourseStudyDao;

/**
 * 学习记录Service
 * 
 * @author 王少昌
 * @version 2017-06-10
 */
@Service
@Transactional(readOnly = true)
public class CourseStudyService extends CrudService<CourseStudyDao, CourseStudy> {

	@Autowired
	private TrainCourseDao trainCourseDao;
	@Autowired
	private CourseStudyDao courseStudyDao;
	
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

	// 求平均分
	@Transactional(readOnly = false)
	public String avg(CourseStudy courseStudy) {
		TrainCourse trainCourse = trainCourseDao.get(courseStudy.getCourseId());
		String grade = courseStudy.getGrade();
		courseStudy = courseStudyDao.getByCourseIdAndUserId(courseStudy);
		if(courseStudy==null){
			return "noStudy";
		}
		if (courseStudy.getGrade()==null || courseStudy.getGrade().equals("")) {
			int totalGradeNum = trainCourse.getGradeCount();
			double totalGrade = Double.valueOf(totalGradeNum) * Double.valueOf(trainCourse.getCourseGrade())
					+ Double.valueOf(grade);
			courseStudy.setGrade(grade);
			courseStudy.setGradeDate(new Date());
			courseStudy.preUpdate();
			courseStudyDao.update(courseStudy);
			
			trainCourse.setCourseGrade("" + totalGrade / (totalGradeNum + 1));   //平均分
			trainCourse.setGradeCount(totalGradeNum + 1);    //总人数
			trainCourse.preUpdate();
			trainCourseDao.update(trainCourse);
			return "true";
		}else{
		return "alreadyGrade";
		}
	}
	
	// 开始学习
	@Transactional(readOnly = false)
	public String startStudy(CourseStudy courseStudy) {
		//courseStudy.set
		courseStudy.setStatus("0");
		courseStudy.setStudyStartTime(new Date());
		courseStudy.preInsert();
		
		
		if(null == courseStudyDao.getByCourseIdAndUserId(courseStudy)){
			

			if(1==courseStudyDao.insert(courseStudy)){
				return "true";
			}else{
				return "false";
			}
			
		}else{
			return "alreadyStudy";
		}
		
	}


	public CourseStudy findByCourseIdAndUserId(CourseStudy courseStudy) {
		return super.dao.getByCourseIdAndUserId(courseStudy);
	}

	
	
	
//=======
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.thinkgem.jeesite.common.persistence.Page;
//import com.thinkgem.jeesite.common.service.CrudService;
//import com.thinkgem.jeesite.common.utils.StringUtils;
//import com.thinkgem.jeesite.modules.course_study.entity.CourseStudy;
//import com.thinkgem.jeesite.modules.course_study.dao.CourseStudyDao;
//
///**
// * 课程用户学习记录表Service
// * @author 曹洪运
// * @version 2017-06-09
// */
//@Service
//@Transactional(readOnly = true)
//public class CourseStudyService extends CrudService<CourseStudyDao, CourseStudy> {
//
//	
//	public CourseStudy get(String id) {
//		CourseStudy courseStudy = super.get(id);
//		return courseStudy;
//	}
//	
//	public List<CourseStudy> findList(CourseStudy courseStudy) {
//		return super.findList(courseStudy);
//	}
//	
//	public Page<CourseStudy> findPage(Page<CourseStudy> page, CourseStudy courseStudy) {
//		return super.findPage(page, courseStudy);
//	}
//	
//	@Transactional(readOnly = false)
//	public void save(CourseStudy courseStudy) {
//		super.save(courseStudy);
//	}
//	
//	@Transactional(readOnly = false)
//	public void delete(CourseStudy courseStudy) {
//		super.delete(courseStudy);
//	}
//	
//>>>>>>> branch 'trainCourse' of https://github.com/xufeixatu/HSE_REPS.git
}
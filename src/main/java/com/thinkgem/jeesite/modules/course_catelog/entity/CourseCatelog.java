/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catelog.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.train_course.entity.TrainCourse;

/**
 * 课件目录Entity
 * @author 王少昌
 * @version 2017-06-07
 */
public class CourseCatelog extends DataEntity<CourseCatelog> {
	
	private static final long serialVersionUID = 1L;
	private TrainCourse trainCourse;		// 业务主表 父类
	private String courseId;		// 课程id
	private String attachName;		// 附件名称
	private String attachId;		// 附件id
	
	public CourseCatelog() {
		super();
	}

	public CourseCatelog(String id){
		super(id);
	}
	
	public CourseCatelog(TrainCourse trainCourse){
		this.trainCourse = trainCourse;
	}

	@Length(min=0, max=500, message="长度必须介于 0 和 64 之间")
	public TrainCourse getTrainCourse() {
		return trainCourse;
	}

	public void setTrainCourse(TrainCourse trainCourse) {
		this.trainCourse = trainCourse;
	}

	@Length(min=0, max=64, message="课程id长度必须介于 0 和 64 之间")
	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	
	@Length(min=0, max=255, message="附件名称长度必须介于 0 和 255 之间")
	public String getAttachName() {
		return attachName;
	}

	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
	
	@Length(min=0, max=255, message="附件id长度必须介于 0 和 255之间")
	public String getAttachId() {
		return attachId;
	}

	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}
	
	
}
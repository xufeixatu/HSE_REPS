/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_study.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 课程用户学习记录表Entity
 * @author 曹洪运
 * @version 2017-06-09
 */
public class CourseStudy extends DataEntity<CourseStudy> {
	
	private static final long serialVersionUID = 1L;
	private String courseId;		// 课件ID
	private String trainById;		// 培训人ID
	private String studyStatus;		// 学习状态
	private Date studyTime;		// 学习时间
	private Date studyDate;		// 学习时长
	private Date studyStartTime;		// 学习开始时间
	private Date studyEndTime;		// 学习结束时间
	private String name;		// 名称
	
	public CourseStudy() {
		super();
	}

	public CourseStudy(String id){
		super(id);
	}

	@Length(min=0, max=64, message="课件ID长度必须介于 0 和 64 之间")
	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	
	@Length(min=0, max=64, message="培训人ID长度必须介于 0 和 64 之间")
	public String getTrainById() {
		return trainById;
	}

	public void setTrainById(String trainById) {
		this.trainById = trainById;
	}
	
	@Length(min=0, max=64, message="学习状态长度必须介于 0 和 64 之间")
	public String getStudyStatus() {
		return studyStatus;
	}

	public void setStudyStatus(String studyStatus) {
		this.studyStatus = studyStatus;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStudyTime() {
		return studyTime;
	}

	public void setStudyTime(Date studyTime) {
		this.studyTime = studyTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStudyDate() {
		return studyDate;
	}

	public void setStudyDate(Date studyDate) {
		this.studyDate = studyDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStudyStartTime() {
		return studyStartTime;
	}

	public void setStudyStartTime(Date studyStartTime) {
		this.studyStartTime = studyStartTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStudyEndTime() {
		return studyEndTime;
	}

	public void setStudyEndTime(Date studyEndTime) {
		this.studyEndTime = studyEndTime;
	}
	
	@Length(min=0, max=100, message="名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
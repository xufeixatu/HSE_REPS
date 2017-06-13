/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_study.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学习记录Entity
 * @author 王少昌
 * @version 2017-06-10
 */
public class CourseStudy extends DataEntity<CourseStudy> {
	
	private static final long serialVersionUID = 1L;
	private String courseId;		// course_id
	private String status;		// status
	private String duration;		// duration
	private Date studyStartTime;		// study_start_time
	private Date studyEndTime;		// study_end_time
	private String grade;		// 打分
	private Date gradeDate;		// grade_date
	
	public CourseStudy() {
		super();
	}

	public CourseStudy(String id){
		super(id);
	}

	@Length(min=0, max=64, message="course_id长度必须介于 0 和 64 之间")
	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	
	@Length(min=0, max=8, message="status长度必须介于 0 和 8 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=32, message="duration长度必须介于 0 和 32 之间")
	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
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
	
	@Length(min=0, max=8, message="打分长度必须介于 0 和 8 之间")
	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getGradeDate() {
		return gradeDate;
	}

	public void setGradeDate(Date gradeDate) {
		this.gradeDate = gradeDate;
	}
	
}
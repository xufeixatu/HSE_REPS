/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_review.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 课件评论Entity
 * @author 曹洪运
 * @version 2017-06-02
 */
public class CourseReview extends DataEntity<CourseReview> {
	
	private static final long serialVersionUID = 1L;
	private String courseId;		// 课件ID
	private String assessById;		// 评论人ID
	private String assessOpinion;		// 评论内容
/*<<<<<<< HEAD*/
	private String assessGrade;		// 评论星级
	private Date assessTime;		// 评论时间
	private String name;		// 名称
	private String unused1;		// unused_1
	
	public CourseReview() {
		super();
	}

	public CourseReview(String id){
		super(id);
	}

	@Length(min=0, max=64, message="课件ID长度必须介于 0 和 64 之间")
	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	
	@Length(min=0, max=64, message="评论人ID长度必须介于 0 和 64 之间")
	public String getAssessById() {
		return assessById;
	}

	public void setAssessById(String assessById) {
		this.assessById = assessById;
	}
	
	@Length(min=0, max=255, message="评论内容长度必须介于 0 和 255 之间")
	public String getAssessOpinion() {
		return assessOpinion;
	}

	public void setAssessOpinion(String assessOpinion) {
		this.assessOpinion = assessOpinion;
	}
	
	@Length(min=0, max=64, message="评论星级长度必须介于 0 和 64 之间")
	public String getAssessGrade() {
		return assessGrade;
	}

	public void setAssessGrade(String assessGrade) {
		this.assessGrade = assessGrade;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAssessTime() {
		return assessTime;
	}

	public void setAssessTime(Date assessTime) {
		this.assessTime = assessTime;
	}
	
	@Length(min=0, max=100, message="名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=64, message="unused_1长度必须介于 0 和 64 之间")
/*=======

private String assessGrade;		// 评价星级
	private Date assessTime;		// 评论时间
	private String name;		// 名称
	private String unused1;		// 预留字段
	
	public CourseReview() {
		super();
	}

	public CourseReview(String id){
		super(id);
	}

	@Length(min=0, max=64, message="课件ID长度必须介于 0 和 64 之间")
	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	
	@Length(min=0, max=64, message="评论人ID长度必须介于 0 和 64 之间")
	public String getAssessById() {
		return assessById;
	}

	public void setAssessById(String assessById) {
		this.assessById = assessById;
	}
	
	@Length(min=0, max=255, message="评论内容长度必须介于 0 和 255 之间")
	public String getAssessOpinion() {
		return assessOpinion;
	}

	public void setAssessOpinion(String assessOpinion) {
		this.assessOpinion = assessOpinion;
	}
	
	@Length(min=0, max=64, message="评价星级长度必须介于 0 和 64 之间")
	public String getAssessGrade() {
		return assessGrade;
	}

	public void setAssessGrade(String assessGrade) {
		this.assessGrade = assessGrade;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAssessTime() {
		return assessTime;
	}

	public void setAssessTime(Date assessTime) {
		this.assessTime = assessTime;
	}
	
	@Length(min=0, max=100, message="名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=64, message="预留字段长度必须介于 0 和 64 之间")
>>>>>>> branch 'trainCourse' of https://github.com/xufeixatu/HSE_REPS.git
*/	public String getUnused1() {
		return unused1;
	}

	public void setUnused1(String unused1) {
		this.unused1 = unused1;
	}
	
}
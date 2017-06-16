/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train_course.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.course_catelog.entity.CourseCatelog;

/**
 * 培训课件Entity
 * @author 王少昌
 * @version 2017-05-17
 */
public class TrainCourse extends DataEntity<TrainCourse> {
	
	private static final long serialVersionUID = 1L;
	private String trainPlanExtraId;		// 培训计划附加表ID
	private String courseTypeId;		// 课件类型ID
	private String coverId;		// 封面ID
	private String docId;		// 文档ID
	private String courseName;		// 课件名称
	private String courseDec;		// 课件描述
	private String courseTime;		// 课件时长
	private String courseCount;		// 课件学习人数
	private String courseGrade;		// 课件评价得分
	private String uploadBy;		// 上传人
	private Date uploadTime;		// 上传时间
	private String unused1;		// unused_1
	private String unused2;		// unused_2
	private String unused3;		// unused_3
	private int gradeCount;    //打分人数
	private List<CourseCatelog> CourseCatelogList = Lists.newArrayList();		// 子表列表
/*	private String courseId;		// 课程id
	private String attachName;		// 附件名称
	private String attachId;		// 附件id
*/	
	
	public int getGradeCount() {
		return gradeCount;
	}

	public void setGradeCount(int gradeCount) {
		this.gradeCount = gradeCount;
	}

	public TrainCourse() {
		super();
	}

	public TrainCourse(String id){
		super(id);
	}

	@Length(min=0, max=64, message="培训计划附加表ID长度必须介于 0 和 64 之间")
	public String getTrainPlanExtraId() {
		return trainPlanExtraId;
	}

	public void setTrainPlanExtraId(String trainPlanExtraId) {
		this.trainPlanExtraId = trainPlanExtraId;
	}
	
	@Length(min=0, max=64, message="课件类型ID长度必须介于 0 和 64 之间")
	public String getCourseTypeId() {
		return courseTypeId;
	}

	public void setCourseTypeId(String courseTypeId) {
		this.courseTypeId = courseTypeId;
	}
	
	@Length(min=0, max=255, message="封面ID长度必须介于 0 和 255 之间")
	public String getCoverId() {
		return coverId;
	}

	public void setCoverId(String coverId) {
		this.coverId = coverId;
	}
	
	@Length(min=0, max=500, message="文档ID长度必须介于 0 和 500 之间")
	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}
	
	@Length(min=1, max=255, message="课件名称长度必须介于 1 和 255 之间")
	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	
	@Length(min=1, max=255, message="课件描述长度必须介于 1 和 255 之间")
	public String getCourseDec() {
		return courseDec;
	}

	public void setCourseDec(String courseDec) {
		this.courseDec = courseDec;
	}
	
	@Length(min=1, max=64, message="课件时长长度必须介于 1 和 64 之间")
	public String getCourseTime() {
		return courseTime;
	}

	public void setCourseTime(String courseTime) {
		this.courseTime = courseTime;
	}
	
	@Length(min=0, max=64, message="课件学习人数长度必须介于 0 和 64 之间")
	public String getCourseCount() {
		return courseCount;
	}

	public void setCourseCount(String courseCount) {
		this.courseCount = courseCount;
	}
	
	@Length(min=0, max=64, message="课件评价得分长度必须介于 0 和 64 之间")
	public String getCourseGrade() {
		return courseGrade;
	}

	public void setCourseGrade(String courseGrade) {
		this.courseGrade = courseGrade;
	}
	
	@Length(min=1, max=64, message="上传人长度必须介于 1 和 64 之间")
	public String getUploadBy() {
		return uploadBy;
	}

	public void setUploadBy(String uploadBy) {
		this.uploadBy = uploadBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="上传时间不能为空")
	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	
	@Length(min=0, max=64, message="unused_1长度必须介于 0 和 64 之间")
	public String getUnused1() {
		return unused1;
	}

	public void setUnused1(String unused1) {
		this.unused1 = unused1;
	}
	
	@Length(min=0, max=64, message="unused_2长度必须介于 0 和 64 之间")
	public String getUnused2() {
		return unused2;
	}

	public void setUnused2(String unused2) {
		this.unused2 = unused2;
	}
	
	@Length(min=0, max=64, message="unused_3长度必须介于 0 和 64 之间")
	public String getUnused3() {
		return unused3;
	}

	public void setUnused3(String unused3) {
		this.unused3 = unused3;
	}
	
/*	@Length(min=0, max=64, message="课程id长度必须介于 0 和 64 之间")
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
	
	@Length(min=0, max=64, message="附件id长度必须介于 0 和 64 之间")
	public String getAttachId() {
		return attachId;
	}

	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}
	*/
	
	public List<CourseCatelog> getCourseCatelogList() {
		return CourseCatelogList;
	}

	public void setCourseCatelogList(List<CourseCatelog> CourseCatelogList) {
		this.CourseCatelogList = CourseCatelogList;
	}

	
}
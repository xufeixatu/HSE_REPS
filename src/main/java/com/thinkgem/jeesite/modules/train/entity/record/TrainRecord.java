/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.record;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.train.entity.plan.TrainPlan;

import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 培训记录Entity
 * @author peizhen
 * @version 2017-05-20
 */
public class TrainRecord extends DataEntity<TrainRecord> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 培训主题
	private Office objectOffice;		// 受训单位
	private Date trainTime;		// 培训时间
	private Date beginTrainTime;		// 开始 培训时间
	private Date endTrainTime;		// 结束 培训时间
	private Office subjectOffice;		// 责任单位
	private Integer planNumber;		// 培训人数
	private String trainDuration;		// 培训时长
	private User contact;		// 联系人
	private String status;		// 归档状态
	private String isExam;		// 是否考试
	private Date examTime;		// 考试时间
	private String examDuration;		// 考试时长
	private String pass;		// 合格线
	private String isPlan;		// 是否计划
	private TrainPlan plan;		// 培训计划
	private String files; //培训过程资料
	private List<TrainRecordCourseware> trainRecordCoursewareList = Lists.newArrayList();		// 子表列表
	private List<TrainRecordScore> trainRecordScoreList = Lists.newArrayList();		// 子表列表
	
	public TrainRecord() {
		super();
	}

	public TrainRecord(String id){
		super(id);
	}

	@Length(min=1, max=255, message="培训主题长度必须介于 1 和 255 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@NotNull(message="受训单位不能为空")
	public Office getObjectOffice() {
		return objectOffice;
	}

	public void setObjectOffice(Office objectOffice) {
		this.objectOffice = objectOffice;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="培训时间不能为空")
	public Date getTrainTime() {
		return trainTime;
	}

	public void setTrainTime(Date trainTime) {
		this.trainTime = trainTime;
	}
	
	public Date getBeginTrainTime() {
		return beginTrainTime;
	}

	public void setBeginTrainTime(Date beginTrainTime) {
		this.beginTrainTime = beginTrainTime;
	}

	public Date getEndTrainTime() {
		return endTrainTime;
	}

	public void setEndTrainTime(Date endTrainTime) {
		this.endTrainTime = endTrainTime;
	}

	@NotNull(message="责任单位不能为空")
	public Office getSubjectOffice() {
		return subjectOffice;
	}

	public void setSubjectOffice(Office subjectOffice) {
		this.subjectOffice = subjectOffice;
	}
	
	@NotNull(message="培训人数不能为空")
	public Integer getPlanNumber() {
		return planNumber;
	}

	public void setPlanNumber(Integer planNumber) {
		this.planNumber = planNumber;
	}
	
	@Length(min=0, max=32, message="培训时长长度必须介于 0 和 32 之间")
	public String getTrainDuration() {
		return trainDuration;
	}

	public void setTrainDuration(String trainDuration) {
		this.trainDuration = trainDuration;
	}
	
	@NotNull(message="联系人不能为空")
	public User getContact() {
		return contact;
	}

	public void setContact(User contact) {
		this.contact = contact;
	}
	
	@Length(min=1, max=8, message="归档状态长度必须介于 1 和 8 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=1, max=8, message="是否考试长度必须介于 1 和 32之间")
	public String getIsExam() {
		return isExam;
	}

	public void setIsExam(String isExam) {
		this.isExam = isExam;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getExamTime() {
		return examTime;
	}

	public void setExamTime(Date examTime) {
		this.examTime = examTime;
	}
	
	@Length(min=0, max=8, message="考试时长长度必须介于 0 和 32之间")
	public String getExamDuration() {
		return examDuration;
	}

	public void setExamDuration(String examDuration) {
		this.examDuration = examDuration;
	}
	
	@Length(min=0, max=32, message="合格线长度必须介于 0 和 32 之间")
	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}
	
	@Length(min=1, max=8, message="是否计划长度必须介于 1 和 8 之间")
	public String getIsPlan() {
		return isPlan;
	}

	public void setIsPlan(String isPlan) {
		this.isPlan = isPlan;
	}
	
	public TrainPlan getPlan() {
		return plan;
	}

	public void setPlan(TrainPlan plan) {
		this.plan = plan;
	}
	
	@Length(min=0, max=255, message="资料文件路径总长度必须介于 0 和 255 之间")
	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	public List<TrainRecordCourseware> getTrainRecordCoursewareList() {
		return trainRecordCoursewareList;
	}

	public void setTrainRecordCoursewareList(List<TrainRecordCourseware> trainRecordCoursewareList) {
		this.trainRecordCoursewareList = trainRecordCoursewareList;
	}
	public List<TrainRecordScore> getTrainRecordScoreList() {
		return trainRecordScoreList;
	}

	public void setTrainRecordScoreList(List<TrainRecordScore> trainRecordScoreList) {
		this.trainRecordScoreList = trainRecordScoreList;
	}
}
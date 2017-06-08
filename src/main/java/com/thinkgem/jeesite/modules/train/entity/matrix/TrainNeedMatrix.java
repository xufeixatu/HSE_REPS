/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.matrix;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 培训需求矩阵Entity
 * @author peizhen
 * @version 2017-05-20
 */
public class TrainNeedMatrix extends DataEntity<TrainNeedMatrix> {
	
	private static final long serialVersionUID = 1L;
	private String version; //版本号
	private TrainJob trainJob;		// 岗位
	private TrainContent trainContent;		// 知识内容
	private Date startTime;  //培训有效起始时间
	private Date endTime; //培训有效截止时间
	private String status; //培训状态（已培训、未培训）
	
	public TrainNeedMatrix() {
		super();
	}

	public TrainNeedMatrix(String id){
		super(id);
	}
	
	
	@NotNull(message="版本号不能为空")
	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	@NotNull(message="岗位不能为空")
	public TrainJob getTrainJob() {
		return trainJob;
	}

	public void setTrainJob(TrainJob trainJob) {
		this.trainJob = trainJob;
	}
	
	@NotNull(message="知识内容不能为空")
	public TrainContent getTrainContent() {
		return trainContent;
	}

	public void setTrainContent(TrainContent trainContent) {
		this.trainContent = trainContent;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
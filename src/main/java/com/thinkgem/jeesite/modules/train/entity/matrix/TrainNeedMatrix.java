/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.matrix;

import javax.validation.constraints.NotNull;

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
	
}
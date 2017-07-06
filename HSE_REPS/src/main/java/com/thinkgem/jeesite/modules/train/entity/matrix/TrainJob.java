/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.matrix;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 培训岗位信息Entity
 * @author peizhen
 * @version 2017-05-17
 */
public class TrainJob extends DataEntity<TrainJob> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 岗位
	private String sn;		// 序号
	private String classify;		// 分类
	
	public TrainJob() {
		super();
	}

	public TrainJob(String id){
		super(id);
	}

	@Length(min=1, max=100, message="岗位长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=32, message="序号长度必须介于 1 和 32 之间")
	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}
	
	@Length(min=1, max=1, message="分类长度必须介于 1 和 1 之间")
	public String getClassify() {
		return classify;
	}

	public void setClassify(String classify) {
		this.classify = classify;
	}
	
}
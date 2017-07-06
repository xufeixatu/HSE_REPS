/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.matrix;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 培训知识内容信息Entity
 * @author peizhen
 * @version 2017-05-18
 */
public class TrainContent extends DataEntity<TrainContent> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 知识内容
	private String sn;		// 序号
	private String classify;		// 培训分类
	private String firstPeriod;		// 初培课时
	private String nextPeriod;		// 复培课时/频率
	private String organizer;		// 组织单位
	private String requirement;		// 完成要求
	
	public TrainContent() {
		super();
	}

	public TrainContent(String id){
		super(id);
	}

	@Length(min=1, max=100, message="知识内容长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=8, message="序号长度必须介于 1 和 8 之间")
	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}
	
	@Length(min=1, max=8, message="培训分类长度必须介于 1 和 8 之间")
	public String getClassify() {
		return classify;
	}

	public void setClassify(String classify) {
		this.classify = classify;
	}
	
	@Length(min=0, max=32, message="初培课时长度必须介于 0 和 32 之间")
	public String getFirstPeriod() {
		return firstPeriod;
	}

	public void setFirstPeriod(String firstPeriod) {
		this.firstPeriod = firstPeriod;
	}
	
	@Length(min=0, max=32, message="复培课时/频率长度必须介于 0 和 32 之间")
	public String getNextPeriod() {
		return nextPeriod;
	}

	public void setNextPeriod(String nextPeriod) {
		this.nextPeriod = nextPeriod;
	}
	
	@Length(min=1, max=128, message="组织单位长度必须介于 1 和 128 之间")
	public String getOrganizer() {
		return organizer;
	}

	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}
	
	@Length(min=1, max=1, message="完成要求长度必须介于 1 和 1 之间")
	public String getRequirement() {
		return requirement;
	}

	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}
	
}
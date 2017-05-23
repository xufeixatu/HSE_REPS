/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.record;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.User;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 培训记录Entity
 * @author peizhen
 * @version 2017-05-20
 */
public class TrainRecordScore extends DataEntity<TrainRecordScore> {
	
	private static final long serialVersionUID = 1L;
	private TrainRecord record;		// 培训记录 父类
	private User user;		// 受培人员
	private String score;		// 培训成绩
	
	public TrainRecordScore() {
		super();
	}

	public TrainRecordScore(String id){
		super(id);
	}

	public TrainRecordScore(TrainRecord record){
		this.record = record;
	}

	@Length(min=1, max=64, message="培训记录长度必须介于 1 和 64 之间")
	public TrainRecord getRecord() {
		return record;
	}

	public void setRecord(TrainRecord record) {
		this.record = record;
	}
	
	@NotNull(message="受培人员不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=32, message="培训成绩长度必须介于 1 和 32 之间")
	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.record;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.train.entity.courseware.TrainCourseware;

/**
 * 培训记录Entity
 * @author peizhen
 * @version 2017-05-20
 */
public class TrainRecordCourseware extends DataEntity<TrainRecordCourseware> {
	
	private static final long serialVersionUID = 1L;
	private TrainRecord record;		// 培训记录 父类
	private TrainCourseware courseware;		// 课件
	
	public TrainRecordCourseware() {
		super();
	}

	public TrainRecordCourseware(String id){
		super(id);
	}

	public TrainRecordCourseware(TrainRecord record){
		this.record = record;
	}

	@NotNull(message="培训记录不能为空")
	public TrainRecord getRecord() {
		return record;
	}

	public void setRecord(TrainRecord record) {
		this.record = record;
	}
	
	public TrainCourseware getCourseware() {
		return courseware;
	}

	public void setCourseware(TrainCourseware courseware) {
		this.courseware = courseware;
	}
	
}
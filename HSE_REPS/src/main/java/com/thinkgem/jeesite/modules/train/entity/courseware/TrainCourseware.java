/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.courseware;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 培训课件Entity
 * @author peizhen
 * @version 2017-05-20
 */
public class TrainCourseware extends DataEntity<TrainCourseware> {
	
	private static final long serialVersionUID = 1L;
	private String file;		// 文件
	private String name;		// 课件名称
	
	public TrainCourseware() {
		super();
	}

	public TrainCourseware(String id){
		super(id);
	}

	@Length(min=1, max=255, message="文件长度必须介于 1 和 255 之间")
	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}
	
	@Length(min=1, max=64, message="课件名称长度必须介于 1 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.entity;

import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.Date;

import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * actcard_unsafe关联表Entity
 * @author 岳鑫
 * @version 2017-06-07
 */
public class ActcardUnsafe extends DataEntity<ActcardUnsafe> {
	
	private static final long serialVersionUID = 1L;
	private String unsafeEventId;		// 不安全事件编号
	private String actcardId;		// actcard编号
	private ActcardUnsafe parent;		// 父级编号
	private String parentIds;		// 所有父级编号
	private String name;		// 名称
	private String sort;		// 排序
	
	private Date startTime;
	private Date endTime;
	private String officeIds;
	
	
	

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getOfficeIds() {
		return officeIds;
	}

	public void setOfficeIds(String officeIds) {
		this.officeIds = officeIds;
	}

	public ActcardUnsafe() {
		super();
	}

	public ActcardUnsafe(String id){
		super(id);
	}

	@Length(min=1, max=64, message="不安全事件编号长度必须介于 1 和 64 之间")
	public String getUnsafeEventId() {
		return unsafeEventId;
	}

	public void setUnsafeEventId(String unsafeEventId) {
		this.unsafeEventId = unsafeEventId;
	}
	
	@Length(min=1, max=64, message="actcard编号长度必须介于 1 和 64 之间")
	public String getActcardId() {
		return actcardId;
	}

	public void setActcardId(String actcardId) {
		this.actcardId = actcardId;
	}
	
	@JsonBackReference
	@NotNull(message="父级编号不能为空")
	public ActcardUnsafe getParent() {
		return parent;
	}

	public void setParent(ActcardUnsafe parent) {
		this.parent = parent;
	}
	
	@Length(min=1, max=2000, message="所有父级编号长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
}
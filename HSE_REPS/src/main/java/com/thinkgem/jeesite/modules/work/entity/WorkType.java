/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.entity;

import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 增删改查工作类别Entity
 * @author 何其锟
 * @version 2017-04-01
 */
public class WorkType extends TreeEntity<WorkType> {
	
	private static final long serialVersionUID = 1L;
	private String typeName;		// 工作类型名
	private String typeDesc;		// 类型描述
	
	public WorkType() {
		super();
	}

	public WorkType(String id){
		super(id);
	}

	@Length(min=0, max=200, message="工作类型名长度必须介于 0 和 200 之间")
	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	@Length(min=0, max=255, message="类型描述长度必须介于 0 和 255 之间")
	public String getTypeDesc() {
		return typeDesc;
	}

	public void setTypeDesc(String typeDesc) {
		this.typeDesc = typeDesc;
	}
	
	@JsonBackReference
	@NotNull(message="父级编号不能为空")
	public WorkType getParent() {
		return parent;
	}

	public void setParent(WorkType parent) {
		this.parent = parent;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}
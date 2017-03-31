/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.entity;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 增删改查工作类别Entity
 * @author 何其锟
 * @version 2017-03-30
 */
public class WorkType extends TreeEntity<WorkType> {
	
	private static final long serialVersionUID = 1L;
	private String typeName;		// 工作类型名
	private String typeDesc;		// 类型描述
	private List<String> childWorkTypeList;//快速添加子工作类型
	public List<String> getChildWorkTypeList() {
		return childWorkTypeList;
	}

	public void setChildWorkTypeList(List<String> childWorkTypeList) {
		this.childWorkTypeList = childWorkTypeList;
	}

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
	
	@NotNull(message="排序不能为空")
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
}
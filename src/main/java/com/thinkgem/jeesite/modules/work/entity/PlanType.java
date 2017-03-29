/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.entity;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.TreeEntity;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 工作计划Entity
 * 
 * @author ThinkGem
 * @version 2013-05-15
 */
public class PlanType extends TreeEntity<PlanType> {

	private static final long serialVersionUID = 1L;
	// private Office parent; // 父级编号
	// private String parentIds; // 所有父级编号

	private String type_name;
	private String type_desc;
	private List<String> childPlanTypeList;// 快速添加子类别

	public PlanType() {
		super();
	}

	public PlanType(String id) {
		super(id);
	}

	
	public String getType_name() {
		return type_name;
	}

	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	public String getType_desc() {
		return type_desc;
	}

	public void setType_desc(String type_desc) {
		this.type_desc = type_desc;
	}

	public List<String> getChildPlanTypeList() {
		return childPlanTypeList;
	}

	public void setChildPlanTypeList(List<String> childPlanTypeList) {
		this.childPlanTypeList = childPlanTypeList;
	}

	// @JsonBackReference
	// @NotNull
	public PlanType getParent() {
		return parent;
	}

	public void setParent(PlanType parent) {
		this.parent = parent;
	}
	

	@Override
	public String toString() {
		return name;
	}
}
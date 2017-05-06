/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.entity;

import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonBackReference;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 检查类别管理Entity
 * @author hehui
 * @version 2017-05-06
 */
public class CheckTypeClass extends DataEntity<CheckTypeClass> {
	
	private static final long serialVersionUID = 1L;
	private String typeId;		// 检查表ID
	private String typeName;		// 检查的分类名称
	private String typeDesc;		// 检查分类描述
	private String sort;		// sort
	private CheckTypeClass parent;		// parent_id
	private String parentIds;		// parent_ids
	private String craeteBy;		// craete_by
	private String name;		// 名称
	private String obligate1;		// obligate_1
	private String obligate2;		// obligate_2
	private String obligate3;		// obligate_3
	
	public CheckTypeClass() {
		super();
	}

	public CheckTypeClass(String id){
		super(id);
	}

	@Length(min=1, max=64, message="检查表ID长度必须介于 1 和 64 之间")
	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	
	@Length(min=0, max=200, message="检查的分类名称长度必须介于 0 和 200 之间")
	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	@Length(min=0, max=255, message="检查分类描述长度必须介于 0 和 255 之间")
	public String getTypeDesc() {
		return typeDesc;
	}

	public void setTypeDesc(String typeDesc) {
		this.typeDesc = typeDesc;
	}
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@JsonBackReference
	public CheckTypeClass getParent() {
		return parent;
	}

	public void setParent(CheckTypeClass parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=500, message="parent_ids长度必须介于 0 和 500 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=0, max=64, message="craete_by长度必须介于 0 和 64 之间")
	public String getCraeteBy() {
		return craeteBy;
	}

	public void setCraeteBy(String craeteBy) {
		this.craeteBy = craeteBy;
	}
	
	@Length(min=0, max=200, message="名称长度必须介于 0 和 200 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=255, message="obligate_1长度必须介于 0 和 255 之间")
	public String getObligate1() {
		return obligate1;
	}

	public void setObligate1(String obligate1) {
		this.obligate1 = obligate1;
	}
	
	@Length(min=0, max=255, message="obligate_2长度必须介于 0 和 255 之间")
	public String getObligate2() {
		return obligate2;
	}

	public void setObligate2(String obligate2) {
		this.obligate2 = obligate2;
	}
	
	@Length(min=0, max=255, message="obligate_3长度必须介于 0 和 255 之间")
	public String getObligate3() {
		return obligate3;
	}

	public void setObligate3(String obligate3) {
		this.obligate3 = obligate3;
	}
	
}
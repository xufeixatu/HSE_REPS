/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catalog.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 课件类别管理Entity  课件类别管理添加
 * @author 曹洪运
 * @version 2017-06-01
 */
public class CourseCatalog extends TreeEntity<CourseCatalog> {
	
	private static final long serialVersionUID = 1L;
	private CourseCatalog parent;		// 父类ID
	private String catalogName;		// 课件类别名称
	private String catalogDesc;		// 课件类别描述
	private String parentIds;		// 父类们ID
	private String name;		// 名称
	private Integer sort;		// 排序
	
	public CourseCatalog() {
		super();
	}

	public CourseCatalog(String id){
		super(id);
	}

	@JsonBackReference
	public CourseCatalog getParent() {
		return parent;
	}

	public void setParent(CourseCatalog parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=64, message="课件类别名称长度必须介于 0 和 64 之间")
	public String getCatalogName() {
		return catalogName;
	}

	public void setCatalogName(String catalogName) {
		this.catalogName = catalogName;
	}
	
	@Length(min=0, max=255, message="课件类别描述长度必须介于 0 和 255 之间")
	public String getCatalogDesc() {
		return catalogDesc;
	}

	public void setCatalogDesc(String catalogDesc) {
		this.catalogDesc = catalogDesc;
	}
	
	@Length(min=0, max=2000, message="父类们ID长度必须介于 0 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=0, max=100, message="名称长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}
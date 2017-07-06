/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.entity;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;
import com.fasterxml.jackson.annotation.JsonBackReference;

import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 知识库分类Entity
 * @author 郭凯凯
 * @version 2017-04-20
 */
public class ZskClass extends TreeEntity<ZskClass> {
	
	private static final long serialVersionUID = 1L;
	private String zskName;		// 知识库名
	private String descInfo;		// 知识库描述
	private Integer sort;		// 排序
	private String name;		// 名称
	private String parentIds;		// 所有父级编号
	private ZskClass parent;		// 父级编号
	
	public ZskClass() {
		super();
	}

	public ZskClass(String id){
		super(id);
	}

	@Length(min=1, max=200, message="知识库名长度必须介于 1 和 200 之间")
	public String getZskName() {
		return zskName;
	}

	public void setZskName(String zskName) {
		this.zskName = zskName;
	}
	
	@Length(min=0, max=255, message="知识库描述长度必须介于 0 和 255 之间")
	public String getDescInfo() {
		return descInfo;
	}

	public void setDescInfo(String descInfo) {
		this.descInfo = descInfo;
	}
	
	@NotNull(message="排序不能为空")
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=2000, message="所有父级编号长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@JsonBackReference
	@NotNull(message="父级编号不能为空")
	public ZskClass getParent() {
		return parent;
	}

	public void setParent(ZskClass parent) {
		this.parent = parent;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}
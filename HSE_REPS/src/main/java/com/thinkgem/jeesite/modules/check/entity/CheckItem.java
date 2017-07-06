/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 检查项管理Entity
 * @author hehui
 * @version 2017-05-09
 */
public class CheckItem extends DataEntity<CheckItem> {
	
	private static final long serialVersionUID = 1L;
	private String templateId;		// template_id
	private String checkContent;		// 检查项的内容
	private String checkStandard;		// 检查项的合格标准
	private Integer sort;		// 排序序号
	private String craeteBy;		// craete_by
	private String obligate1;		// obligate_1
	private String obligate2;		// obligate_2
	private String obligate3;		// obligate_3
	
	public CheckItem() {
		super();
	}

	public CheckItem(String id){
		super(id);
	}

	@Length(min=1, max=64, message="template_id长度必须介于 1 和 64 之间")
	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	
	@Length(min=1, max=255, message="检查项的内容长度必须介于 1 和 255 之间")
	public String getCheckContent() {
		return checkContent;
	}

	public void setCheckContent(String checkContent) {
		this.checkContent = checkContent;
	}
	
	@Length(min=0, max=255, message="检查项的合格标准长度必须介于 0 和 255 之间")
	public String getCheckStandard() {
		return checkStandard;
	}

	public void setCheckStandard(String checkStandard) {
		this.checkStandard = checkStandard;
	}
	
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=64, message="craete_by长度必须介于 0 和 64 之间")
	public String getCraeteBy() {
		return craeteBy;
	}

	public void setCraeteBy(String craeteBy) {
		this.craeteBy = craeteBy;
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
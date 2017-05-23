/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * 检查记录管理Entity
 * @author hehui
 * @version 2017-05-10
 */
public class Inspct extends DataEntity<Inspct> {
	
	private static final long serialVersionUID = 1L;
	private String typeId;		// 检查类别
	private String typeName; //检查类别名称
	private Office checkOffice;		// 检查部门
	private String checkOfficeName; // 检查部门名称
	private Office inspectionOffice;		// 受检部门
	private String inspectionOfficeName; // 受检部门名称
	private String checkPerson;		// 检查人id
	private String checkUserName; //检查人名称
	private Date checkDate;		// 检查时间
	private String templateId;		// template_id
	private String obligate1;		// obligate_1
	private String obligate2;		// obligate_2
	private String obligate3;		// obligate_3
	private CheckTypeClass checkTypeClass; //检查类别
	
	public CheckTypeClass getCheckTypeClass() {
		return checkTypeClass;
	}

	public void setCheckTypeClass(CheckTypeClass checkTypeClass) {
		this.checkTypeClass = checkTypeClass;
	}

	public Inspct() {
		super();
	}

	public Inspct(String id){
		super(id);
	}

	@Length(min=1, max=64, message="检查类别长度必须介于 1 和 64 之间")
	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	
	@Length(min=1, max=64, message="检查人长度必须介于 1 和 64 之间")
	public String getCheckPerson() {
		return checkPerson;
	}

	public void setCheckPerson(String checkPerson) {
		this.checkPerson = checkPerson;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="检查时间不能为空")
	public Date getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}
	
	@Length(min=1, max=64, message="template_id长度必须介于 1 和 64 之间")
	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
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

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Office getCheckOffice() {
		return checkOffice;
	}

	public void setCheckOffice(Office checkOffice) {
		this.checkOffice = checkOffice;
	}

	public Office getInspectionOffice() {
		return inspectionOffice;
	}

	public void setInspectionOffice(Office inspectionOffice) {
		this.inspectionOffice = inspectionOffice;
	}

	public String getCheckUserName() {
		return checkUserName;
	}

	public void setCheckUserName(String checkUserName) {
		this.checkUserName = checkUserName;
	}

	public String getCheckOfficeName() {
		return checkOfficeName;
	}

	public void setCheckOfficeName(String checkOfficeName) {
		this.checkOfficeName = checkOfficeName;
	}

	public String getInspectionOfficeName() {
		return inspectionOfficeName;
	}

	public void setInspectionOfficeName(String inspectionOfficeName) {
		this.inspectionOfficeName = inspectionOfficeName;
	}
	
}
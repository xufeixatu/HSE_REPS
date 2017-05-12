/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 检查项检查管理Entity
 * @author hehui
 * @version 2017-05-12
 */
public class CheckItemCheck extends DataEntity<CheckItemCheck> {
	
	private static final long serialVersionUID = 1L;
	private String inspctId;		// 检查记录id
	private String checkItemId;		// 检查项id
	private String checkResult;		// 检查结果
	private Date checkTime;		// 检查时间
	private String reportStatus;		// 上报状态
	private String craeteBy;		// craete_by
	private String obligate1;		// obligate_1
	private String obligate2;		// obligate_2
	private String obligate3;		// obligate_3
	private String checkContent;
	private String checkStandard;
	private String checkPersonName;
	
	public String getCheckContent() {
		return checkContent;
	}

	public void setCheckContent(String checkContent) {
		this.checkContent = checkContent;
	}

	public String getCheckStandard() {
		return checkStandard;
	}

	public void setCheckStandard(String checkStandard) {
		this.checkStandard = checkStandard;
	}

	public String getCheckPersonName() {
		return checkPersonName;
	}

	public void setCheckPersonName(String checkPersonName) {
		this.checkPersonName = checkPersonName;
	}

	public CheckItemCheck() {
		super();
	}

	public CheckItemCheck(String id){
		super(id);
	}

	@Length(min=1, max=64, message="检查记录id长度必须介于 1 和 64 之间")
	public String getInspctId() {
		return inspctId;
	}

	public void setInspctId(String inspctId) {
		this.inspctId = inspctId;
	}
	
	@Length(min=1, max=64, message="检查项id长度必须介于 1 和 64 之间")
	public String getCheckItemId() {
		return checkItemId;
	}

	public void setCheckItemId(String checkItemId) {
		this.checkItemId = checkItemId;
	}
	
	@Length(min=0, max=64, message="检查结果长度必须介于 0 和 64 之间")
	public String getCheckResult() {
		return checkResult;
	}

	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	
	@Length(min=0, max=64, message="上报状态长度必须介于 0 和 64 之间")
	public String getReportStatus() {
		return reportStatus;
	}

	public void setReportStatus(String reportStatus) {
		this.reportStatus = reportStatus;
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
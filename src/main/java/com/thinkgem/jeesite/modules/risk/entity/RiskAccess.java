/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;
//import org.hibernate.validator.constraints.Length(min=0, max=255, message="风险名称;
import com.thinkgem.jeesite.common.annotation.FieldName;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * riskEntity
 * @author lily
 * @version 2017-05-18
 */
public class RiskAccess extends DataEntity<RiskAccess> {
	
	private static final long serialVersionUID = 1L;
	private String number;		// 编号
	private String years;		// 年份
	private String unit;		// 属地单位
	private String recognizeBy;		// 辨识人
	private Date recognizeDate;		// 辨识时间
	private String riskType;		// 风险类型
	private String category;		// 类别
	private String placeDevice;		// 场所、设备
	private String riskName;		// 风险名称(环境因素名称/安全风险名称)
	private String workName;		// 作业活动名称/活动、物料、产品、服务
	private String riskFactors;		// 危害因素（危险源）
	private String tense;		// 时态
	private String status;		// 状态
	private String result;		// 可能导致的后果
	private String judgeTf;		// 是非判断
	private String accessid;		// 评价结果ID
	private String isHeaverisk;		// 是否重大风险
	private String lastyearRecognize;		// 对应上年度的辨识项
	private String riskLevel;		// 风险等级
	private String workflowid;		// 工作流实例ID
	private String dutyUnit;		// 责任单位
	private String managementPlan;		// 对应管理方案
	private String affect;		// 影响（可能导致的事故、环境影响）
	private String measure;		// 措施（采取的消减、控制措施，现有控制方法）
	private String frequency;		// 排放频率
	private String reason;		// 触发原因
	private String reserve1;		// 预留字段1
	private String reserve2;		// 预留字段2
	private String reserve3;		// 预留字段3
	private String accessMothed;
	private String lscore;		// L得分
	private String escore;		// E得分
	private String cscore;		// C得分
	
	private String mlscore;		// L得分
	private String mscore;		// M得分
	private String sscore;		// S得分
	
	public String getAccessMothed() {
		return accessMothed;
	}
	public void setAccessMothed(String accessMothed) {
		this.accessMothed = accessMothed;
	}
	public String getMlscore() {
		return mlscore;
	}
	public void setMlscore(String mlscore) {
		this.mlscore = mlscore;
	}
	public String getMscore() {
		return mscore;
	}
	public void setMscore(String mscore) {
		this.mscore = mscore;
	}
	public String getSscore() {
		return sscore;
	}
	public void setSscore(String sscore) {
		this.sscore = sscore;
	}
	public String getLscore() {
		return lscore;
	}
	public void setLscore(String lscore) {
		this.lscore = lscore;
	}
	public String getEscore() {
		return escore;
	}
	public void setEscore(String escore) {
		this.escore = escore;
	} 
	public String getCscore() {
		return cscore;
	}
	public void setCscore(String cscore) {
		this.cscore = cscore;
	}
	public RiskAccess() {
		super();
	}
//西航  
	public RiskAccess(String id){
		super(id);
	}

	@Length(min=0, max=255, message="编号长度必须介于 0 和 255 之间")
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
	@JsonFormat(pattern = "yyyy")
	public String getYears() {
		return years;
	}

	public void setYears(String years) {
		this.years = years;
	}
	
	@Length(min=0, max=255, message="属地单位长度必须介于 0 和 255 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=255, message="辨识人长度必须介于 0 和 255 之间")
	public String getRecognizeBy() {
		return recognizeBy;
	}

	public void setRecognizeBy(String recognizeBy) {
		this.recognizeBy = recognizeBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRecognizeDate() {
		return recognizeDate;
	}

	public void setRecognizeDate(Date recognizeDate) {
		this.recognizeDate = recognizeDate;
	}
	
	@Length(min=0, max=255, message="风险类型长度必须介于 0 和 255 之间")
	public String getRiskType() {
		return riskType;
	}

	public void setRiskType(String riskType) {
		this.riskType = riskType;
	}
	
	@Length(min=0, max=255, message="类别长度必须介于 0 和 255 之间")
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	@ExcelField(title="场所、设备")
	@NotNull(message="场所、设备不能为空")
	@Length(min=0, max=255, message="场所、设备长度必须介于 0 和 255 之间")
	public String getPlaceDevice() {
		return placeDevice;
	}

	public void setPlaceDevice(String placeDevice) {
		this.placeDevice = placeDevice;
	}
	
	@Length(min=0, max=255, message="风险名称(环境因素名称/安全风险名称)长度必须介于 0 和 255 之间")
	public String getRiskName() {
		return riskName;
	}

	public void setRiskName(String riskName) {
		this.riskName = riskName;
	}
	//@NotNull(message="作业活动名称/活动、物料、产品不能为空")
	@ExcelField(title="作业活动名称/活动、物料、产品")
	@Length(min=0, max=255, message="作业活动名称/活动、物料、产品、服务长度必须介于 0 和 255 之间")
	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}
	@NotNull(message="危险源不能为空")
	@ExcelField(title="危害因素")
	@Length(min=0, max=255, message="危害因素（危险源）长度必须介于 0 和 255 之间")
	public String getRiskFactors() {
		return riskFactors;
	}

	public void setRiskFactors(String riskFactors) {
		this.riskFactors = riskFactors;
	}
	
	@Length(min=0, max=1, message="时态长度必须介于 0 和 1 之间")
	public String getTense() {
		return tense;
	}

	public void setTense(String tense) {
		this.tense = tense;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=255, message="可能导致的后果长度必须介于 0 和 255 之间")
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	@Length(min=0, max=255, message="是非判断长度必须介于 0 和 255 之间")
	public String getJudgeTf() {
		return judgeTf;
	}

	public void setJudgeTf(String judgeTf) {
		this.judgeTf = judgeTf;
	}
	
	@Length(min=0, max=64, message="评价结果ID长度必须介于 0 和 64 之间")
	public String getAccessid() {
		return accessid;
	}

	public void setAccessid(String accessid) {
		this.accessid = accessid;
	}
	
	@Length(min=0, max=255, message="是否重大风险长度必须介于 0 和 255 之间")
	public String getIsHeaverisk() {
		return isHeaverisk;
	}

	public void setIsHeaverisk(String isHeaverisk) {
		this.isHeaverisk = isHeaverisk;
	}
	
	@Length(min=0, max=255, message="对应上年度的辨识项长度必须介于 0 和 255 之间")
	public String getLastyearRecognize() {
		return lastyearRecognize;
	}

	public void setLastyearRecognize(String lastyearRecognize) {
		this.lastyearRecognize = lastyearRecognize;
	}
	
	@Length(min=0, max=255, message="风险等级长度必须介于 0 和 255 之间")
	public String getRiskLevel() {
		return riskLevel;
	}

	public void setRiskLevel(String riskLevel) {
		this.riskLevel = riskLevel;
	}
	
	@Length(min=0, max=64, message="工作流实例ID长度必须介于 0 和 64 之间")
	public String getWorkflowid() {
		return workflowid;
	}

	public void setWorkflowid(String workflowid) {
		this.workflowid = workflowid;
	}
	
	@Length(min=0, max=255, message="责任单位长度必须介于 0 和 255 之间")
	public String getDutyUnit() {
		return dutyUnit;
	}

	public void setDutyUnit(String dutyUnit) {
		this.dutyUnit = dutyUnit;
	}
	
	@Length(min=0, max=255, message="对应管理方案长度必须介于 0 和 255 之间")
	public String getManagementPlan() {
		return managementPlan;
	}

	public void setManagementPlan(String managementPlan) {
		this.managementPlan = managementPlan;
	}
	
	@Length(min=0, max=255, message="影响（可能导致的事故、环境影响）长度必须介于 0 和 255 之间")
	public String getAffect() {
		return affect;
	}

	public void setAffect(String affect) {
		this.affect = affect;
	}
	
	@Length(min=0, max=255, message="措施（采取的消减、控制措施，现有控制方法）长度必须介于 0 和 255 之间")
	public String getMeasure() {
		return measure;
	}

	public void setMeasure(String measure) {
		this.measure = measure;
	}
	
	@Length(min=0, max=255, message="排放频率长度必须介于 0 和 255 之间")
	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	
	@Length(min=0, max=255, message="触发原因长度必须介于 0 和 255 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	@Length(min=0, max=255, message="预留字段1长度必须介于 0 和 255 之间")
	public String getReserve1() {
		return reserve1;
	}

	public void setReserve1(String reserve1) {
		this.reserve1 = reserve1;
	}
	
	@Length(min=0, max=255, message="预留字段2长度必须介于 0 和 255 之间")
	public String getReserve2() {
		return reserve2;
	}

	public void setReserve2(String reserve2) {
		this.reserve2 = reserve2;
	}
	
	@Length(min=0, max=255, message="预留字段3长度必须介于 0 和 255 之间")
	public String getReserve3() {
		return reserve3;
	}

	public void setReserve3(String reserve3) {
		this.reserve3 = reserve3;
	}
	
}
/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 环境评价得分Entity
 * @author 郭凯凯
 * @version 2017-06-26
 */
public class RiskEnvirresult extends DataEntity<RiskEnvirresult> {
	
	private static final long serialVersionUID = 1L;
	private String recognizeid;		// 危害辨识项ID
	private String lscore;		// L得分
	private String sscore;		// S得分
	private String mscore;		// 风险程度M得分
	private String assessBy;		// 评价人
	private Date assessDate;		// 评价时间
	private String assessResult;		// 评价结果
	private String riskLevel;		// 风险等级
	private String reserve1;		// 预留字段1
	private String reserve2;		// 预留字段2
	
	public RiskEnvirresult() {
		super();
	}

	public RiskEnvirresult(String id){
		super(id);
	}

	@Length(min=0, max=64, message="危害辨识项ID长度必须介于 0 和 64 之间")
	public String getRecognizeid() {
		return recognizeid;
	}

	public void setRecognizeid(String recognizeid) {
		this.recognizeid = recognizeid;
	}
	
	@Length(min=0, max=255, message="L得分长度必须介于 0 和 255 之间")
	public String getLscore() {
		return lscore;
	}

	public void setLscore(String lscore) {
		this.lscore = lscore;
	}
	
	@Length(min=0, max=255, message="S得分长度必须介于 0 和 255 之间")
	public String getSscore() {
		return sscore;
	}

	public void setSscore(String sscore) {
		this.sscore = sscore;
	}
	
	@Length(min=0, max=255, message="风险程度M得分长度必须介于 0 和 255 之间")
	public String getMscore() {
		return mscore;
	}

	public void setMscore(String mscore) {
		this.mscore = mscore;
	}
	
	@Length(min=0, max=255, message="评价人长度必须介于 0 和 255 之间")
	public String getAssessBy() {
		return assessBy;
	}

	public void setAssessBy(String assessBy) {
		this.assessBy = assessBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAssessDate() {
		return assessDate;
	}

	public void setAssessDate(Date assessDate) {
		this.assessDate = assessDate;
	}
	
	@Length(min=0, max=255, message="评价结果长度必须介于 0 和 255 之间")
	public String getAssessResult() {
		return assessResult;
	}

	public void setAssessResult(String assessResult) {
		this.assessResult = assessResult;
	}
	
	@Length(min=0, max=255, message="风险等级长度必须介于 0 和 255 之间")
	public String getRiskLevel() {
		return riskLevel;
	}

	public void setRiskLevel(String riskLevel) {
		this.riskLevel = riskLevel;
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
	
}
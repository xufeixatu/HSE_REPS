/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;

import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.train.entity.record.TrainRecordCourseware;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * ACT卡Entity
 * @author 岳鑫
 * @version 2017-05-30
 */
public class Actcard extends ActEntity<Actcard> {
	
	private static final long serialVersionUID = 1L;
	private String unsafeActs;		// 不安全行为
	private String measure;		// 解决措施
	private String safetyActs;		// 安全行为
	private String suggestions;		// 建议
	private String reporter;		// 填报人
	private String reporterOffice;		// 填报人单位
	private Date reportingTime;		// 填报时间
	private String rectificationResult;		// 整改结果

	private User closer;		// 关闭人
	private Date closeTime;		// 关闭时间
	private String closerReport;//质量安全环保科回复
	
	private String state;		// 状态(指定责任人、正在整改、等待关闭、已关闭)
	private Office territorialOffice;		// 属地单位
	private String territorialOfficeReport;//属地单位回复
	
	private String reportPic;		// 上报时图片
	private String rectificationPic;		// 整改图片
	private String actcardUnsafeEventId;		// 不安全分类
	private String actcardUnsafeEventChildId;		// 不安全分类子类
	private User solver;		// 整改人
	private User user;		// user_id
	private Office office;		// office_id
	private List<ActcardReview> actcardReviewList = Lists.newArrayList();		// 评阅列表
	
	
	public Actcard() {
		super();
	}

	public Actcard(String id){
		super(id);
	}

	public String getUnsafeActs() {
		return unsafeActs;
	}

	public void setUnsafeActs(String unsafeActs) {
		this.unsafeActs = unsafeActs;
	}
	
	public String getMeasure() {
		return measure;
	}

	public void setMeasure(String measure) {
		this.measure = measure;
	}
	
	public String getSafetyActs() {
		return safetyActs;
	}

	public void setSafetyActs(String safetyActs) {
		this.safetyActs = safetyActs;
	}
	
	public String getSuggestions() {
		return suggestions;
	}

	public void setSuggestions(String suggestions) {
		this.suggestions = suggestions;
	}
	
	@Length(min=1, max=255, message="填报人长度必须介于 1 和 255 之间")
	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	
	@Length(min=1, max=255, message="填报人单位长度必须介于 1 和 255 之间")
	public String getReporterOffice() {
		return reporterOffice;
	}

	public void setReporterOffice(String reporterOffice) {
		this.reporterOffice = reporterOffice;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="填报时间不能为空")
	public Date getReportingTime() {
		return reportingTime;
	}

	public void setReportingTime(Date reportingTime) {
		this.reportingTime = reportingTime;
	}
	
	public String getRectificationResult() {
		return rectificationResult;
	}

	public void setRectificationResult(String rectificationResult) {
		this.rectificationResult = rectificationResult;
	}
	
	public User getCloser() {
		return closer;
	}

	public void setCloser(User closer) {
		this.closer = closer;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(Date closeTime) {
		this.closeTime = closeTime;
	}
	
	public String getCloserReport() {
		return closerReport;
	}

	public void setCloserReport(String closerReport) {
		this.closerReport = closerReport;
	}

	@Length(min=0, max=255, message="状态长度必须介于 0 和 255 之间")
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	@NotNull(message="属地单位不能为空")
	public Office getTerritorialOffice() {
		return territorialOffice;
	}

	public void setTerritorialOffice(Office territorialOffice) {
		this.territorialOffice = territorialOffice;
	}
	
	public String getTerritorialOfficeReport() {
		return territorialOfficeReport;
	}

	public void setTerritorialOfficeReport(String territorialOfficeReport) {
		this.territorialOfficeReport = territorialOfficeReport;
	}

	@Length(min=0, max=1000, message="上报时图片长度必须介于 0 和 1000 之间")
	public String getReportPic() {
		return reportPic;
	}

	public void setReportPic(String reportPic) {
		this.reportPic = reportPic;
	}
	
	@Length(min=0, max=1000, message="整改图片长度必须介于 0 和 1000 之间")
	public String getRectificationPic() {
		return rectificationPic;
	}

	public void setRectificationPic(String rectificationPic) {
		this.rectificationPic = rectificationPic;
	}
	
	public String getActcardUnsafeEventId() {
		return actcardUnsafeEventId;
	}

	public void setActcardUnsafeEventId(String actcardUnsafeEventId) {
		this.actcardUnsafeEventId = actcardUnsafeEventId;
	}
	
	public String getActcardUnsafeEventChildId() {
		return actcardUnsafeEventChildId;
	}

	public void setActcardUnsafeEventChildId(String actcardUnsafeEventChildId) {
		this.actcardUnsafeEventChildId = actcardUnsafeEventChildId;
	}
	
	public User getSolver() {
		return solver;
	}

	public void setSolver(User solver) {
		this.solver = solver;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public List<ActcardReview> getActcardReviewList() {
		return actcardReviewList;
	}

	public void setActcardReviewList(List<ActcardReview> actcardReviewList) {
		this.actcardReviewList = actcardReviewList;
	}

	
	
}
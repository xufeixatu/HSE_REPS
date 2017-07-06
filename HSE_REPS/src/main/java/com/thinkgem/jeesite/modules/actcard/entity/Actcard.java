/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.entity;

import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.common.persistence.ActEntity;

/**
 * ACT卡Entity
 * @author 岳鑫
 * @version 2017-05-23
 */
public class Actcard extends ActEntity<Actcard> {
	
	private static final long serialVersionUID = 1L;
	private Office territorialOffice;		// 属地单位
	private ActcardUnsafeEvent actcardUnsafeEvent;		// 不安全分类
	private ActcardUnsafeEvent actcardUnsafeEventChild;		// 不安全分类子类
	private String unsafeActs;		// 所观察到的不安全行为及有污染隐患的行为
	private String measure;		// 对不安全行为及隐患即刻的纠正行为和措施
	private String safetyActs;		// 所观察到的需要鼓励的安全、环保行为
	private String suggestions;		// 持续改进的HSE工作的其它建议
	private String reporter;		// 填报人
	private Office reporterOffice;		// 填报人单位
	private Date reportingTime;		// 填报时间
	private String rectificationResult;		// 整改结果
	private User closer;		// 关闭人
	private Date closeTime;		// 关闭时间
	private String state;		// 状态
	private String reportPic;		// 上报时图片
	private String rectificationPic;		// 整改图片
	
	private User solver;		// 整改人
	
	public Actcard() {
		super();
	}

	public Actcard(String id){
		super(id);
	}

	public Office getTerritorialOffice() {
		return territorialOffice;
	}

	public void setTerritorialOffice(Office territorialOffice) {
		this.territorialOffice = territorialOffice;
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
	
	@NotNull(message="填报人单位不能为空")
	public Office getReporterOffice() {
		return reporterOffice;
	}

	public void setReporterOffice(Office reporterOffice) {
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
	
	@Length(min=0, max=255, message="状态长度必须介于 0 和 255 之间")
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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
	

	
	public ActcardUnsafeEvent getActcardUnsafeEvent() {
		return actcardUnsafeEvent;
	}

	public void setActcardUnsafeEvent(ActcardUnsafeEvent actcardUnsafeEvent) {
		this.actcardUnsafeEvent = actcardUnsafeEvent;
	}

	public ActcardUnsafeEvent getActcardUnsafeEventChild() {
		return actcardUnsafeEventChild;
	}

	public void setActcardUnsafeEventChild(ActcardUnsafeEvent actcardUnsafeEventChild) {
		this.actcardUnsafeEvent = actcardUnsafeEventChild;
	}

	public User getSolver() {
		return solver;
	}

	public void setSolver(User solver) {
		this.solver = solver;
	}
	
}
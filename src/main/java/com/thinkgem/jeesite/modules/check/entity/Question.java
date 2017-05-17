/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 检查问题上报Entity
 * @author hehui
 * @version 2017-05-17
 */
public class Question extends ActEntity<Question> {
	
	private static final long serialVersionUID = 1L;
	private String checkItemId;		// check_item_id
	private String questionDesc;		// 问题描述
	private String questionClassId;		// 问题类别
	private String questionLevelId;		// 问题级别
	private String inspectionDeptTypeId;		// 引用数据字典的ID，该类别引用的是内部单位，则受检单位ID是公司部门ID，否则是承包商的名称或ID            此字段应在问题表中
	private String stateId;		// 该问题的处理状态有：受理中，审批中，待关闭，已关闭。
	private String approvalOpinion;		// 上报人所在部门领导审批上报问题
	private Date approvalTime;		// 审批时间
	private String acceptPersonId;		// 受检单位指定的责任人
	private String ractificationPersonId;		// ractification_person_id
	private String ractificationStateId;		// 检查项的整改状态
	private Date acceptTime;		// 指定的开始时间
	private Date specifyEndTime;		// 指定的结束时间
	private Date realEndTime;		// real_end_time
	private String closerId;		// closer_id
	private Date closeTime;		// close_time
	private String documentId;		// 文档即附件集合的标识，可以关联多个附件
	private Date uploadTime;		// upload_time
	private String procInsId;		// 流程实例id
	private String reporterComment;		// 问题上报者意见
	private String reporterLeaderComment;		// 问题上报者部门负责人意见
	private String rectifierLeaderComment;		// 整改部门负责人意见
	private String rectifierComment;		// 整改者意见
	private User user;
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Question() {
		super();
	}

	public Question(String id){
		super(id);
	}

	@Length(min=0, max=64, message="check_item_id长度必须介于 0 和 64 之间")
	public String getCheckItemId() {
		return checkItemId;
	}

	public void setCheckItemId(String checkItemId) {
		this.checkItemId = checkItemId;
	}
	
	@Length(min=0, max=255, message="问题描述长度必须介于 0 和 255 之间")
	public String getQuestionDesc() {
		return questionDesc;
	}

	public void setQuestionDesc(String questionDesc) {
		this.questionDesc = questionDesc;
	}
	
	@Length(min=0, max=255, message="问题类别长度必须介于 0 和 255 之间")
	public String getQuestionClassId() {
		return questionClassId;
	}

	public void setQuestionClassId(String questionClassId) {
		this.questionClassId = questionClassId;
	}
	
	@Length(min=0, max=64, message="问题级别长度必须介于 0 和 64 之间")
	public String getQuestionLevelId() {
		return questionLevelId;
	}

	public void setQuestionLevelId(String questionLevelId) {
		this.questionLevelId = questionLevelId;
	}
	
	@Length(min=0, max=64, message="引用数据字典的ID，该类别引用的是内部单位，则受检单位ID是公司部门ID，否则是承包商的名称或ID            此字段应在问题表中长度必须介于 0 和 64 之间")
	public String getInspectionDeptTypeId() {
		return inspectionDeptTypeId;
	}

	public void setInspectionDeptTypeId(String inspectionDeptTypeId) {
		this.inspectionDeptTypeId = inspectionDeptTypeId;
	}
	
	@Length(min=0, max=64, message="该问题的处理状态有：受理中，审批中，待关闭，已关闭。长度必须介于 0 和 64 之间")
	public String getStateId() {
		return stateId;
	}

	public void setStateId(String stateId) {
		this.stateId = stateId;
	}
	
	@Length(min=0, max=255, message="上报人所在部门领导审批上报问题长度必须介于 0 和 255 之间")
	public String getApprovalOpinion() {
		return approvalOpinion;
	}

	public void setApprovalOpinion(String approvalOpinion) {
		this.approvalOpinion = approvalOpinion;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getApprovalTime() {
		return approvalTime;
	}

	public void setApprovalTime(Date approvalTime) {
		this.approvalTime = approvalTime;
	}
	
	@Length(min=0, max=64, message="受检单位指定的责任人长度必须介于 0 和 64 之间")
	public String getAcceptPersonId() {
		return acceptPersonId;
	}

	public void setAcceptPersonId(String acceptPersonId) {
		this.acceptPersonId = acceptPersonId;
	}
	
	@Length(min=0, max=64, message="ractification_person_id长度必须介于 0 和 64 之间")
	public String getRactificationPersonId() {
		return ractificationPersonId;
	}

	public void setRactificationPersonId(String ractificationPersonId) {
		this.ractificationPersonId = ractificationPersonId;
	}
	
	@Length(min=0, max=64, message="检查项的整改状态长度必须介于 0 和 64 之间")
	public String getRactificationStateId() {
		return ractificationStateId;
	}

	public void setRactificationStateId(String ractificationStateId) {
		this.ractificationStateId = ractificationStateId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAcceptTime() {
		return acceptTime;
	}

	public void setAcceptTime(Date acceptTime) {
		this.acceptTime = acceptTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSpecifyEndTime() {
		return specifyEndTime;
	}

	public void setSpecifyEndTime(Date specifyEndTime) {
		this.specifyEndTime = specifyEndTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRealEndTime() {
		return realEndTime;
	}

	public void setRealEndTime(Date realEndTime) {
		this.realEndTime = realEndTime;
	}
	
	@Length(min=0, max=64, message="closer_id长度必须介于 0 和 64 之间")
	public String getCloserId() {
		return closerId;
	}

	public void setCloserId(String closerId) {
		this.closerId = closerId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(Date closeTime) {
		this.closeTime = closeTime;
	}
	
	@Length(min=0, max=64, message="文档即附件集合的标识，可以关联多个附件长度必须介于 0 和 64 之间")
	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	
	@Length(min=0, max=64, message="流程实例id长度必须介于 0 和 64 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=255, message="问题上报者意见长度必须介于 0 和 255 之间")
	public String getReporterComment() {
		return reporterComment;
	}

	public void setReporterComment(String reporterComment) {
		this.reporterComment = reporterComment;
	}
	
	@Length(min=0, max=255, message="问题上报者部门负责人意见长度必须介于 0 和 255 之间")
	public String getReporterLeaderComment() {
		return reporterLeaderComment;
	}

	public void setReporterLeaderComment(String reporterLeaderComment) {
		this.reporterLeaderComment = reporterLeaderComment;
	}
	
	@Length(min=0, max=255, message="整改部门负责人意见长度必须介于 0 和 255 之间")
	public String getRectifierLeaderComment() {
		return rectifierLeaderComment;
	}

	public void setRectifierLeaderComment(String rectifierLeaderComment) {
		this.rectifierLeaderComment = rectifierLeaderComment;
	}
	
	@Length(min=0, max=255, message="整改者意见长度必须介于 0 和 255 之间")
	public String getRectifierComment() {
		return rectifierComment;
	}

	public void setRectifierComment(String rectifierComment) {
		this.rectifierComment = rectifierComment;
	}
	
}
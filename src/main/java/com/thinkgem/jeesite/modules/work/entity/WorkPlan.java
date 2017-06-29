/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.common.persistence.TreeEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 工作计划管理Entity
 * @author 何其锟
 * @version 2017-04-07
 */
public class WorkPlan extends TreeEntity<WorkPlan> implements Cloneable{
	@Override
	public WorkPlan clone() {
		WorkPlan wp = null;
		try {
			wp = (WorkPlan)super.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return wp;
	}
	private static final long serialVersionUID = 1L;

	private ActEntity<WorkPlan> actData = null;
	
	public ActEntity<WorkPlan> getActData() {
		return actData;
	}

	public void setActData(ActEntity<WorkPlan> actData) {
		this.actData = actData;
		this.actData.setOutObj(this);
	}
	private ArrayList<WorkPlan> childWorkPlan = new ArrayList<WorkPlan>();
	private User currentAuditUse = null;
	public User getCurrentAuditUse() {
		return currentAuditUse;
	}

	public void setCurrentAuditUse(User currentAuditUse) {
		this.currentAuditUse = currentAuditUse;
	}
	private WorkType workType;		// 工作类别
	private Date requiredFinishTime;		// 要求结束时间
	private Date startTime;		// 工作开始时间
	private Date planedFinishTime;		// 计划结束时间
	private Office depts;		// 部门
	private User personLiable;		// ָ责任人
	private Date actualFinishTime;		// 实际结束时间
	private String workLevelId;		// 工作级别
	private String workDesc;		// 工作描述
	private String jobRequire;		// 工作要求
	private String zskId;		// zsk_id
	private String workStateId;		// 工作状态
	private boolean isOpen;		// 是否公开
	private boolean isCancel;		// 是否取消
	private String cancelReason;		// 取消原因
	private boolean isRemove;		// 是否删除
	private String removeReason;		// 删除原因
	private boolean isApprovable;		// 是否需要审核
	private boolean isApproveUpdate;		// 审核人能否更改
	private boolean isRetainsApproveUpdate;		// 是否保留审核者的更新
	private String approveOpinion;		// approve_opinion
	private String myDept;      //当前登陆用户所有部门的name字段
	private String timeType;		//时间类别
	private String attachFiles;//附件路径集合
	public String getAttachFiles() {
		return attachFiles;
	}
	public void setAttachFiles(String attachFiles) {
		this.attachFiles = attachFiles;
	}
	/**
	 * 接受任务时间，已经淘汰不用。因公司任务分派给多个部门，所以同一任务的接受也是多个部门的信息，原设计用单一属性是错误的
	 */
	@Deprecated
	private Date acceptanceTime;
	private String assignerId;		// 指派人
	private Date assignTime;		// 指派时间
	private String endStateId;		// 结束状态
	private String frequency;		// 频次
	private String planType;     //计划类型ID：如个人计划，部门计划，公司计划
	private Dict planTypeDetail; //计划类型详细内容
	
	private String workLevel; //级别
	private boolean workSubmit = false;//是否提交
	private boolean noedit = false; //是否不可编辑
	private String workState;
	private Set<WorkPlanRemain> remains;//工作受理信息集合
	/**
	 * 当前受理部门ID：
	 *    此ID为正在处理受理工作的部门的部门ID
	 *    此属性值包含在depts属性中，数据库中工作计划表并不需要保留此属性值
	 *    而是作为受理信息与受理人，受理时间等信息一起存放在受理信息表中
	 */
	private String currentRemainDeptId;
	/**
	 * 当前受理工作人留言
	 *    当前受理工作时的留言信息
	 *    此属性值并非保存在工作计划表中，而是与受理人，受理部门等信息一起存在受理信息表中
	 */
	private String reminderDesc;
	/**
	 * 受理状态ID
	 */
	private String remainStateId;

	
	/**
	 * 存储受理人ID的临时变量
	 */
	private String userId;
	private String endState; //结束状态的中文名字
	private boolean isOver; //是否工作处理结束(预结束，关闭才是真正结束)
	private String feedbackDesc;//当次反馈消息
	private boolean isReply;//是否回复过
	private String feedbackId;//反馈ID
	private Date feedBackTime;//反馈时间
	private String replyContent;//回复内容
	private String replyId;//回复ID
	private User replyPeople;//回复人
	private Date replyTime;//回复时间
	private String commentContent; //点评内容
	private int score;//打分
	
	/***************************************************************************************
	 **********************************Remain受理表数据开始***********************************
	 ***************************************************************************************/
	private String remainId;
	private String remainDesc;
	private String remainnerId;
	private String remainDeptId;
	private String remainWorkPlanId;
	private String remainDelFlag;
	private String remainRemarks;
	private Date remainUpdateDate;
	private String remainUpdateBy;
	private Date remainCreateDate;
	private String remainCreateBy;
	private String remainName;
	private String remainDeptName;
	
	/***************************************************************************************
	 **********************************Remain受理表数据结束***********************************
	 ***************************************************************************************/
	private String newFeedback; //最新反馈
	private String feebackPeopleId; //反馈人
	private Date feedbackTime; //最新反馈时间
	private String newReply; //最新回复
	private String type;//类型反馈或回复
	private String replyPeopleId; //回复人ID
	public String getNewReply() {
		return newReply;
	}

	public void setNewReply(String newReply) {
		this.newReply = newReply;
	}

	public String getReplyPeopleId() {
		return replyPeopleId;
	}

	public void setReplyPeopleId(String replyPeopleId) {
		this.replyPeopleId = replyPeopleId;
	}
	public String getNewFeedback() {
		return newFeedback;
	}

	public void setNewFeedback(String newFeedback) {
		this.newFeedback = newFeedback;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public Dict getPlanTypeDetail() {
		return planTypeDetail;
	}
	public void setPlanTypeDetail(Dict planTypeDetail) {
		this.planTypeDetail = planTypeDetail;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getFeedbackId() {
		return feedbackId;
	}
	public void setFeedbackId(String feedbackId) {
		this.feedbackId = feedbackId;
	}
	public Date getFeedBackTime() {
		return feedBackTime;
	}
	public void setFeedBackTime(Date feedBackTime) {
		this.feedBackTime = feedBackTime;
	}
	public User getReplyPeople() {
		return replyPeople;
	}
	public void setReplyPeople(User replyPeople) {
		this.replyPeople = replyPeople;
	}
	public Date getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
	public String getReplyId() {
		return replyId;
	}
	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}
	public String getRemainStateId() {
		return remainStateId;
	}
	public void setRemainStateId(String remainStateId) {
		this.remainStateId = remainStateId;
	}
	public String getMyDept() {
		return myDept;
	}
	public void setMyDept(String myDept) {
		this.myDept = myDept;
	}
	public String getTimeType() {
		return timeType;
	}
	public void setTimeType(String timeType) {
		this.timeType = timeType;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	
	public boolean getIsReply() {
		return isReply;
	}
	public void setIsReply(boolean isReply) {
		this.isReply = isReply;
	}
	public boolean getIsOver() {
		return isOver;
	}
	public void setIsOver(boolean isOver) {
		this.isOver = isOver;
	}
	public String getFeedbackDesc() {
		return feedbackDesc;
	}
	public void setFeedbackDesc(String feedbackDesc) {
		this.feedbackDesc = feedbackDesc;
	}
	public String getEndState() {
		return endState;
	}
	public void setEndState(String endState) {
		this.endState = endState;
	}
	public String getRemainDeptName() {
		return remainDeptName;
	}
	public void setRemainDeptName(String remainDeptName) {
		this.remainDeptName = remainDeptName;
	}
	public String getRemainCreateBy() {
		return remainCreateBy;
	}
	public void setRemainCreateBy(String remainCreateBy) {
		this.remainCreateBy = remainCreateBy;
	}
	public String getRemainName() {
		return remainName;
	}
	public void setRemainName(String remainName) {
		this.remainName = remainName;
	}
	public String getRemainDesc() {
		return remainDesc;
	}
	public String getRemainId() {
		return remainId;
	}
	public void setRemainId(String remainId) {
		this.remainId = remainId;
	}
	public String getRemainDelFlag() {
		return remainDelFlag;
	}
	public void setRemainDelFlag(String remainDelFlag) {
		this.remainDelFlag = remainDelFlag;
	}
	public String getRemainRemarks() {
		return remainRemarks;
	}
	public void setRemainRemarks(String remainRemark) {
		this.remainRemarks = remainRemark;
	}
	public Date getRemainUpdateDate() {
		return remainUpdateDate;
	}
	public void setRemainUpdateDate(Date remainUpdateDate) {
		this.remainUpdateDate = remainUpdateDate;
	}
	public String getRemainUpdateBy() {
		return remainUpdateBy;
	}
	public void setRemainUpdateBy(String remainUpdateBy) {
		this.remainUpdateBy = remainUpdateBy;
	}
	public Date getRemainCreateDate() {
		return remainCreateDate;
	}
	public void setRemainCreateDate(Date remainCreateDate) {
		this.remainCreateDate = remainCreateDate;
	}
	public void setRemainDesc(String remainDesc) {
		this.remainDesc = remainDesc;
	}
	public String getRemainnerId() {
		return remainnerId;
	}
	public void setRemainnerId(String remainnerId) {
		this.remainnerId = remainnerId;
	}
	public String getRemainDeptId() {
		return remainDeptId;
	}
	public void setRemainDeptId(String remainDeptId) {
		this.remainDeptId = remainDeptId;
	}
	public String getRemainWorkPlanId() {
		return remainWorkPlanId;
	}
	public void setRemainWorkPlanId(String remainWorkPlanId) {
		this.remainWorkPlanId = remainWorkPlanId;
	}
	/**
	 * 
	 * @return
	 */
	@ExcelField(title="ID", type=1, align=2, sort=1)
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getAcceptanceTime() {
		return acceptanceTime;
	}

	public void setAcceptanceTime(Date acceptanceTime) {
		this.acceptanceTime = acceptanceTime;
	}
	public String getReminderDesc() {
		return reminderDesc;
	}

	public void setReminderDesc(String reminderDesc) {
		this.reminderDesc = reminderDesc;
	}
	public String getCurrentRemainDeptId() {
		return currentRemainDeptId;
	}
	public void setCurrentRemainDeptId(String currentRemainDeptId) {
		this.currentRemainDeptId = currentRemainDeptId;
	}
	public Set<WorkPlanRemain> getRemains() {
		return remains;
	}
	public void setRemains(Set<WorkPlanRemain> remains) {
		this.remains = remains;
	}
	@ExcelField(title="工作级别", align=2, sort=20)
	public String getWorkLevel() {
		return workLevel;
	}
	public void setWorkLevel(String workLevel) {
		this.workLevel = workLevel;
	}
	public String getWorkState() {
		return workState;
	}
	public void setWorkState(String work_state) {
		this.workState = work_state;
	}
	public boolean isNoedit() {
		return noedit;
	}
	public void setNoedit(boolean noedit) {
		this.noedit = noedit;
	}
	public boolean isWorkSubmit() {
		return workSubmit;
	}
	public void setWorkSubmit(boolean workSubmit) {
		this.workSubmit = workSubmit;
	}
	@ExcelField(title="工作类别", align=2, sort=30)
	public String getPlanType() {
		return planType;
	}
	public void setPlanType(String planType) {
		this.planType = planType;
	}
	public WorkPlan() {
		super();
	}
	public WorkPlan(String id){
		super(id);
	}
	public WorkType getWorkType() {
		return workType;
	}
	public void setWorkType(WorkType workType) {
		this.workType = workType;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getRequiredFinishTime() {
		return requiredFinishTime;
	}
	public void setRequiredFinishTime(Date requiredFinishTime) {
		this.requiredFinishTime = requiredFinishTime;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPlanedFinishTime() {
		return planedFinishTime;
	}
	public void setPlanedFinishTime(Date planedFinishTime) {
		this.planedFinishTime = planedFinishTime;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getActualFinishTime() {
		return actualFinishTime;
	}
	public void setActualFinishTime(Date actualFinishTime) {
		this.actualFinishTime = actualFinishTime;
	}
	@Length(min=0, max=64, message="工作级别长度必须介于 0 和 64 之间")
	public String getWorkLevelId() {
		return workLevelId;
	}
	public void setWorkLevelId(String workLevelId) {
		this.workLevelId = workLevelId;
	}
	@Length(min=0, max=255, message="工作描述长度必须介于 0 和 255 之间")
	public String getWorkDesc() {
		return workDesc;
	}
	public void setWorkDesc(String workDesc) {
		this.workDesc = workDesc;
	}
	@Length(min=0, max=255, message="工作要求长度必须介于 0 和 255 之间")
	public String getJobRequire() {
		return jobRequire;
	}
	public void setJobRequire(String jobRequire) {
		this.jobRequire = jobRequire;
	}
	@Length(min=0, max=200, message="zsk_id长度必须介于 0 和 200 之间")
	public String getZskId() {
		return zskId;
	}
	public void setZskId(String zskId) {
		this.zskId = zskId;
	}
	@Length(min=0, max=64, message="工作状态长度必须介于 0 和 64 之间")
	public String getWorkStateId() {
		return workStateId;
	}
	public void setWorkStateId(String workStateId) {
		this.workStateId = workStateId;
	}
	public boolean getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(boolean isOpen) {
		this.isOpen = isOpen;
	}
	@JsonBackReference
	public WorkPlan getParent() {
		return parent;
	}
	public void setParent(WorkPlan parent) {
		this.parent = parent;
	}
	public boolean getIsCancel() {
		return isCancel;
	}
	public void setIsCancel(boolean isCancel) {
		this.isCancel = isCancel;
	}
	@Length(min=0, max=255, message="取消原因长度必须介于 0 和 255 之间")
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	public boolean getIsRemove() {
		return isRemove;
	}
	public void setIsRemove(boolean isRemove) {
		this.isRemove = isRemove;
	}
	@Length(min=0, max=255, message="删除原因长度必须介于 0 和 255 之间")
	public String getRemoveReason() {
		return removeReason;
	}

	public void setRemoveReason(String removeReason) {
		this.removeReason = removeReason;
	}
	
	public boolean getIsApprovable() {
		return isApprovable;
	}

	public void setIsApprovable(boolean isApprovable) {
		this.isApprovable = isApprovable;
	}
	
	public boolean getIsApproveUpdate() {
		return isApproveUpdate;
	}

	public void setIsApproveUpdate(boolean isApproveUpdate) {
		this.isApproveUpdate = isApproveUpdate;
	}
	
	public boolean getIsRetainsApproveUpdate() {
		return isRetainsApproveUpdate;
	}

	public void setIsRetainsApproveUpdate(boolean isRetainsApproveUpdate) {
		this.isRetainsApproveUpdate = isRetainsApproveUpdate;
	}
	
	@Length(min=0, max=255, message="approve_opinion长度必须介于 0 和 255 之间")
	public String getApproveOpinion() {
		return approveOpinion;
	}

	public void setApproveOpinion(String approveOpinion) {
		this.approveOpinion = approveOpinion;
	}
	
	
	@Length(min=0, max=64, message="指派人长度必须介于 0 和 64 之间")
	public String getAssignerId() {
		return assignerId;
	}

	public void setAssignerId(String assignerId) {
		this.assignerId = assignerId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAssignTime() {
		return assignTime;
	}

	public void setAssignTime(Date assignTime) {
		this.assignTime = assignTime;
	}

	@Length(min=0, max=64, message="结束状态长度必须介于 0 和 64 之间")
	public String getEndStateId() {
		return endStateId;
	}

	public void setEndStateId(String endStateId) {
		this.endStateId = endStateId;
	}
	
	@Length(min=0, max=200, message="频次长度必须介于 0 和 200 之间")
	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}

	public User getPersonLiable() {
		return personLiable;
	}

	public void setPersonLiable(User personLiable) {
		this.personLiable = personLiable;
	}

	public Office getDepts() {
		return depts;
	}

	public void setDepts(Office depts) {
		this.depts = depts;
	}
	public ArrayList<WorkPlan> getChildWorkPlan() {
		return childWorkPlan;
	}
	public void setChildWorkPlan(ArrayList<WorkPlan> childWorkPlan) {
		this.childWorkPlan = childWorkPlan;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((acceptanceTime == null) ? 0 : acceptanceTime.hashCode());
		result = prime * result + ((actualFinishTime == null) ? 0 : actualFinishTime.hashCode());
		result = prime * result + ((approveOpinion == null) ? 0 : approveOpinion.hashCode());
		result = prime * result + ((assignTime == null) ? 0 : assignTime.hashCode());
		result = prime * result + ((assignerId == null) ? 0 : assignerId.hashCode());
		result = prime * result + ((cancelReason == null) ? 0 : cancelReason.hashCode());
		result = prime * result + ((currentRemainDeptId == null) ? 0 : currentRemainDeptId.hashCode());
		result = prime * result + ((depts == null) ? 0 : depts.hashCode());
		result = prime * result + ((endStateId == null) ? 0 : endStateId.hashCode());
		result = prime * result + ((frequency == null) ? 0 : frequency.hashCode());
		result = prime * result + (isApprovable ? 1231 : 1237);
		result = prime * result + (isApproveUpdate ? 1231 : 1237);
		result = prime * result + (isCancel ? 1231 : 1237);
		result = prime * result + (isOpen ? 1231 : 1237);
		result = prime * result + (isRemove ? 1231 : 1237);
		result = prime * result + (isRetainsApproveUpdate ? 1231 : 1237);
		result = prime * result + ((jobRequire == null) ? 0 : jobRequire.hashCode());
		result = prime * result + (noedit ? 1231 : 1237);
		result = prime * result + ((personLiable == null) ? 0 : personLiable.hashCode());
		result = prime * result + ((planType == null) ? 0 : planType.hashCode());
		result = prime * result + ((planedFinishTime == null) ? 0 : planedFinishTime.hashCode());
		result = prime * result + ((remainCreateBy == null) ? 0 : remainCreateBy.hashCode());
		result = prime * result + ((remainCreateDate == null) ? 0 : remainCreateDate.hashCode());
		result = prime * result + ((remainDelFlag == null) ? 0 : remainDelFlag.hashCode());
		result = prime * result + ((remainDeptId == null) ? 0 : remainDeptId.hashCode());
		result = prime * result + ((remainDesc == null) ? 0 : remainDesc.hashCode());
		result = prime * result + ((remainId == null) ? 0 : remainId.hashCode());
		result = prime * result + ((remainName == null) ? 0 : remainName.hashCode());
		result = prime * result + ((remainRemarks == null) ? 0 : remainRemarks.hashCode());
		result = prime * result + ((remainUpdateBy == null) ? 0 : remainUpdateBy.hashCode());
		result = prime * result + ((remainUpdateDate == null) ? 0 : remainUpdateDate.hashCode());
		result = prime * result + ((remainWorkPlanId == null) ? 0 : remainWorkPlanId.hashCode());
		result = prime * result + ((remainnerId == null) ? 0 : remainnerId.hashCode());
		result = prime * result + ((remains == null) ? 0 : remains.hashCode());
		result = prime * result + ((reminderDesc == null) ? 0 : reminderDesc.hashCode());
		result = prime * result + ((removeReason == null) ? 0 : removeReason.hashCode());
		result = prime * result + ((requiredFinishTime == null) ? 0 : requiredFinishTime.hashCode());
		result = prime * result + ((startTime == null) ? 0 : startTime.hashCode());
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		result = prime * result + ((workDesc == null) ? 0 : workDesc.hashCode());
		result = prime * result + ((workLevel == null) ? 0 : workLevel.hashCode());
		result = prime * result + ((workLevelId == null) ? 0 : workLevelId.hashCode());
		result = prime * result + ((workState == null) ? 0 : workState.hashCode());
		result = prime * result + ((workStateId == null) ? 0 : workStateId.hashCode());
		result = prime * result + (workSubmit ? 1231 : 1237);
		result = prime * result + ((workType == null) ? 0 : workType.hashCode());
		result = prime * result + ((zskId == null) ? 0 : zskId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		WorkPlan other = (WorkPlan) obj;
		if (acceptanceTime == null) {
			if (other.acceptanceTime != null)
				return false;
		} else if (!acceptanceTime.equals(other.acceptanceTime))
			return false;
		if (actualFinishTime == null) {
			if (other.actualFinishTime != null)
				return false;
		} else if (!actualFinishTime.equals(other.actualFinishTime))
			return false;
		if (approveOpinion == null) {
			if (other.approveOpinion != null)
				return false;
		} else if (!approveOpinion.equals(other.approveOpinion))
			return false;
		if (assignTime == null) {
			if (other.assignTime != null)
				return false;
		} else if (!assignTime.equals(other.assignTime))
			return false;
		if (assignerId == null) {
			if (other.assignerId != null)
				return false;
		} else if (!assignerId.equals(other.assignerId))
			return false;
		if (cancelReason == null) {
			if (other.cancelReason != null)
				return false;
		} else if (!cancelReason.equals(other.cancelReason))
			return false;
		if (currentRemainDeptId == null) {
			if (other.currentRemainDeptId != null)
				return false;
		} else if (!currentRemainDeptId.equals(other.currentRemainDeptId))
			return false;
		if (depts == null) {
			if (other.depts != null)
				return false;
		} else if (!depts.equals(other.depts))
			return false;
		if (endStateId == null) {
			if (other.endStateId != null)
				return false;
		} else if (!endStateId.equals(other.endStateId))
			return false;
		if (frequency == null) {
			if (other.frequency != null)
				return false;
		} else if (!frequency.equals(other.frequency))
			return false;
		if (isApprovable != other.isApprovable)
			return false;
		if (isApproveUpdate != other.isApproveUpdate)
			return false;
		if (isCancel != other.isCancel)
			return false;
		if (isOpen != other.isOpen)
			return false;
		if (isRemove != other.isRemove)
			return false;
		if (isRetainsApproveUpdate != other.isRetainsApproveUpdate)
			return false;
		if (jobRequire == null) {
			if (other.jobRequire != null)
				return false;
		} else if (!jobRequire.equals(other.jobRequire))
			return false;
		if (noedit != other.noedit)
			return false;
		if (personLiable == null) {
			if (other.personLiable != null)
				return false;
		} else if (!personLiable.equals(other.personLiable))
			return false;
		if (planType == null) {
			if (other.planType != null)
				return false;
		} else if (!planType.equals(other.planType))
			return false;
		if (planedFinishTime == null) {
			if (other.planedFinishTime != null)
				return false;
		} else if (!planedFinishTime.equals(other.planedFinishTime))
			return false;
		if (remainCreateBy == null) {
			if (other.remainCreateBy != null)
				return false;
		} else if (!remainCreateBy.equals(other.remainCreateBy))
			return false;
		if (remainCreateDate == null) {
			if (other.remainCreateDate != null)
				return false;
		} else if (!remainCreateDate.equals(other.remainCreateDate))
			return false;
		if (remainDelFlag == null) {
			if (other.remainDelFlag != null)
				return false;
		} else if (!remainDelFlag.equals(other.remainDelFlag))
			return false;
		if (remainDeptId == null) {
			if (other.remainDeptId != null)
				return false;
		} else if (!remainDeptId.equals(other.remainDeptId))
			return false;
		if (remainDesc == null) {
			if (other.remainDesc != null)
				return false;
		} else if (!remainDesc.equals(other.remainDesc))
			return false;
		if (remainId == null) {
			if (other.remainId != null)
				return false;
		} else if (!remainId.equals(other.remainId))
			return false;
		if (remainName == null) {
			if (other.remainName != null)
				return false;
		} else if (!remainName.equals(other.remainName))
			return false;
		if (remainRemarks == null) {
			if (other.remainRemarks != null)
				return false;
		} else if (!remainRemarks.equals(other.remainRemarks))
			return false;
		if (remainUpdateBy == null) {
			if (other.remainUpdateBy != null)
				return false;
		} else if (!remainUpdateBy.equals(other.remainUpdateBy))
			return false;
		if (remainUpdateDate == null) {
			if (other.remainUpdateDate != null)
				return false;
		} else if (!remainUpdateDate.equals(other.remainUpdateDate))
			return false;
		if (remainWorkPlanId == null) {
			if (other.remainWorkPlanId != null)
				return false;
		} else if (!remainWorkPlanId.equals(other.remainWorkPlanId))
			return false;
		if (remainnerId == null) {
			if (other.remainnerId != null)
				return false;
		} else if (!remainnerId.equals(other.remainnerId))
			return false;
		if (remains == null) {
			if (other.remains != null)
				return false;
		} else if (!remains.equals(other.remains))
			return false;
		if (reminderDesc == null) {
			if (other.reminderDesc != null)
				return false;
		} else if (!reminderDesc.equals(other.reminderDesc))
			return false;
		if (removeReason == null) {
			if (other.removeReason != null)
				return false;
		} else if (!removeReason.equals(other.removeReason))
			return false;
		if (requiredFinishTime == null) {
			if (other.requiredFinishTime != null)
				return false;
		} else if (!requiredFinishTime.equals(other.requiredFinishTime))
			return false;
		if (startTime == null) {
			if (other.startTime != null)
				return false;
		} else if (!startTime.equals(other.startTime))
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		if (workDesc == null) {
			if (other.workDesc != null)
				return false;
		} else if (!workDesc.equals(other.workDesc))
			return false;
		if (workLevel == null) {
			if (other.workLevel != null)
				return false;
		} else if (!workLevel.equals(other.workLevel))
			return false;
		if (workLevelId == null) {
			if (other.workLevelId != null)
				return false;
		} else if (!workLevelId.equals(other.workLevelId))
			return false;
		if (workState == null) {
			if (other.workState != null)
				return false;
		} else if (!workState.equals(other.workState))
			return false;
		if (workStateId == null) {
			if (other.workStateId != null)
				return false;
		} else if (!workStateId.equals(other.workStateId))
			return false;
		if (workSubmit != other.workSubmit)
			return false;
		if (workType == null) {
			if (other.workType != null)
				return false;
		} else if (!workType.equals(other.workType))
			return false;
		if (zskId == null) {
			if (other.zskId != null)
				return false;
		} else if (!zskId.equals(other.zskId))
			return false;
		return true;
	}
}
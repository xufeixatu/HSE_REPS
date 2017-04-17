/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonBackReference;

import com.thinkgem.jeesite.common.persistence.TreeEntity;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 工作计划管理Entity
 * @author 何其锟
 * @version 2017-04-07
 */
public class WorkPlan extends TreeEntity<WorkPlan> {
	
	private static final long serialVersionUID = 1L;
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
	private String reminderDesc;		// 任务接受人留言
	private String assignerId;		// 指派人
	private Date assignTime;		// 指派时间
	private Date acceptanceTime;		// 接受时间
	private String endStateId;		// 结束状态
	private String frequency;		// 频次
	private String planType;     //计划类型：如个人计划，部门计划，公司计划
	private String workLevel; //级别
	
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

//	@Length(min=0, max=64, message="工作类别长度必须介于 0 和 64 之间")
//	public String getWorkTypeId() {
//		return workTypeId;
//	}
//
//	public void setWorkTypeId(String workTypeId) {
//		this.workTypeId = workTypeId;
//	}
	
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
	
	@Length(min=0, max=255, message="任务接受人留言长度必须介于 0 和 255 之间")
	public String getReminderDesc() {
		return reminderDesc;
	}

	public void setReminderDesc(String reminderDesc) {
		this.reminderDesc = reminderDesc;
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
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAcceptanceTime() {
		return acceptanceTime;
	}

	public void setAcceptanceTime(Date acceptanceTime) {
		this.acceptanceTime = acceptanceTime;
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


}
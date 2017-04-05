/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.work.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonBackReference;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 工作计划管理Entity
 * @author 何其锟
 * @version 2017-04-05
 */
public class WorkPlan extends DataEntity<WorkPlan> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 工作计划标题
	private String workTypeId;		// work_type_id
	private Date requiredFinishTime;		// 要求结束时间
	private Date startTime;		// 开始时间
	private Date planedFinishTime;		// 计划结束时间
	private String deptId;		// 部门ID
	private String personLiableId;		// ָ责任人ID
	private Date actualFinishTime;		// 实际结束时间
	private String workLevelId;		// 工作级别ID
	private String workDesc;		// 工作描述
	private String jobRequire;		// 工作要求
	private String zskId;		// 附件ID集合
	private String workStateId;		// 工作状态ID
	private String isOpen;		// 是否打开
	private WorkPlan parent;		// parent_id
	private String isCancel;		// 是否取消
	private String cancelReason;		// 取消原因
	private String isRemove;		// 是否删除
	private String removeReason;		// 删除原因
	private String isApprovable;		// 是否核准
	private String isApproveUpdate;		// 核准后是否可更新
	private String isRetainsApproveUpdate;		// 是否保留核准后更新历史
	private String approveOpinion;		// 此字段淘汰
	private String reminderDesc;		// 催办描述
	private String assignerId;		// 指派人ID
	private Date assignTime;		// 指派时间
	private Date acceptanceTime;		// 接受指派任务的时间
	private String endStateId;		// 结束状态ID
	private String frequency;		// 频次
	private String sort;		// sort
	private String name;		// name
	private String parentIds;		// parent_ids
	
	public WorkPlan() {
		super();
	}

	public WorkPlan(String id){
		super(id);
	}

	@Length(min=1, max=200, message="工作计划标题长度必须介于 1 和 200 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=64, message="work_type_id长度必须介于 0 和 64 之间")
	public String getWorkTypeId() {
		return workTypeId;
	}

	public void setWorkTypeId(String workTypeId) {
		this.workTypeId = workTypeId;
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
	
	@Length(min=0, max=64, message="部门ID长度必须介于 0 和 64 之间")
	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	
	@Length(min=0, max=64, message="ָ责任人ID长度必须介于 0 和 64 之间")
	public String getPersonLiableId() {
		return personLiableId;
	}

	public void setPersonLiableId(String personLiableId) {
		this.personLiableId = personLiableId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getActualFinishTime() {
		return actualFinishTime;
	}

	public void setActualFinishTime(Date actualFinishTime) {
		this.actualFinishTime = actualFinishTime;
	}
	
	@Length(min=0, max=64, message="工作级别ID长度必须介于 0 和 64 之间")
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
	
	@Length(min=0, max=200, message="附件ID集合长度必须介于 0 和 200 之间")
	public String getZskId() {
		return zskId;
	}

	public void setZskId(String zskId) {
		this.zskId = zskId;
	}
	
	@Length(min=0, max=64, message="工作状态ID长度必须介于 0 和 64 之间")
	public String getWorkStateId() {
		return workStateId;
	}

	public void setWorkStateId(String workStateId) {
		this.workStateId = workStateId;
	}
	
	@Length(min=0, max=1, message="是否打开长度必须介于 0 和 1 之间")
	public String getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}
	
	@JsonBackReference
	public WorkPlan getParent() {
		return parent;
	}

	public void setParent(WorkPlan parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=1, message="是否取消长度必须介于 0 和 1 之间")
	public String getIsCancel() {
		return isCancel;
	}

	public void setIsCancel(String isCancel) {
		this.isCancel = isCancel;
	}
	
	@Length(min=0, max=255, message="取消原因长度必须介于 0 和 255 之间")
	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	
	@Length(min=0, max=1, message="是否删除长度必须介于 0 和 1 之间")
	public String getIsRemove() {
		return isRemove;
	}

	public void setIsRemove(String isRemove) {
		this.isRemove = isRemove;
	}
	
	@Length(min=0, max=255, message="删除原因长度必须介于 0 和 255 之间")
	public String getRemoveReason() {
		return removeReason;
	}

	public void setRemoveReason(String removeReason) {
		this.removeReason = removeReason;
	}
	
	@Length(min=0, max=1, message="是否核准长度必须介于 0 和 1 之间")
	public String getIsApprovable() {
		return isApprovable;
	}

	public void setIsApprovable(String isApprovable) {
		this.isApprovable = isApprovable;
	}
	
	@Length(min=0, max=1, message="核准后是否可更新长度必须介于 0 和 1 之间")
	public String getIsApproveUpdate() {
		return isApproveUpdate;
	}

	public void setIsApproveUpdate(String isApproveUpdate) {
		this.isApproveUpdate = isApproveUpdate;
	}
	
	@Length(min=0, max=1, message="是否保留核准后更新历史长度必须介于 0 和 1 之间")
	public String getIsRetainsApproveUpdate() {
		return isRetainsApproveUpdate;
	}

	public void setIsRetainsApproveUpdate(String isRetainsApproveUpdate) {
		this.isRetainsApproveUpdate = isRetainsApproveUpdate;
	}
	
	@Length(min=0, max=255, message="此字段淘汰长度必须介于 0 和 255 之间")
	public String getApproveOpinion() {
		return approveOpinion;
	}

	public void setApproveOpinion(String approveOpinion) {
		this.approveOpinion = approveOpinion;
	}
	
	@Length(min=0, max=255, message="催办描述长度必须介于 0 和 255 之间")
	public String getReminderDesc() {
		return reminderDesc;
	}

	public void setReminderDesc(String reminderDesc) {
		this.reminderDesc = reminderDesc;
	}
	
	@Length(min=0, max=64, message="指派人ID长度必须介于 0 和 64 之间")
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
	
	@Length(min=0, max=64, message="结束状态ID长度必须介于 0 和 64 之间")
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
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=100, message="name长度必须介于 0 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=2000, message="parent_ids长度必须介于 0 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
}
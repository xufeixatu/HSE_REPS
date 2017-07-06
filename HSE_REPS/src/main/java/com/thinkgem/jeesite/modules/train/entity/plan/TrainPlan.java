/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.entity.plan;

import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 培训计划信息Entity
 * @author peizhen
 * @version 2017-05-20
 */
public class TrainPlan extends DataEntity<TrainPlan> {
	
	private static final long serialVersionUID = 1L;
	private Office objectOffice;		// 受训单位
	private String classify;		// 培训分类
	private String name;		// 培训课题
	private String trainObject;		// 培训对象分类
	private Date trainTime;		// 培训时间
	private String period;		// 学时
	private Integer planNumber;		// 拟培人数
	private String trainMethod;		// 培训方式分类
	private Office subjectOffice;		// 负责单位
	private String frequency;		// 培训频率
	private String requirement;		// 培训要求
	private String status;     //计划状态
	public TrainPlan() {
		super();
	}

	public TrainPlan(String id){
		super(id);
	}

	
	@NotNull(message="受训单位不能为空")
	@ExcelField(title="受训单位", align=2, sort=20)
	public Office getObjectOffice() {
		return objectOffice;
	}

	public void setObjectOffice(Office objectOffice) {
		this.objectOffice = objectOffice;
	}
	
	@Length(min=1, max=8, message="培训分类长度必须介于 1 和 8 之间")
	@ExcelField(title="培训分类", align=2, sort=30,dictType="train_plan_classify")
	public String getClassify() {
		return classify;
	}

	public void setClassify(String classify) {
		this.classify = classify;
	}
	
	@Length(min=1, max=255, message="培训课题长度必须介于 1 和 255 之间")
	@ExcelField(title="培训课题", align=2, sort=40)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=8, message="培训对象分类长度必须介于 1 和 8 之间")
	@ExcelField(title="培训对象分类", align=2, sort=50,dictType="train_objects_classify")
	public String getTrainObject() {
		return trainObject;
	}

	public void setTrainObject(String trainObject) {
		this.trainObject = trainObject;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="培训时间不能为空")
	@ExcelField(title="培训时间", align=2, sort=60)
	public Date getTrainTime() {
		return trainTime;
	}

	public void setTrainTime(Date trainTime) {
		this.trainTime = trainTime;
	}
	
	@Length(min=1, max=32, message="学时长度必须介于 1 和 32 之间")
	@ExcelField(title="学时", align=2, sort=70)
	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}
	
	@NotNull(message="培训人数不能为空")
	@ExcelField(title="培训人数", align=2, sort=80)
	public Integer getPlanNumber() {
		return planNumber;
	}

	
	public void setPlanNumber(Integer planNumber) {
		this.planNumber = planNumber;
	}
	
	@Length(min=1, max=8, message="培训方式分类长度必须介于 1 和 8 之间")
	@ExcelField(title="培训方式分类", align=2, sort=90, dictType="train_methods_classify")
	public String getTrainMethod() {
		return trainMethod;
	}

	public void setTrainMethod(String trainMethod) {
		this.trainMethod = trainMethod;
	}
	
	@NotNull(message="负责单位不能为空")
	@ExcelField(title="负责单位", align=2, sort=100)
	public Office getSubjectOffice() {
		return subjectOffice;
	}

	public void setSubjectOffice(Office subjectOffice) {
		this.subjectOffice = subjectOffice;
	}
	
	@Length(min=1, max=32, message="培训频率长度必须介于 1 和 32 之间")
	@ExcelField(title="培训频率", align=2, sort=110)
	public String getFrequency() {
		return frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	
	@Length(min=1, max=255, message="培训要求长度必须介于 1 和 255 之间")
	@ExcelField(title="培训要求", align=2, sort=120)
	public String getRequirement() {
		return requirement;
	}

	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}

	@NotNull(message="计划状态能为空")
	@ExcelField(title="计划状态", align=2, sort=130)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
package com.thinkgem.jeesite.modules.message.model;


import java.io.Serializable;

/**
 * @author jiachao
 *
 */
public class Message implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String messageId;
	private String text;
	private String avatarPath;
	private String filePath;
	private String thumbPath;
	private String messageType;
	private String nativePath;
	private String conversationType;
	private String objectName;
	private String sendUserId;
	private String messageDirection;
	private String receivedId;
	private String sendTime;
	private String receivedTime;
	private String sendStatus;
	private String taskUrl;
	private String taskStatus;
	private String taskTitle;
	private String remark;
	
	
	
	public Message() {
		super();
	}

	public Message(String text) {
		super();
		this.text = text;
	}

	public Message(String messageId, String text, String avatarPath,
			String filePath, String thumbPath, String messageType,
			String nativePath, String conversationType, String objectName,
			String sendUserId, String messageDirection, String receivedId,
			String sendTime, String receivedTime, String sendStatus,
			String taskUrl, String taskStatus, String taskTitle, String remark) {
		super();
		this.messageId = messageId;
		this.text = text;
		this.avatarPath = avatarPath;
		this.filePath = filePath;
		this.thumbPath = thumbPath;
		this.messageType = messageType;
		this.nativePath = nativePath;
		this.conversationType = conversationType;
		this.objectName = objectName;
		this.sendUserId = sendUserId;
		this.messageDirection = messageDirection;
		this.receivedId = receivedId;
		this.sendTime = sendTime;
		this.receivedTime = receivedTime;
		this.sendStatus = sendStatus;
		this.taskUrl = taskUrl;
		this.taskStatus = taskStatus;
		this.taskTitle = taskTitle;
		this.remark = remark;
	}

	public String getMessageId() {
		return messageId;
	}

	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getAvatarPath() {
		return avatarPath;
	}

	public void setAvatarPath(String avatarPath) {
		this.avatarPath = avatarPath;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getThumbPath() {
		return thumbPath;
	}

	public void setThumbPath(String thumbPath) {
		this.thumbPath = thumbPath;
	}

	public String getMessageType() {
		return messageType;
	}

	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}

	public String getNativePath() {
		return nativePath;
	}

	public void setNativePath(String nativePath) {
		this.nativePath = nativePath;
	}

	public String getConversationType() {
		return conversationType;
	}

	public void setConversationType(String conversationType) {
		this.conversationType = conversationType;
	}

	public String getObjectName() {
		return objectName;
	}

	public void setObjectName(String objectName) {
		this.objectName = objectName;
	}

	public String getSendUserId() {
		return sendUserId;
	}

	public void setSendUserId(String sendUserId) {
		this.sendUserId = sendUserId;
	}

	public String getMessageDirection() {
		return messageDirection;
	}

	public void setMessageDirection(String messageDirection) {
		this.messageDirection = messageDirection;
	}

	public String getReceivedId() {
		return receivedId;
	}

	public void setReceivedId(String receivedId) {
		this.receivedId = receivedId;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getReceivedTime() {
		return receivedTime;
	}

	public void setReceivedTime(String receivedTime) {
		this.receivedTime = receivedTime;
	}

	public String getSendStatus() {
		return sendStatus;
	}

	public void setSendStatus(String sendStatus) {
		this.sendStatus = sendStatus;
	}

	public String getTaskUrl() {
		return taskUrl;
	}

	public void setTaskUrl(String taskUrl) {
		this.taskUrl = taskUrl;
	}

	public String getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getTaskTitle() {
		return taskTitle;
	}

	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "message [messageId=" + messageId + ", text=" + text
				+ ", avatarPath=" + avatarPath + ", filePath=" + filePath
				+ ", thumbPath=" + thumbPath + ", messageType=" + messageType
				+ ", nativePath=" + nativePath + ", conversationType="
				+ conversationType + ", objectName=" + objectName
				+ ", sendUserId=" + sendUserId + ", messageDirection="
				+ messageDirection + ", receivedId=" + receivedId
				+ ", sendTime=" + sendTime + ", receivedTime=" + receivedTime
				+ ", sendStatus=" + sendStatus + ", taskUrl=" + taskUrl
				+ ", taskStatus=" + taskStatus + ", taskTitle=" + taskTitle
				+ ", remark=" + remark + "]";
	}
}

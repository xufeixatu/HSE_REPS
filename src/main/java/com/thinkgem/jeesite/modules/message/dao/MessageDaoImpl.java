package com.thinkgem.jeesite.modules.message.dao;

import java.util.List;

import com.thinkgem.jeesite.modules.message.db.BaseDAO;
import com.thinkgem.jeesite.modules.message.model.Message;


public class MessageDaoImpl extends BaseDAO<Message> implements MessageDao{

	@Override
	public List<Message> getAllMessage() {
		String sql="select * from msg_message";
		return getForList(Message.class,sql);
	}

	@Override
	public boolean insertMessage(Message message) {
		String sql="INSERT INTO msg_message (messageId,text,avatarPath,filePath,thumbPath,"
				+ "messageType,nativePath,conversationType,objectName,sendUserId,"
				+ "messageDirection,receivedId,sendTime,receivedTime,sendStatus,"
				+ "taskUrl,taskStatus,taskTitle,remark) VALUES" 
				+"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		 insert(sql,message.getMessageId(),message.getText(),
				message.getAvatarPath(),
				message.getFilePath(),message.getThumbPath(),
				message.getMessageType(),
				message.getNativePath(),message.getConversationType(),
				message.getObjectName(),message.getSendUserId(),message.getMessageDirection(),
				message.getReceivedId(),message.getSendTime(),message.getReceivedTime(),
				message.getSendStatus(),message.getTaskUrl(),message.getTaskStatus(),
				message.getTaskTitle(),message.getRemark());
		 return true;
	}

	@Override
	public List<Message> getMessageByReceivedId(String receivedId) {
		String sql ="select * from msg_message where receivedId=?";
		return getForList(Message.class,sql,receivedId);
	}
	
}

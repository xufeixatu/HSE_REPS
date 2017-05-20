package com.thinkgem.jeesite.modules.message.dao;

import java.util.List;

import com.thinkgem.jeesite.modules.message.model.Message;


public interface MessageDao {
  public List<Message> getAllMessage();
  //receivedId
  public List<Message> getMessageByReceivedId(String receivedId);
  //
  public abstract boolean insertMessage(Message message);
}

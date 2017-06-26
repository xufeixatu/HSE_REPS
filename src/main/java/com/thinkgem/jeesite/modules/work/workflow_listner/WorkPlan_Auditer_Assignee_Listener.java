package com.thinkgem.jeesite.modules.work.workflow_listner;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;

import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

public class WorkPlan_Auditer_Assignee_Listener implements TaskListener {

	@Override
	public void notify(DelegateTask task) {
		String eventName = task.getEventName();
		if(eventName.endsWith("assignment")){
			System.out.println(task.getAssignee());
		}
	}

}

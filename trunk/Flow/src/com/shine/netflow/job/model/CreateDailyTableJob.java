package com.shine.netflow.job.model;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Trigger;
import org.quartz.TriggerUtils;

import com.shine.framework.JobUtil.model.QuartzJob;
import com.shine.netflow.job.dao.CreateDailyTableDao;

/**
 * 每天定时生成数据表的计划任务
 */
public class CreateDailyTableJob implements QuartzJob {
	private static final String TRIGGER_NAME = "DBCreateTable";
	private static final int TRIGGER_HOUR = 0;
	private static final int TRIGGER_MINUTE = 1;

	private CreateDailyTableDao dao = new CreateDailyTableDao();

	public CreateDailyTableJob() {
	}

	@Override
	public Trigger createTrigger() {
		Trigger trigger = TriggerUtils.makeDailyTrigger(TRIGGER_HOUR,
				TRIGGER_MINUTE);
		trigger.setName(TRIGGER_NAME);
		return trigger;
	}

	@Override
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		// TODO 记录日志
		// 开始任务调度
		System.out.println("每天任务调度...");
		this.createTable();
	}

	/**
	 * 创建表
	 */
	private void createTable() {
		this.dao.createTable();
	}
}
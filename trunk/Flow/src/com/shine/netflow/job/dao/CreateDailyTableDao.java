package com.shine.netflow.job.dao;

import java.util.ArrayList;
import java.util.List;

import com.shine.DBUtil.DBUtil;
import com.shine.framework.utils.TableUtil;
import com.shine.netflow.utils.NetflowHelper;

/**
 * 计划任务数据库存储适配器,专门辅助计划任务操作数据库
 */
public class CreateDailyTableDao extends GenericDao {
	public CreateDailyTableDao() {
	}

	/**
	 * 创建今天和明天的数据表
	 */
	public void createTable() {
		DBUtil.getInstance().executeBatchUpdate(JNDI, this.createSqls());
	}

	private List<String> createSqls() {
		List<String> sqls = new ArrayList<String>();
		sqls.add(NetflowHelper.getHelper().createTableSql(
				TableUtil.getTodayTable()));
		sqls.add(NetflowHelper.getHelper().createTableSql(
				TableUtil.getTomorrowTable()));
		return sqls;
	}
}
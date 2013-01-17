package com.shine.framework.dao.util;

import java.io.Serializable;

/**
 * 查询SQL 包括预处理参数/值
 * @author JiangKunpeng	2011.05.17
 * @version 2012.12.25
 */
public class QuerySQL implements Serializable{

	private static final long serialVersionUID = 5961350746369769817L;
	
	private String sql;
	private String[] params;
	private Object[] values;
	private boolean isHql = true;	//是否是hql语句，默认为是
	
	public QuerySQL(){
	}
	
	public QuerySQL(String sql){
		this.sql = sql;
	}
	
	public String getSql() {
		return sql;
	}
	public QuerySQL setSql(String sql) {
		this.sql = sql;
		return this;
	}
	public String[] getParams() {
		return params;
	}
	public QuerySQL setParams(String[] params) {
		this.params = params;
		return this;
	}
	public Object[] getValues() {
		return values;
	}
	public QuerySQL setValues(Object[] values) {
		this.values = values;
		return this;
	}
	public boolean isHql() {
		return isHql;
	}
	public QuerySQL setHql(boolean isHql) {
		this.isHql = isHql;
		return this;
	}
}
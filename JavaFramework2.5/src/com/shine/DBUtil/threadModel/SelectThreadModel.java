package com.shine.DBUtil.threadModel;

import com.shine.DBUtil.DBUtil;
import com.shine.DBUtil.model.DBModel;
import com.shine.framework.ThreadPoolUtil.model.ThreadModel;
import com.shine.framework.core.util.ReflectionUtil;

/**
 * 数据异步查询线程model
 * 
 * @author viruscodecn@gmal.com
 * 
 */
public class SelectThreadModel extends ThreadModel {
	protected String methodName;
	protected Object object;

	public SelectThreadModel() {
		this.setType("dbSelect");
		this.setTimeOut(1000);
	}

	public SelectThreadModel(Object object, String methodName) {
		this.object = object;
		this.methodName = methodName;
		this.setType("dbSelect");
		this.setTimeOut(1000);
	}

	@Override
	public void excute(Object... args) {
		try {
			if (args != null && args.length != 0) {
				DBModel dbModel = null;
				if ((Boolean) args[4]) {
					dbModel = DBUtil.getInstance().executeCacheQuery(
							(String) args[0], (String) args[1]);
				} else {
					dbModel = DBUtil.getInstance().executeQuery(
							(String) args[0], (String) args[1]);
				}

				this.object = args[2];
				this.methodName = (String) args[3];

				ReflectionUtil.invokeMethod(this.object, this.methodName,
						dbModel);
				dbModel = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}

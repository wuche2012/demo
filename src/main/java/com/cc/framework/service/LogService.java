/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.cc.framework.service;

import com.cc.framework.model.SysLog;


/**
 * Service - 日志
 * 
 * @version 3.0
 */
public interface LogService extends IService<SysLog> {

	/**
	 * 清空日志
	 */
	void clear();

}
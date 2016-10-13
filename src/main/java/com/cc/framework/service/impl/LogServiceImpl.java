package com.cc.framework.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cc.framework.model.SysLog;
import com.cc.framework.service.LogService;

@Service("logService")
public class LogServiceImpl extends BaseService<SysLog> implements LogService{

	@Override
	public void clear() {
		List<SysLog> list = this.findAll();
		for(SysLog log:list){
			this.delete(log);
		}
	}

}

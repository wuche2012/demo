/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.cc.framework.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;



import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tk.mybatis.mapper.entity.Example;

import com.cc.framework.dao.SysAdminRoleMapper;
import com.cc.framework.dao.SysRoleAuthorityMapper;
import com.cc.framework.model.SysAdmin;
import com.cc.framework.model.SysAdminRole;
import com.cc.framework.model.SysRole;
import com.cc.framework.model.SysRoleAuthority;
import com.cc.framework.security.Principal;
import com.cc.framework.service.SysAdminService;

/**
 * Service - 管理员
 * 
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("sysAdminService")
public class SysAdminServiceImpl extends BaseService<SysAdmin> implements SysAdminService {

	@Autowired
	private SysAdminRoleMapper sysAdminRoleMapper;
	
	@Autowired
	private SysRoleAuthorityMapper sysRoleAuthorityMapper;
	
	@Transactional(readOnly = true)
	public boolean usernameExists(String username) {
		Example e = new Example(SysAdmin.class);
		e.createCriteria().andEqualTo("username", username);
		List<SysAdmin> list = this.selectByExample(e);
		if(list != null && list.size() >0)return true;
		return false;
	}

	@Transactional(readOnly = true)
	public SysAdmin findByUsername(String username) {
		Example e = new Example(SysAdmin.class);
		e.createCriteria().andEqualTo("username", username);
		List<SysAdmin> list = this.selectByExample(e);
		if(list != null && list.size() >0)return list.get(0);
		return null;
	}

	@Transactional(readOnly = true)
	public String getCurrentUsername() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			Principal principal = (Principal) subject.getPrincipal();
			if (principal != null) {
				return principal.getUsername();
			}
		}
		return null;
	}
	
	/*@Transactional(readOnly = true)
	public List<String> findAuthorities(Long id) {
		List<String> authorities = new ArrayList<String>();
		Admin admin = adminDao.find(id);
		if (admin != null) {
			for (Role role : admin.getRoles()) {
				authorities.addAll(role.getAuthorities());
			}
		}
		return authorities;
	}*/

	@Transactional(readOnly = true)
	public boolean isAuthenticated() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			return subject.isAuthenticated();
		}
		return false;
	}

	@Override
	public boolean saveUserAndRole(SysAdmin admin, Set<SysRole> roles) {
		this.save(admin);
		SysAdminRole adminrole = null;
		for(SysRole role:roles){
			adminrole = new SysAdminRole();
			adminrole.setAdmins(admin.getId());
			adminrole.setRoles(role.getId());
			sysAdminRoleMapper.insert(adminrole);
		}
		return true;
	}

	@Override
	public SysAdmin find(Long id) {
		SysAdmin admin = this.selectByKey(id);
		if(admin != null){
			Example e = new Example(SysAdminRole.class);
			e.createCriteria().andEqualTo("admins", id);
			List<SysAdminRole> roles = sysAdminRoleMapper.selectByExample(e);
			admin.setRoles(roles);
			return admin;
		}
		return null;
	}

	@Override
	public void update(SysAdmin admin, Set<SysRole> roles) {
		this.updateNotNull(admin);
		Example e = new Example(SysAdminRole.class);
		e.createCriteria().andEqualTo("admins", admin.getId());
		List<SysAdminRole> adminroles = sysAdminRoleMapper.selectByExample(e);
		for(SysAdminRole temp:adminroles){
			sysAdminRoleMapper.delete(temp);
		}
		SysAdminRole adminrole = null;
		for(SysRole role:roles){
			adminrole = new SysAdminRole();
			adminrole.setAdmins(admin.getId());
			adminrole.setRoles(role.getId());
			sysAdminRoleMapper.insert(adminrole);
		}
	}

	@Override
	public void batchDelAdmins(Long[] ids) {
		for(Long id:ids){
			Example e = new Example(SysAdminRole.class);
			e.createCriteria().andEqualTo("admins",id);
			List<SysAdminRole> list = sysAdminRoleMapper.selectByExample(e);
			for(SysAdminRole role:list){
				sysAdminRoleMapper.delete(role);
			}
		}
		this.batchDel(ids);
	}

	@Override
	public List<String> findAuthorities(Long id) {
		Example e = new Example(SysAdminRole.class);
		e.createCriteria().andEqualTo("admins", id);
		List<SysAdminRole> adminroles = sysAdminRoleMapper.selectByExample(e);
		List<Long> roleIds = new ArrayList<Long>();
		for(SysAdminRole adminrole:adminroles){
			roleIds.add(adminrole.getRoles());
		}
		e = new Example(SysRoleAuthority.class);
		e.createCriteria().andIn("role", roleIds);
		List<SysRoleAuthority> authories = sysRoleAuthorityMapper.selectByExample(e);
		List<String> result = new ArrayList<String>();
		for(SysRoleAuthority auth:authories){
			result.add(auth.getAuthorities());
		}
		return result;
	}

	/*@Transactional(readOnly = true)
	public SysAdmin getCurrent() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			Principal principal = (Principal) subject.getPrincipal();
			if (principal != null) {
				return adminDao.find(principal.getId());
			}
		}
		return null;
	}*/

	/*@Transactional(readOnly = true)
	public String getCurrentUsername() {
		Subject subject = SecurityUtils.getSubject();
		if (subject != null) {
			Principal principal = (Principal) subject.getPrincipal();
			if (principal != null) {
				return principal.getUsername();
			}
		}
		return null;
	}*/

/*	@Override
	@Transactional
	@CacheEvict(value = "authorization", allEntries = true)
	public int save(SysAdmin admin) {
		this.save(admin);
	}
*/
	/*@Override
	@Transactional
	@CacheEvict(value = "authorization", allEntries = true)
	public SysAdmin update(SysAdmin admin) {
		int i = this.updateNotNull(admin);
		return this.selectByKey(admin.getId());
	}*/

	/*@Override
	@Transactional
	@CacheEvict(value = "authorization", allEntries = true)
	public Admin update(Admin admin, String... ignoreProperties) {
		return super.update(admin, ignoreProperties);
	}*/

	/*@Override
	@Transactional
	@CacheEvict(value = "authorization", allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}*/

	/*@Override
	@Transactional
	@CacheEvict(value = "authorization", allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = "authorization", allEntries = true)
	public void delete(SysAdmin admin) {
		super.delete(admin);
	}*/

	/*@Override
	public SysAdmin find(Long id) {
		return this.selectByKey(id);
	}*/

}
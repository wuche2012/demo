<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>用户管理</title>
<meta name="keywords" content=" ">
<meta name="description" content="">
<link rel="shortcut icon" href="favicon.ico">
<link
	href="${pageContext.request.contextPath}/static/css/bootstrap.min14ed.css?v=3.3.6"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/static/css/font-awesome.min93e3.css?v=4.4.0"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/static/css/plugins/bootstrap-table/bootstrap-table.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/static/css/animate.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/static/css/style.min862f.css?v=4.1.0"
	rel="stylesheet">
 <link href="${pageContext.request.contextPath}/static/css/plugins/iCheck/custom.css" rel="stylesheet">	
	
</head>
<body class="fixed-sidebar full-height-layout gray-bg">
	<div class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title navy-bg">
						<h5>新增管理员</h5>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal" id="userForm" method="post" action="save">
						<div class="hr-line-dashed"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">部门:</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" name="department" id="department"
										placeholder="请输入部门"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">姓名:</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" name="name" id="name"
										placeholder="请输入姓名"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">*用户名：</label>
								<div class="col-sm-4">
									<input type="text" placeholder="请输入用户名" name="username" id="username" class="form-control">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">*密码:</label>
								<div class="col-sm-4">
									<input type="password" class="form-control" name="password" id="password"
										placeholder="请输入密码"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">*确认密码:</label>
								<div class="col-sm-4">
									<input type="password" class="form-control" name="confirm_password" id="confirm_password"
										placeholder="请输入密码"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">*E-mail:</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" name="email" id="email"
										placeholder="请输入E-mail"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="form-group">
                                <label class="col-sm-2 control-label">角色</label>
                                <div class="col-sm-10">
                                	<c:forEach var="role" items="${roles}">   
                                    	<label class="checkbox-inline i-checks">
                                        <input type="checkbox" name="roleIds" id="roleIds" value="${role.id}" id="inlineCheckbox1">${role.name }</label>
                                     </c:forEach>
                                </div>
                            </div>
							<div class="form-group">
								<label class="col-sm-2 control-label">是否启用:</label>
								 <div class="col-sm-4">
                                    <div class="checkbox i-checks">
                                        <label>
                                            <input type="checkbox" id="isEnabled" value="true" name="isEnabled"><i></i></label>
                                    </div>
                                  </div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
                                <div class="col-sm-4 col-sm-offset-2">
                                    <button class="btn btn-primary" type="submit">新增</button>
                                    <a class="btn btn-white" href="${pageContext.request.contextPath}/admin/admin/index">返回</a>
                                </div>
                            </div>
							<!-- <button class="btn btn-primary" type="submit">查询</button> -->
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<!-- End Panel Other -->
	</div>
	<script
		src="${pageContext.request.contextPath}/static/js/jquery.min.js?v=2.1.4"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js?v=3.3.6"></script>
	<%-- <script
		src="${pageContext.request.contextPath}/static/js/content.min.js?v=1.0.0"></script> --%>
	<script
		src="${pageContext.request.contextPath}/static/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/ajax.js"></script>
	 
	<script src="${pageContext.request.contextPath}/static/js/plugins/iCheck/icheck.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/plugins/validate/jquery.validate.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})});
        
        
        $.validator.setDefaults({
            highlight: function(e) {
                $(e).closest(".form-group").removeClass("has-success").addClass("has-error")
            },
            success: function(e) {
                e.closest(".form-group").removeClass("has-error").addClass("has-success")
            },
            errorElement: "span",
            errorPlacement: function(e, r) {
                e.appendTo(r.is(":radio") || r.is(":checkbox") ? r.parent().parent().parent() : r.parent())
            },
            errorClass: "help-block m-b-none",
            validClass: "help-block m-b-none"
        }),
        $().ready(function() {
            var e = "<i class='fa fa-times-circle'></i> ";
            $("#userForm").validate({
                rules: {
                    username: {
                    	required: true,
        				minlength: 5,
        				maxlength: 20,
        				remote: {
        					url: "check_username",
        					cache: false
        				}
                    },
                    password: {
                    	required: true,
        				minlength: 4,
        				maxlength: 20
                    },
                    confirm_password: {
                        required: !0,
                        minlength: 6,
                        equalTo: "#password"
                    },
                    email: {
                        required: !0,
                        email: !0
                    },
                    roleIds: "required"
                },
                messages: {
                    username: {
                        required: e + "请输入您的用户名",
                        minlength: e + "用户名必须五个字符以上",
                        remote: "用户名已经存在",
                        maxlength:"用户名长度过长，不能超过20个字符"
                    },
                    password: {
                        required: e + "请输入您的密码",
                        minlength: e + "密码必须4个字符以上"
                    },
                    confirm_password: {
                        required: e + "请再次输入密码",
                        minlength: e + "密码必须4个字符以上",
                        equalTo: e + "两次输入的密码不一致"
                    },
                    email: e + "请输入您的E-mail",
                    roleIds: {
                        required: e + "请选择用户角色",
                        element: "#agree-error"
                    }
                }
            }),
            $("#username").focus(function() {
                var e = $("#firstname").val(),
                r = $("#lastname").val();
                e && r && !this.value && (this.value = e + "." + r)
            })
        });
    </script>
</body>
</html>
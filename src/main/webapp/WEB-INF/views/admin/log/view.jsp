<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>日志详情</title>
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
						<h5>日志详情</h5>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal" id="userForm" method="post" action="update">
						<div class="hr-line-dashed"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">操作:</label>
								<div class="col-sm-4">
									<input type="hidden" name="id" id="id" value="${log.id}">
									<input type="text" class="form-control" disabled="disabled" name="department" value="${log.operation}" id="department"
										placeholder="请输入部门"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">操作员:</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" name="name" disabled="disabled"  value="${log.operator}" id="name"
										placeholder="请输入姓名"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<label class="col-sm-2 control-label">内容：</label>
								<div class="col-sm-4">
									<input type="text" placeholder="-" disabled="disabled" name="username" disabled="disabled" value="${log.content}" id="username" class="form-control">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">请求参数：</label>
								<div class="col-sm-4">
									<textarea rows="10" readonly="readonly" class="form-control" cols="">${log.parameter}</textarea><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">IP:</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" disabled="disabled" name="confirm_password" id="confirm_password" value="${log.ip }"
										placeholder="-"><span class="help-block m-b-none"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">创建日期:</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" disabled="disabled" value="${log.createDate}" name="email" id="email"
										placeholder="-"><span class="help-block m-b-none"></span>
								</div>
							</div>
							 
							<div class="hr-line-dashed"></div>
							<div class="form-group">
                                <div class="col-sm-4 col-sm-offset-2">
                                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/log/index">返回</a>
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
    </script>
</body>
</html>
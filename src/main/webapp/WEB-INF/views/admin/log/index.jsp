<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>系统日志管理</title>
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
		<link href="${pageContext.request.contextPath}/static/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
</head>
<body class="fixed-sidebar full-height-layout gray-bg">
	<div class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title navy-bg">
						<h5>
							 日志查询
						</h5>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-md-12">
								<form role="form" class="form-inline">
									<div class="form-group">
										<label for="exampleInputEmail2" class="control-label">操作名称:</label>
										<input type="text" class="form-control" name="operation" id="operation">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail2" class="control-label">操作人:</label>
										<input type="text" class="form-control" name="operator" id="operator">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail2" class="control-label">IP:</label>
										<input type="text" class="form-control" name="ip" id="ip">
									</div>
									<button class="btn btn-primary" id="search" type="button">查询</button>
								</form>
							</div>
						</div>
					</div>
			</div>
		</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title navy-bg">
						<h5>
							操作日志列表
						</h5>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
						<div class="btn-group hidden-xs" id="toolbar" role="group">
							<button type="button" id="add"
								class="btn btn-outline btn-default">
								<i class="glyphicon glyphicon-plus" aria-hidden="true"></i>
							</button>
							<button type="button" id="refresh"
								class="btn btn-outline btn-default">
								<i class="glyphicon glyphicon-refresh" aria-hidden="true"></i>
							</button>
							<button type="button" id="remove"
								class="btn btn-outline btn-default">
								<i class="glyphicon glyphicon-trash" aria-hidden="true"></i>
							</button>
						</div>
						<!-- data-response-handler="responseHandler" -->
						<table id="listTable" data-click-to-select="true" />

						</table>
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
	<script src="${pageContext.request.contextPath}/static/js/plugins/sweetalert/sweetalert.min.js"></script>
	<%-- <script
		src="${pageContext.request.contextPath}/static/js/demo/bootstrap-table-demo.min.js"></script> --%>
	<script type="text/javascript"
		src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>

	<script type="text/javascript">
		function responseHandler(data) {
			var pageData = data.rows;
			for (var i = 0; i < pageData.length; i++) {
				  if (pageData[i].isEnabled) {
				     pageData[i].isEnabled = "正常";
				 } else {
				     pageData[i].isEnabled = "无效";
				 }
			//	pageData[i].icon = "<i class='glyphicon  glyphicon-edit></i>";
				pageData[i].ops = '';
				pageData[i].ops+="<a class='btn btn-success btn-sm' id='cancel' type='button' href='${pageContext.request.contextPath}/admin/log/view?id="+pageData[i].id+"' >查看</a>";
			}
			return {
				"total" : data.total,
				"rows" : pageData
			}
		}
		
		var success_fn =  function successfn(e){
			if(e.code==0){
				swal("删除成功！", e.data, "success");
			}else{
				swal("删除失败！", e.data, "fail");
			}
			$('#listTable').bootstrapTable('refresh');
		}
		
		var error_fn = function(e){
			if(e.code==0){
				swal("删除成功！", e.data, "success");
			}else{
				swal("删除失败！", e.data, "fail");
			}
			$('#listTable').bootstrapTable('refresh');
		};
		
		$(function() {
			//1.初始化Table
			var oTable = new TableInit();
			oTable.Init();
			//2.初始化Button的点击事件
			var oButtonInit = new ButtonInit();
			oButtonInit.Init();
			$('#remove').click(
					function() {
						var ids = $.map($('#listTable').bootstrapTable(
								'getSelections'), function(row) {
							return row.id;
						});
						$('#remove').prop('disable', true);
						swal({
							title : "您确定要删除这些信息吗",
							text : "删除后将无法恢复，请谨慎操作！",
							type : "warning",
							showCancelButton : true,
							confirmButtonColor : "#DD6B55",
							confirmButtonText : "删除",
							closeOnConfirm : false
						}, function() {
							$.ax(
									'${pageContext.request.contextPath}/admin/log/del.json?ids='
											+ ids, null, false, 'POST', 'json',
									success_fn, error_fn);
						});
						$('#remove').prop('disable', false);
			});
		
			$('#add').click(function(){
				return false;
			});
			$('#refresh').click(function(){
				$('#listTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/admin/log/list.json'});  
			});
			$('#search').click(function(){
				$('#listTable').bootstrapTable('refresh', {url: '${pageContext.request.contextPath}/admin/log/list.json'});  
			});
		});
		
		
		
		var TableInit = function() {
			var oTableInit = new Object();
			//初始化Table
			oTableInit.Init = function() {
				$('#listTable')
						.bootstrapTable(
								{
									url : '${pageContext.request.contextPath}/admin/log/list.json', //请求后台的URL（*）
									method : 'get', //请求方式（*）
									toolbar : '#toolbar', //工具按钮用哪个容器
									striped : true, //是否显示行间隔色
									cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
									pagination : true, //是否显示分页（*）
									sortable : false, //是否启用排序
									sortOrder : "asc", //排序方式
									responseHandler:"responseHandler",
									queryParams : oTableInit.queryParams,//传递参数（*）
									sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
									pageNumber : 1, //初始化加载第一页，默认第一页
									pageSize : 10, //每页的记录行数（*）
									pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
									search : false, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
									strictSearch : true,
									showColumns : true, //是否显示所有的列
									showRefresh : false, //是否显示刷新按钮
									minimumCountColumns : 2, //最少允许的列数
									clickToSelect : true, //是否启用点击选中行
									height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
									uniqueId : "id", //每一行的唯一标识，一般为主键列
									showToggle : false, //是否显示详细视图和列表视图的切换按钮
									cardView : false, //是否显示详细视图
									detailView : false, //是否显示父子表
									columns : [ {
										checkbox : true
									}, {
										field : 'ip',
										title : 'IP地址'
									}, {
										field : 'operation',
										title : '操作名称'
									}, {
										field : 'operator',
										title : '操作人'
									}, {
										field : 'content',
										title : '内容'
									},{
										field : 'createDate',
										title : '创建日期'
									}, {
										field : 'ops',
										title : '操作'
									} ]
								});
			};

			//得到查询的参数
			oTableInit.queryParams = function(params) {
				var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
					limit : params.limit, //页面大小
					offset : params.offset, //页码
					operator:$("#operator").val(),
					operation:$("#operation").val(),
					ip:$("#ip").val()
				};
				return temp;
			};
			return oTableInit;
		};

		var ButtonInit = function() {
			var oInit = new Object();
			var postdata = {};

			oInit.Init = function() {
				//初始化页面上面的按钮事件
			};

			return oInit;
		};
	</script>
</body>
</html>
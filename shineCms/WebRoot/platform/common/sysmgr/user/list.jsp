<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/path.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script type="text/javascript" src="${path}r/operamasks-ui/js/jquery.min.js"></script>
<script type="text/javascript" src="${path}r/operamasks-ui/js/operamasks-ui.min.js"></script>
<link rel="stylesheet" href="${path}r/operamasks-ui/css/default/om-default.css">
<style type="text/css">
.toolbar {
    background: url("${path}r/blue/image/btn/toolbar_bg.jpg") repeat-x scroll 0 0 #99B5DD;
    border: 1px solid #808FB8;
    height: 24px;
    line-height: 24px;
    padding-left: 10px;
    padding-top: 1px;
    padding-bottom: 2px;
}
.mar {
    margin-top: 10px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	var dialog = $("#dialog-form").omDialog({
        width: 400,
        autoOpen : false,
        modal : true,
        resizable : false,
        buttons : {
            "提交" : function(){
          submitDialog();
          return false; //阻止form的默认提交动作
      	},
            "取消" : function() {
                $("#dialog-form").omDialog("close");//关闭dialog
            }
        }
    });
    //显示dialog并初始化里面的输入框的数据
    var showDialog = function(title,rowData){
        validator.resetForm();
        rowData = rowData || {};
        $("input[name='e.username']",dialog).val(rowData.username);
        $("input[name='e.name']",dialog).val(rowData.name);
        dialog.omDialog("option", "title", title);
        dialog.omDialog("open");//显示dialog
    };
    //dialog中点提交按钮时将数据提交到后台并执行相应的add或modify操作
    var submitDialog = function(){
        if (validator.form()) {
	        var submitData={
	            'e.id':$("input[name='e.id']",dialog).val(),
	            'e.username':$("input[name='e.username']",dialog).val(),
	            'e.password':$("input[name='e.password']",dialog).val(),
	            'e.name':$("input[name='e.name']",dialog).val()
	        };
	        $.post('${path}sysmgr/user_saveAjax.do',submitData,function(){
	            if(isAdd){
	                $('#grid').omGrid('reload',1);//如果是添加则滚动到第一页并刷新
	                $.omMessageTip.show({title: "操作成功", content: "添加数据成功", timeout: 1500});
	            }else{
	                $('#grid').omGrid('reload');//如果是修改则刷新当前页
	                $.omMessageTip.show({title: "操作成功", content: "修改数据成功", timeout: 1500});
	            }
	            $("#dialog-form").omDialog("close"); //关闭dialog
	        });
        }
    };
    // 对表单进行校验
    var validator = $('#userForm').validate({
        rules : {
            'e.username' : {
    			required : true,
    			maxlength : 5
    		}, 
            'e.password' : {required : true},
            'e.name' : {required : true} 
        }, 
        messages : {
            'e.username' : {
        		required : "用户名不能为空",
        		maxlength : "用户名长度不能超过5"
        	},
            'e.password' : {required : "密码不能为空"},
            'e.name' : {required : "姓名不能为空"}
        }
    });
    var isAdd = true; //弹出窗口中是添加操作还是修改操作？
	$('#btn_add').omButton({
		icons : {left : '${path}r/blue/image/btn/add.gif'},
		onClick : function(){
			isAdd = true;
			showDialog('新增');//显示dialog
		}
	});
	$('#btn_modify').omButton({
		icons : {left : '${path}r/blue/image/btn/modify.gif'}
	});
	$('#btn_delete').omButton({
		icons : {left : '${path}r/blue/image/btn/delete.gif'},
		onClick : function(){
			var selections=$('#grid').omGrid('getSelections',true);
            var len = selections.length;
            if (len == 0) {
            	alert('请至少选择一行记录');
                return false;
            }
            if(confirm("确认删除所选的"+len+"条记录？")){
	            //将选择的记录的id传递到后台去并执行delete操作
	            var ids = '';
	            for(var i=0;i<len;i++){
	            	ids += selections[i].userId + ',';
	            }
	            ids = ids.substr(0,ids.length-1);
	            $.post('${path}sysmgr/user_delete.do','id='+ids,function(){
	                $('#grid').omGrid('reload');//刷新当前页数据
	                $.omMessageTip.show({title: "操作成功", content: "删除数据成功", timeout: 1500});
	            });
            }
		}
	});
	$('#btn_refresh').omButton({
		icons : {left : '${path}r/blue/image/btn/delete.gif'},
		onClick : function(){
			$('#grid').reload();
		}
	});
    $('#grid').omGrid({
        dataSource : '${path}sysmgr/user_listJSON.do',
        singleSelect : false,
        colModel : [ {header : 'ID', name : 'userId', width : 100, align : 'center'}, 
                     {header : '用户名', name : 'username', width : 120, align : 'left'}, 
                     {header : '姓名', name : 'name', align : 'left', width : 'autoExpand'} ]
    });
});
</script>
</head>

<body>
<div class="toolbar mar">
     <a href="javascript:void(0);" id="btn_add">添加</a>
     <a href="javascript:void(0);" id="btn_modify">修改</a>
     <a href="javascript:void(0);" id="btn_delete">删除</a>
     <a href="javascript:void(0);" id="btn_refresh">刷新</a>
</div>
<table id="grid"></table>
<div id="dialog-form">
    <form id="userForm">
    <input name="e.id" style="display: none"/>
    <table>
        <tr>
            <td>用户名：</td>
            <td><input name="e.username" /></td>
        </tr>
        <tr>
            <td>密码：</td>
            <td><input name="e.password" /></td>
        </tr>
        <tr>
            <td>姓名：</td>
            <td><input name="e.name" /></td>
        </tr>
    </table>
	</form>
</div>
</body>
</html>
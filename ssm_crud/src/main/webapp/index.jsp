<%--
  Created by IntelliJ IDEA.
  User: 86150
  Date: 2021/8/25
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 添加模态框modal -->
<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="W" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--编辑按钮的模态框--%>
<div class="modal fade" id="emp_update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">编辑员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="W" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update_emp_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_modal_btn">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                    <th><input type="checkbox" id="checkbox-all"></th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody >

                </tbody>
            </table>
        </div>
    </div>
    <%--分页--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;
    $(function(){
        //渲染第一页面的数据
        to_page(1);
    })
    function to_page(pageNum){
        $("#checkbox-all").prop("checked",false);
        $.ajax({
            url:"${APP_PATH}/getEmployees",
            data:"pageNum="+pageNum,
            type:"GET",
            success:function (result){
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }
    function build_emps_table(result) {
        totalRecord = result.extend.pageInfo.total;
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        console.log(emps);
        $.each(emps,function (index,item) {
            var checkboxTd = $("<td><input type='checkbox' class='checkbox-item'></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="W"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").
            append("<span></span>").addClass("glyphicon glyphicon-pencil edit_btn").append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash delete_btn").append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkboxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    function build_page_info(result) {
        currentPage = result.extend.pageInfo.pageNum;
        $("#page_info_area").empty();
        $("#page_info_area").append("当前是第"+result.extend.pageInfo.pageNum+"页，共"+result.extend.pageInfo.pages+
            "页，共"+result.extend.pageInfo.total+"条记录");
    }
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            })
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //重置表单内容和样式
    function reset_form(ele){
        //重置模态框内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //点击添加模态框
    $('#emp_add_modal_btn').click(function () {
        //清楚模态框中的样式和内容
        reset_form("#emp_add_modal form");
        //获取部门信息
        getDepts("#emp_add_modal select");
        //弹出模态框
        $("#emp_add_modal").modal({
            backdrop:"static"
        });
    });
    //获取部门名称
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        });
    }
    //展示验证消息
    function show_validate_msg(ele,status,msg){
        //先清楚状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //添加员工模态框保存功能
    $("#save_emp_btn").click(function () {
        //对表单进行验证
        if($(this).attr("name_va")=="fail"||$(this).attr("email_va")=="fail")
            return false;
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#emp_add_modal form").serialize(),
            success:function (result) {
                //先判断后端校验jsr303是否成功
                if(result.code==100){
                    //关闭模态框
                    $("#emp_add_modal").modal('hide');
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                }else{
                    if(undefined!=result.extend.errorFields.empName)
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    if(undefined!=result.extend.errorFields.email)
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                }
            }
        });
    });
    //用户名输入框改变的事件
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkUserName",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                console.log(result);
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#save_emp_btn").attr("name_va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.check_res);
                    $("#save_emp_btn").attr("name_va","fail");
                }
            }
        });
    });
    //email输入框的校验
    $("#email_add_input").change(function () {
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //若不匹配
            show_validate_msg("#email_add_input","error","格式不正确");
            $("#save_emp_btn").attr("email_va","fail");
        }else{
            show_validate_msg("#email_add_input","success","");
            $("#save_emp_btn").attr("email_va","success");
        }
    });
    //编辑按钮点击事件，由于该编辑按钮在发送ajax渲染数据后才出现，要用on函数
    $(document).on("click",".edit_btn",function () {
        getDepts("#emp_update_modal select");
        var id = $(this).attr("edit-id");
        getEmp(id);
        //给更新按钮添加edit_id属性
        $("#update_emp_btn").attr("edit_id",id);
        //弹出模态框
        $("#emp_update_modal").modal({
            backdrop:"static"
        });
    });
    //通过id获取员工信息并显示出来
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                console.log(empData);
                $("#emp_update_modal input[name=gender]").val([empData.gender]);
                $("#emp_update_modal select").val([empData.dId]);
            }
        });
    }
    //更新按钮的点击事件
    $("#update_emp_btn").click(function () {
        //先对邮箱进行验证
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //若不匹配
            show_validate_msg("#email_add_input","error","格式不正确");
            $("#save_emp_btn").attr("email_va","fail");
        }else{
            show_validate_msg("#email_add_input","success","");
            $("#save_emp_btn").attr("email_va","success");
        }
        $.ajax({
           url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
           type:"PUT",
           data:$("#emp_update_modal form").serialize(),
           success:function (result) {
               //关闭模态框
               $("#emp_update_modal").modal("hide");
               //跳回原页面
               to_page(currentPage);
           }
        });
    });
    //删除按钮点击事件
    $(document).on("click",".delete_btn",function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认是否删除[ "+empName+" ]?")){
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
    //全选/全不选功能
    $("#checkbox-all").click(function () {
        $(".checkbox-item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".checkbox-item",function () {
        var flag = $(".checkbox-item:checked").length==$(".checkbox-item").length
        $("#checkbox-all").prop("checked",flag);
    });
    //批量删除
    $("#emp_del_modal_btn").click(function () {
        var empNames = "";
        var ids="";
        $.each($(".checkbox-item:checked"),function () {
            empNames+= $(this).parents("tr").find("td:eq(2)").text()+",";
            ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的 , -
        empNames = empNames.substring(0,empNames.length-1);
        ids = ids.substring(0,ids.length-1);
        if(confirm("是否确定删除[ "+empNames+" ]?")){
            $.ajax({
                url:"${APP_PATH}/emp/"+ids,
                type:"DELETE",
                success:function (result) {
                    alert("处理成功");
                    to_page(currentPage);
                }
            });
        }
    })
</script>
</body>
</html>

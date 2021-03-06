<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Martin
  Date: 2021/4/19
  Time: 12:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>

    <%--    引入jquery--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>--%>
<%--    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.7.2.min.js"></script>--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/dist/jquery.min.js"></script>

    <%--    引入bootstrap样式--%>

    <%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>--%>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>


</head>
<body>

<!-- 员工修改（Modal模态框的数据）-->
<!-- Modal -->
<div id="empUpdateModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName:</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email:</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="jerry@email.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <%--                                注意namespringmvc对提交的数据封装对象应该和javabean属性名一样--%>
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label"  >deptName:</label>
                        <div class="col-sm-4">
                            <%--                            部门提交id即可--%>
                            <select class="form-control" name="dId" >

                            </select>
                        </div>
                    </div>



                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>



<!-- 员工添加（Modal模态框的数据）-->
<!-- Modal -->
<div id="empAddModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName:</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email:</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="jerry@email.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
<%--                                注意namespringmvc对提交的数据封装对象应该和javabean属性名一样--%>
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName:</label>
                        <div class="col-sm-4">
<%--                            部门提交id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>



                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<%--搭建显示页面--%>
<div class="container">
    <%--            标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>人员统计终端</h1>
        </div>
    </div>
    <%--    按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>



            </table>
        </div>

    </div>
    <%--    显示分页信息--%>
    <div class="row">
        <%--              分页文字信息下--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--              分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>

    </div>
</div>

<script type="text/javascript">

<%--    总记录数--%>
      var totalRecord,currentPage;

    //    1.页面加载完成以后，直接发送ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    function build_emps_table(result) {
        //清空表格
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        //遍历元素，每次的回调函数
        $.each(emps,function (index,item) {
            var checkBoxId = $("<td><input type='checkbox' class='check_item'/></td>");
            var empId = $("<td></td>").append(item.empId);
            var empName = $("<td></td>").append(item.empName);
            var empGender = $("<td></td>").append(item.gender == "M" ?"男":"女");
            var email = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
            //为编辑按钮添加一个自定义属性的值表示当前id
            editBtn.attr("edit-id",item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除员工id
            deleteBtn.attr("del-id",item.empId);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxId).append(empId).append(empName).append(empGender).append(email).append(deptName).append(editBtn).append(deleteBtn)
                .appendTo("#emps_table tbody");
        });
    }
    //解析分页文字信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append(" 当前"+result.extend.pageInfo.pageNum+"页,总"+result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");

        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解析分页条,点击分页要能去到下一页...
    function build_page_nav(result) {
        $("#page_nav_area").empty();

        var ul =$("<ul></ul>").addClass("pagination");

        var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPage.addClass("disabled");
            prePage.addClass("disabled");
        }else {
            firstPage.click(function () {
                to_page(1);
            });

            prePage.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        if (result.extend.pageInfo.hasNextPage == false){
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        }else {
            nextPage.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });

            lastPage.click(function () {
                to_page(result.extend.pageInfo.pages)
            });

        }

        ul.append(firstPage).append(prePage);
        $.each(result.extend.pageInfo.navigatepageNums,function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPage).append(lastPage);

        var navEle = $("<nav></nav>").append(ul);

        $("#page_nav_area").append(navEle);
    }

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // console.log(result);
                //    1.解析并显示员工数据
                build_emps_table(result);
                //解析分页文字信息
                build_page_info(result);
                //解析分页条
                build_page_nav(result);
            }
        });
    }

    //完整重置表单
    function reset_form(ele) {
        $(ele)[0].reset();
    //    清空样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");

    }

    //点击新增按钮 弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //进行表单重置(js内没有reset方法，取出来dom对象重置)
        reset_form("#empAddModal form");
        // $("#empAddModal form")[0].reset();

        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        $("#empAddModal").modal({
           backdrop:"static",
        })
    });

    function getDepts(ele) {
        //清空下拉列表
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            // async: false,
            success:function (result) {
                // condModal select").append("")
             $.each(result.extend.depts,function () {
                 var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                 optionEle.appendTo(ele);
             });

            }
        });
    }

    function validate_add_form() {

        //校验用户名
        var empName = $("#emp_add_input").val();
        // var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,10})/;
        var regName = /(^[a-zA-Z0-9_-]{4,16})|(^[⺀-鿿]{2,10})/;
        if (!regName.test(empName)){
            // alert("用户名可以是4-16位英文或者2-5位中文");
            show_validate_msg("#emp_add_input","error","用户名可以是4-16位英文或者2-10位中文")
            return false
        }else {
            show_validate_msg("#emp_add_input","success","")

        };

        //校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)){
            // alert("邮箱信息不正确");
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_add_input","error","");
        };
        return true;
    }

    //用户保存前jquery校验
    function show_validate_msg(ele,status,msg) {
        //清除状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);

        }else if ("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#emp_add_input").change(function () {
    //    发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
           url:"${APP_PATH}/checkUser",
           data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if (result.code == 100){
                    show_validate_msg("#emp_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validate_msg("#emp_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //保存员工
    $("#emp_save_btn").click(function () {

    //    1.模态框中的数据提交给服务器保存
    //    0.先对提交的信息进行校验
        if (!validate_add_form()){
            return false;
        }

    //    --1.判断之前的用户名校验是否成功了
        if($(this).attr("ajax-va") == "error"){
            return false;
        }
    //    2.发送ajax请求保存数据
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"POST",
            data: $("#empAddModal form").serialize(),
            success:function (result) {
                // alert(result.msg);
                if (result.code == 100){
                    //    员工保存成功
                    //    1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //    2.来到最后一页，显示刚才保存的数据
                    //    发送ajax请求显示最后一页
                    //传一个很大的数，这里可以用总记录数
                    to_page(totalRecord);
                }else
                    if (result.code == 200){
                    show_validate_msg("#emp_add_input","error","用户名不可用");
                }else

                {
                //    失败信息
                //     console.log(result);
                //    有哪个字段就显示哪个字段
                    if (undefined != result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName){
                        show_validate_msg("#emp_add_input","error",result.extend.errorFields.empName);
                    }

                }

            }
        });
    });


//    1.按钮创建之前绑定click，所以绑不上
//1）、可以在创建按钮的时候绑定（代码耦合太高，不推荐）2）、绑定.live（）
//jquery新版没有live，使用on进行代替
$(document).on("click",".edit_btn",function () {
   // alert("qw");
//     1.查出员工信息，显示员工信息

//    2.查出部门信息，并显示部门列表
    getDepts("#empUpdateModal select");

    getEmp($(this).attr("edit-id"));

    $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

//    3.弹出模态框 把员工的id传递给模态框的更新按钮
    $("#empUpdateModal").modal({
        backdrop: "static"
    });
});


        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                    // $("empUpdateModal select").find("option[value='empData.dId']").attr("selected",true);
                    // console.log(empData);
                }
            });
        }

        $("#emp_update_btn").click(function () {

            //验证邮箱是否合法
            //校验邮箱
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                // alert("邮箱信息不正确");
                show_validate_msg("#email_update_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("#email_update_input","error","");
            };

            //发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"POST",
                data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                success:function (result) {
                    // alert(result.msg)
                //    关闭模态框
                    $("#empUpdateModal").modal("hide");
                //    回到页面
                    to_page(currentPage);
                }
            });
        });


        $(document).on("click",".delete_btn",function () {
            var empName =$(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del-id");
            // alert($(this).parents("tr").find("td:eq(1)").text());
            if (confirm("确认删除【"+empName+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    // data:"_method=DELETE",
                    success:function (result) {
                        alert(result.msg);
                    //    回到本页
                        to_page(currentPage);
                    }
                });
            }
        });

//    完成全选
        $("#check_all").click(function () {
        //    attr获取的checke是undefined
        //     $(this).attr("checked");
        //    attr获取自定义属性的值,
            //    prop修改和读取dom原生属性的值
            $(".check_item").prop("checked",$(this).prop("checked"));
        });


        //监听其他单选按钮 全选全不选
        $(document).on("click",".check_item",function () {
            let flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);
        });

//点击删除，全部删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var del_idstr = "";
            $.each($(".check_item:checked"),function () {
                empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            //    组装员工id字符串
                del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //取出多余的，号
            empNames=empNames.substring(0,empNames.length-1);
            del_idstr=del_idstr.substring(0,del_idstr.length-1);
            if (confirm("确认删除【"+empNames+"】吗？")){
            //    发送ajax
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                        $("#check_all").prop("checked",false);
                    }
                });
            }
        });

</script>
</body>
</html>

package com.martin.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.martin.crud.bean.Employee;
import com.martin.crud.bean.Msg;
import com.martin.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author martin cnsibo@163.con
 * @version 1.0
 * @create 2021/4/19 12:29
 *处理员工crud请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    /**
     * 单个批量二合一
     * 参数多个1-2-3
     * 单个1
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            //批量删除
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
//            组装id集合
            for (String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            //单个删除
            int i = Integer.parseInt(ids);
            employeeService.deleteEmp(i);
        }
        return Msg.success();
    }


//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    @ResponseBody
//    public Msg deleteEmpById(@PathVariable("id") Integer id){
//        employeeService.deleteEmp(id);
//        return Msg.success();
//    }


    /**员工更新
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName){

        //先判断用户名是否是合法的表达式;
        String regx = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,10})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是4-16位数字和字母的组合或者2-10位中文");
        }

        boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    /**
     * 员工保存
     * 1.支持jsr303校验
     * 2.导入hibernate validator的依赖
     * @param employee
     * @return
     */

    @RequestMapping(value = "/emps",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){

        System.out.println(checkUser(employee.getEmpName()).getCode());

//        校验失败，应该返回失败，在模态框中显示校验失败的错误信息
        if (result.hasErrors()){
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError: fieldErrors) {
//                System.out.println("错误字段名 = "+ fieldError.getField());
//                System.out.println("错误字段信息 = " +fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else
            if (checkUser(employee.getEmpName()).getCode() == 200){

            return Msg.fail();
        }else
        {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }


    @RequestMapping("/emps")
    @ResponseBody //springmvc自动把返回的对象转化为json字符串//需要导入对jackson的依赖
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){

        //引入pageHelper分页插件
        //在查询之前只需调用下面，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage紧跟的查询就是一个分页查询
        List<Employee> emps= employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要讲PageInfo交给页面就行了。
        //封装了详细的分页信息，包括我们查询出来的数据，导航栏连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 查询所有员工数据
     * @return
     */
  //  @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn,Model model){

        System.out.println("emps");
        //引入pageHelper分页插件
        //在查询之前只需调用下面，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage紧跟的查询就是一个分页查询
        List<Employee> emps= employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要讲PageInfo交给页面就行了。
        //封装了详细的分页信息，包括我们查询出来的数据，导航栏连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }
}

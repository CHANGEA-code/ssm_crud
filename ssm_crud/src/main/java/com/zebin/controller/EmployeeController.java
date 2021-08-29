package com.zebin.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.bcel.internal.generic.ACONST_NULL;
import com.zebin.bean.Employee;
import com.zebin.bean.Msg;
import com.zebin.service.DepartmentService;
import com.zebin.service.EmployeeService;
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

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private DepartmentService departmentService;

    @ResponseBody
    @RequestMapping("/getEmployees")
    public Msg getEmployees(@RequestParam(value="pageNum",defaultValue = "1") int pageNum){
        //获取第1页，5条内容
        PageHelper.startPage(pageNum,8);
        List<Employee> employees = employeeService.getAll();
        //用PageInfo对结果进行包装,第二个参数，表示显示的导航页面数
        PageInfo pageInfo = new PageInfo(employees,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @ResponseBody
    @RequestMapping(
            value = "/emp",
            method = RequestMethod.POST
    )
    public Msg saveEmployee(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败
            Map<String, Object> map = new HashMap<String,Object>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 校验用户名输入框信息
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUserName")
    public Msg checkUserName(@RequestParam("empName") String empName){
        //校验格式
        String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(reg)){
            //格式不合法
            return Msg.fail().add("check_res","中文至少需要2位或者英文数字至少需要6位");
        }
        //校验名字是否合法
        int isExist = employeeService.checkUserName(empName);
        if(isExist>0){
            //说明用户名不可用
            return Msg.fail().add("check_res","用户名不可用");
        }else{
            return Msg.success();
        }
    }

    /**
     * 通过id获取emp信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(
            value = "/emp/{id}",
            method = RequestMethod.GET
    )
    public Msg getEmp(@PathVariable("id") int id){
        Employee employee =  employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * Employee
     * [empId=1014, empName=null, gender=null, email=null, dId=null]
     *
     * 问题：
     * 请求体中有数据；
     * 但是Employee对象封装不上；
     * update tbl_emp  where emp_id = 1014;
     *
     * 原因：
     * Tomcat：
     * 		1、将请求体中的数据，封装一个map。
     * 		2、request.getParameter("empName")就会从这个map中取值。
     * 		3、SpringMVC封装POJO对象的时候。
     * 				会把POJO中每个属性的值，request.getParamter("email");
     * AJAX发送PUT请求引发的血案：
     * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     * org.apache.catalina.connector.Request--parseParameters() (3111);
     *
     * protected String parseBodyMethods = "POST";
     * if( !getConnector().isParseBodyMethod(getMethod()) ) {
     success = true;
     return;
     }
     *
     *
     * 解决方案；
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1、配置上HttpPutFormContentFilter；
     * 2、他的作用；将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     *
     * 员工更新方法
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 删除用户
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            //批量删除
            String[] strings = ids.split("-");
            System.out.println(strings);
            List<Integer> list = new ArrayList<Integer>();
            for (String id : strings) {
                list.add(Integer.parseInt(id));
            }
            System.out.println(list);
            employeeService.deleteBatch(list);
            return Msg.success();
        }else{
            //单个删除
            employeeService.deleteEmp(Integer.parseInt(ids));
            return Msg.success();
        }
    }
}

package com.zebin.test;

import com.zebin.bean.Department;
import com.zebin.bean.Employee;
import com.zebin.dao.DepartmentMapper;
import com.zebin.dao.EmployeeMapper;
import com.zebin.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired()
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private SqlSession sqlSession;
    @Autowired
    private EmployeeService employeeService;
    @Test
    public void TestCRUD(){
//        Department department = new Department(null,"技术部");
//        departmentMapper.deleteByPrimaryKey(2);
//        System.out.println(employeeMapper);
//        employeeMapper.insert(new Employee(null,"洪泽彬","男","3030@qq.com",1));
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        List<Employee> employees = mapper.selectByPrimaryKeyWithDept(null);
        System.out.println(employees);

    }
    @Test
    public void TestService(){
        List<Employee> all = employeeService.getAll();
        for (Employee employee : all) {
            System.out.println(employee);
        }
    }
}

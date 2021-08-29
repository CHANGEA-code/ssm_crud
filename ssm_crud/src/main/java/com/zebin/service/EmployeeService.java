package com.zebin.service;

import com.zebin.bean.Employee;
import com.zebin.dao.EmployeeMapper;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        System.out.println(employeeMapper);
        return employeeMapper.selectByPrimaryKeyWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public int checkUserName(String empName){
        return employeeMapper.selectByEmpName(empName);
    }

    public Employee getEmp(int id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(int id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> list) {
        employeeMapper.deleteBatch(list);
    }
}

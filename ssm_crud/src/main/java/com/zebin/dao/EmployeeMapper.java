package com.zebin.dao;

import com.zebin.bean.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    Employee selectByPrimaryKey(@Param("empId")Integer empId);

    List<Employee> selectByPrimaryKeyWithDept(@Param("empId")Integer empId);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);

    int selectByEmpName(@Param("empName") String empName);

    int deleteBatch(List<Integer> list);
}
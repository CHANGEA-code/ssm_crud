package com.zebin.dao;

import com.zebin.bean.Department;

import java.util.List;

public interface DepartmentMapper {
    int deleteByPrimaryKey(Integer deptId);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(Integer deptId);

    List<Department> selectAll();

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
}
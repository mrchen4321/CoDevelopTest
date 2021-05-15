package com.martin.crud.service;

import com.martin.crud.bean.Department;
import com.martin.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author martin cnsibo@163.con
 * @version 1.0
 * @create 2021/4/20 18:42
 */
@Service
public class DepartmentService {

    @Autowired  //?疑问 自动生成
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}

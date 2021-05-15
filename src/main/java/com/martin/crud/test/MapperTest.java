package com.martin.crud.test;

import com.martin.crud.bean.Employee;
import com.martin.crud.dao.DepartmentMapper;
import com.martin.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author martin
 * @version 1.0
 * @create 2021/4/18 20:14
 * 测试dao层
 * (后面又考虑到是spring项目，可以使用spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接autowired要使用的组件
 * )
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    /**
     * 测试departmentMapper
     */
    @Test
    public void testCRUD() {
//        //1.创建SpringIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext();
//        //2.从容器中获取mapper
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);

        System.out.println(departmentMapper);

        //1.插入几个部门
//        Department department1 = new Department(null, "开发部");
//        departmentMapper.insertSelective(department1);
//        Department department2 = new Department(null,"测试部");
//        departmentMapper.insertSelective(department2);

        //2.生成员工数据，测试员工插入
//        Employee employee1 = new Employee(null,"jerry","M","jerry@mail.com",1);
//        employeeMapper.insertSelective(employee1);

        //3.批量插入多个员工;批量，使用可以执行批量操作的sqlSession
//        for (){
//            Employee employee1 = new Employee(null,"jerry","M","jerry@mail.com",1);
//             employeeMapper.insertSelective(employee1);
//        }
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uId = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uId,"M",uId+"@mail.com",1));
        }
        System.out.println("finish");
    }
}

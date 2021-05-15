package com.martin.crud.test;

import com.github.pagehelper.PageInfo;
import com.martin.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author martin cnsibo@163.con
 * @version 1.0
 * @create 2021/4/19 13:48
 *
 * 使用spring 测试模块测试请求的功能，测试crud请求的准确性
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:web/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {

    //传入springmvc的ioc
    @Autowired
    WebApplicationContext context;

    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;


    @Before
    public void initMokeMvc(){
        mockMvc =  MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

        //请求成功以后，请求域中会有pageInfo,我们可以取出pageInfo进行验证
        MockHttpServletRequest request = mvcResult.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("currentPage = " +pageInfo.getPageNum());
        System.out.println("allPage = " +pageInfo.getPages());

        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for (Employee employee:list) {
            System.out.println("id = " + employee.getEmpId());
        }
    }
}

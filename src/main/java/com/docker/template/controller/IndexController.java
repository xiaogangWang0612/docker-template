package com.docker.template.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 请填写类注释
 *
 * @author mayBeJasy
 * @since 2020年11月04日
 */
@RestController
public class IndexController {

    private static final Logger LOGGER = LoggerFactory.getLogger(IndexController.class);

    @GetMapping("/index")
    public Object index() throws Exception {
        LOGGER.info("start execute index ......");
        Map<String, String> map = new HashMap();
        map.put("system-name", "docker-template");
        map.put("system-time", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        LOGGER.info("finish execute index ......");
        return map;
    }
}

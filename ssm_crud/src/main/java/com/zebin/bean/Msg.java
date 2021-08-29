package com.zebin.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
//    状态码：100-成功，200-失败
    private int code;
//    提示消息
    private String msg;
//    要返回给浏览器的内容
    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setMsg("处理成功");
        msg.setCode(100);
        return msg;
    }

    public static Msg fail(){
        Msg msg = new Msg();
        msg.setMsg("处理失败");
        msg.setCode(200);
        return msg;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public Msg() {
    }

    public Msg(int code, String msg, Map<String, Object> extend) {
        this.code = code;
        this.msg = msg;
        this.extend = extend;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}

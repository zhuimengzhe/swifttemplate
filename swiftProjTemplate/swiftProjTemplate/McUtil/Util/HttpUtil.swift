//
//  HttpUtil.swift
//  Guide
//
//  Created by apple on 4/20/16.
//  Copyright © 2016 dingmc. All rights reserved.
//

import Foundation
import Alamofire
class HttpUtil {
    static let instance = HttpUtil()
    private init(){
        
    }
    
    /**
     发送一个请求
     
     - parameter method:     请求方式
     - parameter URLString:  请求URL或String
     - parameter parameters: 请求参数,可不写
     - parameter encoding:   请求编码,可不写
     - parameter headers:    请求头,可不写
     - parameter comple:     响应函数类似block
     
     - returns: 返回一个Alamofire.Request的对象实例
     */
    func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          parameters: [String: AnyObject]? = nil,
          encoding: ParameterEncoding = .URL,
          headers: [String: String]? = nil) -> Alamofire.Request {
        return Alamofire.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers)
    }
    /**
     请求一个JSON
     
     - parameter method:     请求方式
     - parameter URLString:  请求URL或String
     - parameter parameters: 请求参数,可不写
     - parameter encoding:   请求编码,可不写
     - parameter headers:    请求头,可不写
     - parameter comple:     响应函数类似block
     
     - returns: 返回一个Alamofire.Request的对象实例
     */
    func requestJSON(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          parameters: [String: AnyObject]? = nil,
          encoding: ParameterEncoding = .URL,
          headers: [String: String]? = nil,comple:([String:AnyObject]) -> Void) -> Self
    {
        
        Alamofire.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers).responseJSON{
            resp in
            print("网络请求响应数据 \(resp)")
            if resp.result.isSuccess {
                let data = resp.result.value as! [String:AnyObject]
                if data["code"]!.intValue > 0 {
                    comple(data)
                }else{
                    
                }
            }else{
                
            }
        }
        return self
    }
    /**
     请求一个字符串
     
     - parameter method:     请求方式
     - parameter URLString:  请求URL或String
     - parameter parameters: 请求参数,可不写
     - parameter encoding:   请求编码,可不写
     - parameter headers:    请求头,可不写
     - parameter comple:     响应函数类似block
     
     - returns: 返回一个Alamofire.Request的对象实例
     */
    func requestString(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          parameters: [String: AnyObject]? = nil,
          encoding: ParameterEncoding = .URL,
          headers: [String: String]? = nil,comple:(String) -> Void) -> Self
    {
        
        Alamofire.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers).responseString{
            resp in
            if resp.result.isSuccess {
                comple(resp.result.value!)
            }else{
                
            }
        }
        
        return self
    }
    
}

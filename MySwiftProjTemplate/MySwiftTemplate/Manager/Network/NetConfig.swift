//
//  NetConfig.swift
//  MySwiftTemplate
//
//  Created by apple on 25/12/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Alamofire

//请求前的适配器,为了和原来的参数使用统一的encoding
public protocol ConfigPreRequestAdapter {
    //适配header
    func adaptHeader(org:HTTPHeaders?) -> HTTPHeaders?
    //适配参数
    func adaptParameter(org:Parameters?) -> Parameters?
}

//缓存管理器
public protocol ConfigCacheAdapter {
    //获取对应的缓存 R
    func cachedResponse(for request:URLRequest) -> Any?
    //存储对应的缓存 C
    func storeResponse(_ response:Any, for request:URLRequest)
    //移除request对应的缓存 D
    func clearResponse(for request:URLRequest)
    //移除所有缓存 D
    func clearAllResponses()
    //更新缓存 U
    func updateResponse(_ resp:Any, for request:URLRequest)
}

//请求管理器
typealias ConfigRequestAdapter = Alamofire.RequestAdapter

//重试管理器
typealias ConfigRequestRetryAdapter = Alamofire.RequestRetrier

public struct NetConfiger {
    var preRequestAdapter : ConfigPreRequestAdapter?
    var cacheAdapter : ConfigCacheAdapter?
    var requestAdapter : ConfigRequestAdapter?
    var retryAdapter : ConfigRequestRetryAdapter?
}

////
////  HttpManager.swift
////  MySwiftTemplate
////
////  Created by apple on 10/5/2017.
////  Copyright © 2017 apple. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
////定义 网络管理单例宏
//let __NetworkManager = NetController.sharedInstance
//
////MARK:网络请求管理器
//final class NetController {
//    //单例
//    static let sharedInstance = NetController()
//    //sessionManager
//    private let sessionManager: SessionManager
//    
//    //缓存lastComponent
//    private let cacheLastComponent = "/uxinurlcache"
//    
//    //MARK:批量请求
//    //private var batchGroup:DispatchGroup?
//    
//    //MARK:同步请求相关的处理
//    //同步请求的信号量 先调用wait,后调用signal
//    private let syncReqSemaphore = DispatchSemaphore(value: 0)
//    
//    //默认网络状态
//    private var networkStatus = NetworkReachabilityManager.NetworkReachabilityStatus.unknown
//    //一兆  1024 * 1024
//    private let oneM = 1048576
//    
//    //网络状态的监听
//    lazy private var monitorManager = {
//        return NetworkReachabilityManager.init()
//    }()
//    
//    private init(){
//        let urlSessionConfiguration = URLSessionConfiguration.default
//        urlSessionConfiguration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
//        //创建sessionManager 用于管理所有的网络请求
//        sessionManager = SessionManager(configuration: urlSessionConfiguration)
//        //sessionManager.startRequestsImmediately = false
//        //请求前 适配器
//        preRequestAdapter = PreRequestAdapterManager()
//        //缓存 管理器
//        cacheAdapter = FileCacheManager()
//        //请求 适配器
//        requestAdapter = RequestAdapterMangager()
//        //重试 适配器器
//        requestRetrier = RequestRetrierManager()
//        //配置URL缓存
//        configUrlCache()
//        //添加任务完成的通知
//        //addTaskNotification()
//    }
//    
//    //添加Task通知
//    //    func addTaskNotification(){
//    //        let notifyCenter = NotificationCenter.default
//    //        notifyCenter.addObserver(self, selector: #selector(NetController.taskCompleted(notification:)), name: Notification.Name.Task.DidComplete, object: nil)
//    //    }
//    //task完成的通知处理
//    //    @objc func taskCompleted(notification:Notification) {
//    //        printLog("任务完成了....通知信息:\(notification)")
//    //        if let task = notification.userInfo?[Notification.Key.Task] {
//    //            let urlSessionTask = task as! URLSessionTask
//    //            if let lastSyncRequest = syncRequest,
//    //                lastSyncRequest.task == urlSessionTask {
//    //                syncRequest = nil
//    //                syncReqSemaphore.signal()
//    ////                lastRequestOption = .onlyNetwork
//    ////                //将同步请求之后发送的请求,重启
//    ////                for request in self.requestsAfterSync {
//    ////                    request.resume()
//    ////                }
//    ////                self.requestsAfterSync.removeAll()
//    //            }
//    //        }
//    //    }
//    
//    //配置UrlCache缓存策略
//    public func configUrlCache(policy:URLRequest.CachePolicy = .useProtocolCachePolicy, memory:Int = 4, disk:Int = 20) {
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let cachePath = path + cacheLastComponent
//        sessionManager.session.configuration.requestCachePolicy = policy
//        sessionManager.session.configuration.urlCache = URLCache(memoryCapacity: memory * oneM, diskCapacity: disk * oneM, diskPath: cachePath)
//    }
//    
//    //监听网络
//    func notifyNetworking(queue:DispatchQueue = DispatchQueue.global(), notifiBlock:@escaping NetworkReachabilityManager.Listener) {
//        monitorManager?.listenerQueue = queue
//        monitorManager?.listener = notifiBlock
//        monitorManager?.startListening()
//    }
//    
//    //MARK: 请求option
//    struct RequestOption : OptionSet ,CustomStringConvertible{
//        public let rawValue: UInt
//        //仅仅请求网络
//        public static let network = RequestOption(rawValue: 1 << 0)
//        //请求网络并更新缓存,如果没有回调block,将只刷新缓存
//        public static let refreshCache = RequestOption(rawValue: 1 << 1)
//        //同步请求,使用DispatchSemaphore,用于处理一个请求时
//        public static let sync = RequestOption(rawValue: 1 << 2)
//        //批量请求
//        //方法:1.添加标识代表请求完成的数量
//        //2.dispatch_group(enter+leave) 可以实现所有请求异步发送,最后所有都完成时回调
//        //3.DispatchSemaphore未完成时一直等待,完成最后一个时signal 可以实现一个请求完成后在请求另一个请求,最后回调
//        public static let batch = RequestOption(rawValue: 1 << 3)
//        
//        public init(rawValue: UInt) {
//            self.rawValue = rawValue
//        }
//        
//        public var description: String {
//            switch self {
//            case .sync:
//                return "sync"
//            case .refreshCache:
//                return "refreshCache"
//            case .network:
//                return "network"
//            case .batch:
//                return "batch"
//            default:
//                return "default"
//            }
//        }
//    }
//    
//    //响应类型
//    enum ResponseType {
//        case raw
//        case json(JSONSerialization.ReadingOptions)
//        case data
//        case string(String.Encoding?)
//        case plist(PropertyListSerialization.ReadOptions)
//    }
//    
//    //定义响应块
//    typealias ResponseBlock = (Any?) -> Void
//    
//    //批量请求
//    //    public func batchRequest(_ requests:(()->()),complete:(()->())?) {
//    //        batchGroup = DispatchGroup()
//    //        requests()
//    //        batchGroup?.notify(queue: DispatchQueue.main, execute: {
//    //            [unowned self] in
//    //            //将group置为nil
//    //            self.batchGroup = nil
//    //            complete?()
//    //        })
//    //        defer {
//    //
//    //        }
//    //    }
//    
//    /// 数据请求
//    /// - Parameters:
//    ///   - url: 请求的url地址
//    ///   - method: 请求方法
//    ///   - parameters: 请求参数
//    ///   - encoding: 请求参数的编码
//    ///   - headers: 请求头
//    ///   - requestOption: 请求option
//    ///   - responseType: 响应类型
//    ///   - responseQueue: 响应的队列
//    ///   - success: 成功的block
//    ///   - failure: 失败的block
//    public func request(
//        _ url: URLConvertible,
//        method: HTTPMethod = .post,
//        parameters: Parameters? = nil,
//        encoding: ParameterEncoding = URLEncoding.default,
//        headers: HTTPHeaders? = nil,
//        requestOption: RequestOption = .network,
//        responseType: ResponseType = .json(.allowFragments),
//        responseQueue: DispatchQueue? = nil,
//        success: @escaping ResponseBlock,
//        failure: @escaping ResponseBlock) {
//        //请求前的适配器处理
//        var adaptedHeaders = headers
//        var adaptedParameters = parameters
//        if let preReqAdapter = preRequestAdapter {
//            adaptedHeaders = preReqAdapter.adaptHeader(org: headers)
//            adaptedParameters = preReqAdapter.adaptParameter(org: parameters)
//        }
//        
//        
//        let serializeResponseQueue = DispatchQueue.global()
//        let dataRequest =  sessionManager.request(url, method: method, parameters: adaptedParameters, encoding: encoding, headers: adaptedHeaders)
//        
//        //缓存适配器
//        //        if let cacheManager = cacheAdapter {
//        //            switch requestOption {
//        //            case .sync:
//        //                print("同步请求")
//        //            case .batch:
//        //                print("批量请求")
//        //            case .refreshCache:
//        //                if let task = dataRequest.task {
//        //                    sessionManager.delegate[task] = nil
//        //                }
//        //
//        //                guard let result = cacheManager.cachedResponse(for: dataRequest.request!) else {
//        //                    failure("no cached")
//        //                    return;
//        //                }
//        //                success(result)
//        //            default:
//        //                print("\(#function)---\(requestOption)")
//        //            }
//        //        }
//        
//        switch responseType {
//        case .raw:
//            dataRequest.response(queue: serializeResponseQueue) {
//                [unowned self] response in
//                self.configAfterResponse(by: requestOption)
//                (responseQueue ?? DispatchQueue.main).async {
//                    if let data = response.data {
//                        success(data)
//                    }else{
//                        failure(response.error)
//                    }
//                }
//            }
//        case .json(let jsonOption):
//            dataRequest.responseJSON(queue: serializeResponseQueue, options:jsonOption) {
//                [unowned self] jsonResponse in
//                self.configAfterResponse(by: requestOption)
//                (responseQueue ?? DispatchQueue.main).async {
//                    switch jsonResponse.result {
//                    case .success:
//                        success(jsonResponse.result.value)
//                    case .failure(let error):
//                        failure(error)
//                    }
//                }
//            }
//        case .data:
//            dataRequest.responseData(queue: serializeResponseQueue) {
//                [unowned self] dataResponse in
//                self.configAfterResponse(by: requestOption)
//                (responseQueue ?? DispatchQueue.main).async {
//                    switch dataResponse.result {
//                    case .success:
//                        success(dataResponse.result.value)
//                    case .failure(let error):
//                        failure(error)
//                    }
//                }
//            }
//        case .string(let stringEncoding):
//            dataRequest.responseString(queue: serializeResponseQueue, encoding: stringEncoding) {
//                [unowned self] stringResponse in
//                self.configAfterResponse(by: requestOption)
//                (responseQueue ?? DispatchQueue.main).async {
//                    switch stringResponse.result {
//                    case .success:
//                        success(stringResponse.result.value)
//                    case .failure(let error):
//                        failure(error)
//                    }
//                }
//            }
//        case .plist(let pListOption):
//            dataRequest.responsePropertyList(queue: serializeResponseQueue, options: pListOption) {
//                [unowned self] plistResponse in
//                self.configAfterResponse(by: requestOption)
//                (responseQueue ?? DispatchQueue.main).async {
//                    switch plistResponse.result {
//                    case .success:
//                        success(plistResponse.result.value)
//                    case .failure(let error):
//                        failure(error)
//                    }
//                }
//            }
//        }
//        //设置请求前的处理
//        configBeforeRequest(by: requestOption)
//    }
//    
//    private func configBeforeRequest(by option:RequestOption) {
//        switch option {
//        case .sync:
//            //信号量不能用于同一个线程
//            self.syncReqSemaphore.wait()
//        case .batch:
//            //batchGroup?.enter()
//            print("\(#function)---\(option)")
//        default:
//            print("\(#function)---\(option)")
//        }
//    }
//    
//    private func configAfterResponse(by option:RequestOption) {
//        switch option {
//        case .sync:
//            syncReqSemaphore.signal()
//        case .batch:
//            //self.batchGroup?.leave()
//            print("\(#function)---\(option)")
//        default:
//            print("\(#function)---\(option)")
//        }
//    }
//    
//    //请求超时
//    public var requestTimeOut: TimeInterval {
//        get {
//            return sessionManager.session.configuration.timeoutIntervalForRequest
//        }
//        set {
//            sessionManager.session.configuration.timeoutIntervalForRequest = newValue
//        }
//    }
//    
//    //MARK:适配器相关
//    //请求前的一个适配器
//    public var preRequestAdapter : ConfigPreRequestAdapter?
//    //缓存管理器
//    public var cacheAdapter : ConfigCacheAdapter?
//    //请求适配器
//    public var requestAdapter: ConfigRequestAdapter? {
//        get {
//            return sessionManager.adapter
//        }
//        set {
//            sessionManager.adapter = newValue
//        }
//    }
//    //请求重试器
//    public var requestRetrier: ConfigRequestRetryAdapter? {
//        get {
//            return sessionManager.retrier
//        }
//        set {
//            sessionManager.retrier = newValue
//        }
//    }
//}
//
////MARK: 适配器
////请求前的 管理器
//struct PreRequestAdapterManager : ConfigPreRequestAdapter {
//    //还不知道基本参数有哪些
//    func getBasicHeaders() -> HTTPHeaders? {
//        return HTTPHeaders()
//    }
//    
//    //适配header
//    func adaptHeader(org:HTTPHeaders?) -> HTTPHeaders? {
//        return (unionTwoDic(first: getBasicHeaders(), second: org) as! HTTPHeaders?)
//    }
//    
//    func getBasicParamters() -> Parameters? {
//        return Parameters()
//    }
//    //适配参数
//    func adaptParameter(org:Parameters?) -> Parameters? {
//        return unionTwoDic(first: getBasicParamters(), second: org)
//    }
//    
//    //合并两个以String为key的字典
//    func unionTwoDic(first: [String:Any]?, second: [String:Any]?) -> [String:Any]? {
//        guard var realFirst = first else {
//            return second
//        }
//        
//        guard let realSecond = second else {
//            return realFirst
//        }
//        
//        for keyValue in realSecond {
//            realFirst[keyValue.key] = realSecond[keyValue.key]
//        }
//        return realFirst
//    }
//}
//
////MARK:请求适配器 管理器
//struct RequestAdapterMangager : ConfigRequestAdapter {
//    //请求超时的处理,每个key:request's url  value:the request's requesttimetout
//    let requestsTimeout = [String:TimeInterval]()
//    
//    //在这里面可以给url重新定义,可以在header添加参数,可以在body里面添加参数,可以加一些基础的请求参数
//    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        let url = urlRequest.url?.absoluteString
//        guard let requestUrl = url else {
//            return urlRequest
//        }
//        var mulUrlRequest = urlRequest
//        let requestTimeout = requestsTimeout[requestUrl] ?? __NetworkManager.requestTimeOut
//        mulUrlRequest.timeoutInterval = requestTimeout
//        //到这里的时候已经编完码了,这里要使用追加的方式处理
//        return mulUrlRequest
//    }
//}
//
////MARK:重试请求 管理器
//struct RequestRetrierManager : RequestRetrier {
//    //里面控制每个单个url的重试次数
//    let requestsRetryCount = [String:Int]()
//    
//    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
//        let url = request.request?.url?.absoluteString
//        guard let requestUrl = url else {
//            completion(false,0)
//            return
//        }
//        
//        let retryCountForRequest = requestsRetryCount[requestUrl] ?? 0
//        if request.retryCount < retryCountForRequest {
//            completion(true,0)
//        }else{
//            completion(false,0)
//        }
//    }
//}
//
////MARK:使用文件缓存实现缓存策略
////import CryptoSwift
////文件缓存 管理器
//struct FileCacheManager : ConfigCacheAdapter {
//    //MARK:缓存的实现
//    static var createSucceed: Bool = false
//    
//    //TODO:获得主键,简单的算法,url+body的md5,没有body就用url的md5
//    func getPrimaryKey(from request:URLRequest) -> String? {
//        //        guard let urlmd5 = request.url?.absoluteString.md5() else {
//        //            return nil
//        //        }
//        //
//        //        guard let bodymd5 = request.httpBody?.toHexString().md5() else {
//        //            return urlmd5
//        //        }
//        //        return urlmd5 + bodymd5
//        return ""
//    }
//    //初始化
//    init() {
//        FileCacheManager.initFileCachePath()
//    }
//    //缓存的文件路径
//    static var cachePath: String {
//        return FileController.sharedInstance.cachePath() + "/uxinFileCache/"
//    }
//    //初始化,主要是创建缓存的文件夹
//    static func initFileCachePath() {
//        
//        FileController.sharedInstance.removeAllFiles(in: FileCacheManager.cachePath)
//        if FileController.sharedInstance.createDirectory(atPath: FileCacheManager.cachePath) {
//            createSucceed = true
//        }else{
//            createSucceed = false
//            print("缓存文件夹初始化失败")
//        }
//    }
//    //获取完整的文件缓存的路径,主键为文件名
//    func getWholePath(from request:URLRequest) -> String? {
//        guard let primary = getPrimaryKey(from: request) else {
//            return nil
//        }
//        if !FileCacheManager.createSucceed {
//            FileCacheManager.initFileCachePath()
//        }
//        let wholePath = FileCacheManager.cachePath + "/" + primary
//        return wholePath
//    }
//    
//    //获取对应的缓存
//    func cachedResponse(for request:URLRequest) -> Any? {
//        guard let wholePath = getWholePath(from: request) else {
//            return nil
//        }
//        do {
//            let response = try String.init(contentsOfFile: wholePath)
//            return response
//        }catch {
//            print("获取缓存失败")
//            return nil
//        }
//    }
//    //存储对应的缓存
//    func storeResponse(_ response:Any, for request:URLRequest) {
//        guard let wholePath = getWholePath(from: request) else {
//            return
//        }
//        if response is NSDictionary {
//            (response as! NSDictionary).write(toFile: wholePath, atomically: true)
//        }else if response is NSArray {
//            (response as! NSArray).write(toFile: wholePath, atomically: true)
//        }else if response is NSData {
//            (response as! NSData).write(toFile: wholePath, atomically: true)
//        }else if response is Data {
//            do {
//                try (response as! Data).write(to: URL(fileURLWithPath: wholePath))
//            }catch{
//                print("转换为data写入文件失败")
//            }
//        }else if response is String || response is NSString {
//            do {
//                try (response as! String).write(toFile: wholePath, atomically: true, encoding: .utf8)
//            }catch{
//                print("转换为string写入文件失败")
//            }
//        }else{
//            print("其他的类型暂未做类型转换")
//        }
//    }
//    //移除request对应的缓存
//    func clearResponse(for request:URLRequest) {
//        guard let wholePath = getWholePath(from: request) else {
//            return
//        }
//        FileController.sharedInstance.removeFile(at: wholePath)
//    }
//    //移除所有缓存
//    func clearAllResponses() {
//        FileController.sharedInstance.removeAllFiles(in: FileCacheManager.cachePath)
//    }
//    //更新缓存
//    func updateResponse(_ resp:Any, for request:URLRequest) {
//        storeResponse(resp, for: request)
//    }
//}
//
///*
// //MARK:使用RealmSwift实现缓存
// import RealmSwift
// struct DBCacheManager : ConfigCacheAdapter {
// //TODO:获得主键,简单的算法,url+body的md5,没有body就用url的md5
// func getPrimaryKey(from request:URLRequest) -> String? {
// guard let urlmd5 = request.url?.absoluteString.md5() else {
// return nil
// }
// 
// guard let bodymd5 = request.httpBody?.toHexString().md5() else {
// return urlmd5
// }
// return urlmd5 + bodymd5
// }
// 
// //数据库响应结构
// class DBResponse: Object {
// @objc dynamic var code: Int = 0
// @objc dynamic var message = ""
// @objc dynamic var json: String = ""
// @objc dynamic var version: String = ""
// convenience init(code:Int = 0,message:String = "",json:String = "",version:String = "") {
// self.init()
// self.code = code
// self.message = message
// self.json = json
// self.version = version
// }
// //主键
// @objc open override class func primaryKey() -> String? {
// return "urlmd5str"
// }
// //索引
// @objc open override class func indexedProperties() -> [String] {
// return []
// }
// //忽略属性,不会存储到数据库
// @objc open override class func ignoredProperties() -> [String] {
// return []
// }
// }
// 
// //获取磁盘数据库数据库
// func getDiskRealm() -> Realm? {
// let realm = try! Realm()
// //默认的数据库存储在document路径下,默认是default.realm,磁盘缓存
// print("realm数据库路径:\(realm.configuration.fileURL!.absoluteString)")
// return realm
// }
// //获取内存数据库
// func getMemoryRealm() -> Realm? {
// //数据库实例被自动释放掉, 这就需要我们在app的生命周期内保持对realm内存数据库的强引用
// var config = Realm.Configuration.defaultConfiguration
// config.inMemoryIdentifier = "memorydb"
// let realm = try! Realm(configuration: config)
// return realm
// }
// 
// //获取对应的缓存
// func cachedResponse(for request:URLRequest) -> Any? {
// guard let primary = getPrimaryKey(from: request) else {
// return nil
// }
// guard let realm = getDiskRealm() else {
// return nil
// }
// 
// return realm.object(ofType: DBResponse.self, forPrimaryKey: primary)
// }
// //存储对应的缓存
// func storeResponse(_ response:Any, for request:URLRequest) {
// guard let primary = getPrimaryKey(from: request) else {
// return
// }
// guard let realm = getDiskRealm() else {
// return
// }
// //模拟返回数据
// let dbresponse = DBResponse(value:["code":0,"message":"message","json":"Json","version":primary])
// try! realm.write {
// realm.add(dbresponse, update: true)
// //realm.create
// }
// }
// //移除request对应的缓存
// func clearResponse(for request:URLRequest) {
// guard let primary = getPrimaryKey(from: request) else {
// return
// }
// guard let realm = getDiskRealm() else {
// return
// }
// guard let resp = realm.object(ofType: DBResponse.self, forPrimaryKey: primary) else {
// return
// }
// try! realm.write {
// realm.delete(resp)
// //realm.deleteAll()
// }
// }
// //移除所有缓存
// func clearAllResponses() {
// 
// }
// 
// //更新缓存
// func updateResponse(_ resp:Any, for request:URLRequest) {
// storeResponse(resp, for: request)
// }
// 
// /// Realm 文件删除操作
// static func deleteRealmFile() {
// let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
// let realmURLs = [
// realmURL,
// realmURL.appendingPathExtension("lock"),
// realmURL.appendingPathExtension("log_a"),
// realmURL.appendingPathExtension("log_b"),
// realmURL.appendingPathExtension("note")
// ]
// 
// for URL in realmURLs {
// if !__FileManager.removeFile(at: URL.absoluteString) {
// print("移除文件出错 路径:\(URL.absoluteString)")
// }
// }
// }
// //数据迁移
// func migrate() {
// /* Realm 数据库配置，用于数据库的迭代更新 */
// let schemaVersion: UInt64 = 0
// 
// let config = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: { migration, oldSchemaVersion in
// 
// /* 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构 */
// if (oldSchemaVersion < schemaVersion) {
// 
// }
// })
// Realm.Configuration.defaultConfiguration = config
// Realm.asyncOpen { (realm, error) in
// if let _ = realm {
// /* Realm 成功打开，迁移已在后台线程中完成 */
// print("Realm 数据库配置成功")
// }else if let error = error {
// /* 处理打开 Realm 时所发生的错误 */
// print("Realm 数据库配置失败：\(error.localizedDescription)")
// }
// }
// }
// //设置为每个用户/账户设置数据库,用于切换用户时的数据库不冲突
// func setDefaultRealmForUser(username: String) {
// var config = Realm.Configuration()
// // 使用默认的目录，但是使用用户名来替换默认的文件名
// config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username).realm")
// // 将这个配置应用到默认的 Realm 数据库当中
// Realm.Configuration.defaultConfiguration = config
// }
// }
// */

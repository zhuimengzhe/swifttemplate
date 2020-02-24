//
//  FileManager.swift
//  MySwiftTemplate
//
//  Created by apple on 20/5/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

struct FileController {
    static let sharedInstance = FileController()
    private init(){}
    private let fileSingtonManager = FileManager.default
    //1024 * 1024
    private let fileOneM : Double = 1048576
    //mainBundle 工程打包安装后会在NSBundle.mainBundle()路径下，该路径是只读的，不允许修改。
    func mainBundlePath() -> String {
        return Bundle.main.bundlePath
    }
    
    //主目录 整个应用程序各文档所在的目录
    func homePath() -> String {
        return NSHomeDirectory()
    }
    
    //用户文档目录，苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
    func documentsPath() -> String{
        let documentpaths = NSSearchPathForDirectoriesInDomains(.documentationDirectory, .userDomainMask, true)
        return documentpaths[0]
    }
    
    func documentsURL() -> URL? {
        let documentpaths = fileSingtonManager.urls(for: .documentationDirectory, in: .userDomainMask)
        return documentpaths[0]
    }
    
    //Library目录
    //Library/Cache
    //Library/Preferences目录，包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好。
    func libraryPath() -> String {
        let libraryPaths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        return libraryPaths[0]
    }
    
    //Library/Caches目录，主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会再应用退出时删除
    func cachePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
    
    //tmp目录 用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空。
    func tmpPath() -> String {
        return NSTemporaryDirectory()
    }
    func tmpUrl() -> URL {
        return URL(fileURLWithPath: tmpPath(), isDirectory: true)
    }
    
    //文件是否存在
    func fileExist(at path:String) -> Bool {
        return fileSingtonManager.fileExists(atPath:path)
    }
    
    //创建目录
    @discardableResult
    func createDirectory(atPath path: String) -> Bool {
        do {
            try fileSingtonManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            return false
        }
    }
    
    //删除 单个文件
    @discardableResult
    func removeFile(at path: String) -> Bool {
        do {
            try fileSingtonManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }
    
    //删除目录下所有的文件
    @discardableResult
    func removeAllFiles(in path: String) -> Bool {
        let enumerator = fileSingtonManager.enumerator(atPath: path)
        
        while let fileName = enumerator?.nextObject() as? String {
            let success = removeFile(at:path + "/\(fileName)")
            if !success {
                return false
            }
        }
        
        return true
    }
    
    func clearCacheFile() {
        removeAllFiles(in: cachePath())
    }
    
    func tempUnzipPath(floderName: String = NSUUID().uuidString) -> String? {
        let path = documentsPath() + "/\(floderName)"
        if(createDirectory(atPath: path)) {
            return path
        }else{
            return nil
        }
    }
    
    func hasFileInFolder(_ path: String) -> Bool{
        let enumerator = fileSingtonManager.enumerator(atPath: path)
        while let fileName = enumerator?.nextObject() as? String {
            if fileExist(at: path + "/\(fileName)") {
                return true
            }
        }
        return false
    }
    
    func folderSize(at path: String) -> Double {
        if !fileExist(at: path) {
            print("文件不存在")
        }
        
        var totalSize:Double = 0
        let enumerator = fileSingtonManager.enumerator(atPath: path)
        while let fileName = enumerator?.nextObject() as? String {
            let fileAbsoluePath = path + "/\(fileName)"
            totalSize += fileSize(at: fileAbsoluePath)
        }
        return totalSize
    }
    
    //文件大小
    func fileSize(at path:String) -> Double{
        var fileSize: Double = 0.0
        do{
            fileSize = try fileSingtonManager.attributesOfItem(atPath: path)[FileAttributeKey.size] as! Double
        }catch{
            print("未知错误")
        }
        return fileSize/fileOneM
    }
    
    func renameFileByPath(path: String, oldName: String, newName: String){
        guard fileExist(at: path + "/" + oldName) else{
            print("没有找到文件: \(oldName)")
            return
        }
        do{
            try fileSingtonManager.moveItem(atPath: path + "/" + oldName, toPath: path + "/" + newName)
        }catch{
            print("文件移动失败")
        }
    }
}


//
//  TouchIDManager.swift
//  MySwiftTemplate
//
//  Created by apple on 21/9/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import LocalAuthentication

public struct TouchIDController {
    static let sharedInstance = TouchIDController()
    
    private let context = LAContext()
    private init () {
        context.localizedFallbackTitle = "右取消"
        
        if #available(iOS 10,*) {
            context.localizedCancelTitle = "左标提"
        }
        if #available(iOS 11,*) {
            context.localizedReason = "自定义原因"
        }
    }
    
    //验证是在子线程进行的
    func touchID (_ reason:String = "请用指纹解锁") {
        
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 开始进入识别状态，以闭包形式返回结果。闭包的 success 是布尔值，代表识别成功与否。error 为错误信息。
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason:reason, reply: {success, errori in
                
                if success {
                    // 成功之后的逻辑， 通常使用多线程来实现跳转逻辑。
                }
                else {
                    self.dealError(errori)
                }
            })
        }
        else {
            dealError(error)
        }
    }
    
    //处理错误的信息
    private func dealError(_ error:Error?) {
        if let error = error as NSError? {
            // 获取错误信息
            let message = self.errorMessageForLAErrorCode(errorCode: error.code)
            print("errot===  \(message)")
        }
    }
    
    //不让子类或者扩展修改该方法
    private func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        switch errorCode {
        case LAError.appCancel.rawValue:
            // app取消验证
            message = "Authentication was cancelled by application"
        case LAError.authenticationFailed.rawValue:
            // 身份验证失败
            message = "The user failed to provide valid credentials"
        case LAError.invalidContext.rawValue:
            // 无效的上下文
            message = "The context is invalid"
        case LAError.passcodeNotSet.rawValue:
            //没有设置密码
            // 设备上并不具备密码设置信息，也就是说Touch ID功能处于被禁用状态
            message = "Passcode is not set on the device"
        case LAError.systemCancel.rawValue:
            // 被系统取消，例如按下电源键,被其他App切入
            message = "Authentication was cancelled by the system"
        case LAError.touchIDLockout.rawValue:
            // 输入次数过多验证被锁
            message = "Too many failed attempts."
        case LAError.touchIDNotAvailable.rawValue:
            // 设备本身并不具备指纹传感装置,或者未打开
            message = "TouchID is not available on the device"
        case LAError.userCancel.rawValue:
            // 用户取消,点击取消按钮
            message = "The user did cancel"
        case LAError.userFallback.rawValue:
            //点击输入密码按钮
            //验证失败,用户选择了右边的按钮,之后的处理,该刷新页面了
            message = "The user chose to use the fallback"
        case LAError.touchIDNotEnrolled.rawValue:
            // 已经设定有密码机制，但设备配置当中还没有保存过任何指纹内容
            message = "touch id not saved"
        default:
            message = "Did not find error code on LAError object"
        }
        return message
    }
}


//
//  Utils.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

//MARK:配置全局view的实例的展示
public func configGlobalAppearance() {
    //    UIApplication.shared.statusBarStyle = .default
    
    UINavigationBar.appearance().barTintColor = UIColor.white
    
    let titleAttribute = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30),
        NSAttributedString.Key.strokeColor : UIColor.black,
        NSAttributedString.Key.strokeWidth : 1.5,
        NSAttributedString.Key.foregroundColor : UIColor.black
        ] as [NSAttributedString.Key : Any]
    
    UINavigationBar.appearance().titleTextAttributes = titleAttribute
    
    UIImageView.appearance(whenContainedInInstancesOf: [UITableViewCell.self,UICollectionReusableView.self]).backgroundColor = UIColor.lightGray
    UIImageView.appearance().backgroundColor = UIColor.clear
    
    let tableViewAppearance = UITableView.appearance()
    tableViewAppearance.backgroundColor = UIColor.clear
    tableViewAppearance.separatorColor = UIColor.lightText
    tableViewAppearance.sectionIndexColor = UIColor.gray
    tableViewAppearance.sectionIndexBackgroundColor = UIColor.white.withAlphaComponent(0.5)
    tableViewAppearance.sectionIndexTrackingBackgroundColor = UIColor.lightGray
    
    UILabel.appearance().backgroundColor = UIColor.clear
}
//MARK:打开/关闭接收远程事件
public func openReceiveRemoteEvent() {
    UIApplication.shared.beginReceivingRemoteControlEvents()
}
public func closeReceiveRemoetEvent() {
    UIApplication.shared.endReceivingRemoteControlEvents()
}
//MARK:打印变量的地址
func address(of obj: AnyObject) -> UnsafeMutableRawPointer {
    return Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque()
}
//MARK:获取icon图片的名称
func appIconName() -> String? {
    let infoDict = Bundle.main.infoDictionary
    let icons = infoDict?["CFBundleIcons"] as! [String:Any]?
    let primaryIcon = icons?["CFBundlePrimaryIcon"] as! [String:Any]?
    let iconFiles = primaryIcon?["CFBundleIconFiles"] as! [String]?
    return iconFiles?.last
}
//MARK:获取启动图片的名称
func launchImageName() -> String? {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let screenSize =  appDelegate.window?.bounds.size ?? CGSize.zero
    let viewOrientation = "Portrait"
    var launchImageName:String? = nil
    let infoDict = Bundle.main.infoDictionary
    guard let imagesDict = infoDict?["UILaunchImages"] as! [[String:String]]? else {
        return nil
    }
    for dict in imagesDict {
        
        let imageSize = NSCoder.cgSize(for: dict["UILaunchImageSize"]!)
        if imageSize.equalTo(screenSize) && viewOrientation == dict["UILaunchImageOrientation"] {
            launchImageName = dict["UILaunchImageName"]
        }
    }
    
    return launchImageName
}
//MARK:动画切换rootvc
func animateChangeRootVC(_ rootVC:UIViewController) {
    let sharedApplication = UIApplication.shared
    UIView.transition(with: sharedApplication.keyWindow!, duration: 0.5, options: .transitionCrossDissolve, animations: {
        let oldState = UIView.areAnimationsEnabled
        UIView.setAnimationsEnabled(false)
        sharedApplication.keyWindow?.rootViewController = rootVC
        UIView.setAnimationsEnabled(oldState)
    }) { (finished) in
        
    }
}
//MARK:设置手机是否自动锁屏
func disablePhoneSleep(_ disable:Bool) {
    UIApplication.shared.isIdleTimerDisabled = disable
}
//MARK:打开手机设置界面
func openPhoneSettings() {
    let settingUrl = URL.init(string: UIApplication.openSettingsURLString)!
    if UIApplication.shared.canOpenURL(settingUrl) {
        if #available(iOS 10.0, *){
            UIApplication.shared.open(settingUrl, options: [:]) { (finished) in
                if finished {
                    print("打开设置完成")
                }
            }
        }
        else {
            UIApplication.shared.openURL(settingUrl)
        }
    }
}
//MARK:获取一个视图的截屏
func getThumbImageFromView(_ view:UIView) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 1.0)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
}
//MARK:获取一个颜色的截屏
func getThumbImageFromColor(_ color:UIColor) -> UIImage? {
    let rect = CGRect(0, 0, 1.0, 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
}
//MARK:角度转弧度
func degreesToRadian(_ degree:Double) -> Double {
    return degree / 180.0 * Double.pi
}
//MARK:弧度转角度
func radianToDegrees(_ radian:Double) -> Double {
    return radian * 180.0 / Double.pi
}
//MARK:随机颜色
func randomColor() -> UIColor {
    let redValue = Double(arc4random() % 255) / 255.0
    let greenValue = Double(arc4random() % 255) / 255.0
    let blueValue = Double(arc4random() % 255) / 255.0
    let color = UIColor.init(red: CGFloat(redValue), green: CGFloat(greenValue), blue: CGFloat(blueValue), alpha: 1.0)
    return color
}
//MARK:获取window
func getWindow() -> UIWindow? {
    var win:UIWindow? = nil
    for item in UIApplication.shared.windows {
        if !item.isHidden {
            win = item
            break
        }
    }
    return win
}
//MARK:收起键盘
func hideKeyBoard() {
    UIApplication.shared.keyWindow?.endEditing(true)
}
//MARK:复制文本
func systemCopy(_ text:String) {
    let pasteBoard = UIPasteboard.general
    pasteBoard.string = text
}


//MARK:获取当前正在显示的vc
func getVisibleVCFrom(_ vc:UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        let naviVC = vc as! UINavigationController
        return getVisibleVCFrom(naviVC.visibleViewController)
    }else if vc is UITabBarController {
        let tabVC = vc as! UITabBarController
        return getVisibleVCFrom(tabVC.selectedViewController)
    }else{
        if let presentedVC = vc?.presentedViewController {
            return getVisibleVCFrom(presentedVC)
        }else {
            return vc
        }
    }
}
//MARK:合并两个图片
func mergeImage(first firstImage:UIImage, with secondImage:UIImage) -> UIImage? {
    let firstImageRef = firstImage.cgImage
    let firstWidth = firstImageRef?.width ?? 0
    let firstHeight = firstImageRef?.height ?? 0
    
    let secondImageRef = secondImage.cgImage
    let secondWidth = secondImageRef?.width ?? 0
    let secondHeight = secondImageRef?.height ?? 0
    let mergedSize = CGSize(width: max(firstWidth, secondWidth), height: max(firstHeight, secondHeight))
    
    UIGraphicsBeginImageContext(mergedSize)
    firstImage.draw(in: CGRect(x: 0, y: 0, width: firstWidth, height: firstHeight))
    secondImage.draw(in: CGRect(x: 0, y: 0, width: secondWidth, height: secondHeight))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}
//MARK:图片的base64表示
func base64StringFrom(image:UIImage) -> String? {
    return image.pngData()?.base64EncodedString()
}
//MARK:从base64串获取一张图
func imageFrom(base64:String) -> UIImage? {
    guard let data = Data.init(base64Encoded: base64) else {
        return nil
    }
    return UIImage.init(data: data)
}
//MARK:显示状态栏里面的网络请求小菊花
func showNetworkIndicator(_ show:Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = show
}
//MARK:设置view的exclusivetouch
func enableViewExclusiveTouch(_ enable:Bool) {
    UIView.appearance().isExclusiveTouch = enable
}
//MARK:输入器里面的非marked的text
func nonMarkedText(_ textInput: UITextInput) -> String? {
    let start = textInput.beginningOfDocument
    let end = textInput.endOfDocument
    
    guard let rangeAll = textInput.textRange(from: start, to: end),
        let text = textInput.text(in: rangeAll) else {
            return nil
    }
    
    guard let markedTextRange = textInput.markedTextRange else {
        return text
    }
    
    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
        let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
            return text
    }
    
    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}


import UIKit

//Mark: 根据6尺寸适配...
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

let scaleH6 = ScreenWidth / 667.0
let scaleW6 = ScreenHeight / 375.0

let scale6 = (scaleH6 > scaleW6 ? scaleH6 : scaleW6)

let UserDefaultInstance = UserDefaults.standard
let UserDefaultInstanceSync = UserDefaultInstance.synchronize()

let NotificationInstance = NotificationCenter.default

let application = UIApplication.shared
let appDelegate = (application.delegate as! AppDelegate)
let statuBarHeight = application.statusBarFrame.height

let KeyWindow = UIApplication.shared.keyWindow!

let CommonViewBgColor = UIColor.white

let AppTest = true

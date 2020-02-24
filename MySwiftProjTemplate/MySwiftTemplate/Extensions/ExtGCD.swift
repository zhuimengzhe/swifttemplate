//
//  ExtGCD.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

enum System : String {
    //新的url_Scheme表 prefs:在iOS10中变成了Prefs:
    case batteryusage = "Prefs:root=BATTERY_USAGE" //电池电量
    case deviceusage = "Prefs:root=General&;path=STORAGE_ICLOUD_USAGE/DEVICE_STORAGE" //存储空间
    case datasettingsid = "Prefs:root=MOBILE_DATA_SETTINGS_ID" //蜂窝数据
    case location = "Prefs:root=Privacy&;path=LOCATION" //定位设置
    case general = "prefs:root=General"
    case about = "prefs:root=General&path=About" //关于本机
    case accessibility = "prefs:root=General&;path=ACCESSIBILITY" //辅助功能
    case airplanemode = "prefs:root=AIRPLANE_MODE"
    case autolock = "prefs:root=General&path=AUTOLOCK"
    case cellularusage = "prefs:root=General&path=USAGE/CELLULAR_USAGE"
    case brightness = "prefs:root=Brightness"
    case bluetooth = "prefs:root=Bluetooth" //蓝牙设置
    case dateandtime = "prefs:root=General&path=DATE_AND_TIME"
    case facetime = "prefs:root=FACETIME"
    case keyboard = "prefs:root=General&path=Keyboard" //键盘设置
    case display = "Prefs:root=DISPLAY" //显示设置
    
    case castle = "prefs:root=CASTLE" //iCloud
    case storageandbackup = "prefs:root=CASTLE&path=STORAGE_AND_BACKUP"
    case international = "prefs:root=General&path=INTERNATIONAL"
    case locationservice = "prefs:root=LOCATION_SERVICES"
    case accountsettings = "prefs:root=ACCOUNT_SETTINGS"
    case music = "prefs:root=MUSIC"
    case musiceq = "prefs:root=MUSIC&path=EQ"
    case volumelimit = "prefs:root=MUSIC&path=VolumeLimit"
    case network = "prefs:root=General&path=Network"
    case nikeplusipod = "prefs:root=NIKE_PLUS_IPOD"
    case notes = "prefs:root=NOTES"
    case notificationsid = "prefs:root=NOTIFICATIONS_ID" //通知
    case phone = "prefs:root=Phone"
    case phones = "prefs:root=Photos"
    case configurationlist = "prefs:root=General&path=ManagedConfigurationList"
    case reset = "prefs:root=General&path=Reset"
    case ringtone = "prefs:root=Sounds&path=Ringtone"
    case safari = "prefs:root=Safari"
    case assistant = "prefs:root=General&path=Assistant"
    case sounds = "prefs:root=Sounds" //声音设置
    case softwareupdatelink = "prefs:root=General&path=SOFTWARE_UPDATE_LINK"
    case store = "prefs:root=STORE" //appstore设置
    case twitter = "prefs:root=TWITTER"
    case facebook = "prefs:root=FACEBOOK"
    case usage = "prefs:root=General&path=USAGE"
    case video = "prefs:root=VIDEO"
    case vpn2 = "App-Prefs:root=VPN" //VPN
    case vpn = "prefs:root=General&path=Network/VPN"
    case wallpaper = "prefs:root=Wallpaper" //墙纸设置
    case wifi = "prefs:root=WIFI"//wifi设置
    case openmobile = "Mobilephone://" //打开电话
    case openworldclock = "Clock-worldclock://" //世界时钟
    case openalarm = "Clock-alarm://" //闹钟
    case openstopwatch = "Clock-stopwatch://" //秒表
    case openclocktimer = "Clock-timer://" //倒计时
    case openphotos = "Photos://" //打开相册
    case internettethering = "prefs:root=INTERNET_TETHERING" //个人热点
    case blocked = "prefs:root=Phone&path=Blocked"
    case donotdisturb = "prefs:root=DO_NOT_DISTURB"
    case carrier = "App-Prefs:root=Carrier" //运营
    case siri = "App-Prefs:root=SIRI"
    case privacy = "App-Prefs:root=Privacy" //隐私
    
    case maps = "maps://" //地图
    case mobilenotes = "mobilenotes://" //备忘录
    case sms = "sms://" //sms
    case mail = "mailto:///" //邮件
    case ibooks = "ibooks://" //ibooks
    case music1 = "music://"
    case videos = "videos://"
    case qq = "mqq://"
    case wechat = "weixin://"
    case taobao = "taobao://"
    case zhifubao = "alipay://"
    case weibo = "sinaweibo://"
    case zhihu = "zhihu://"
}

func openSystem(_ systemsetting:System) {
    //三种方式
    //1 prefs:root=某项服务
    //2 prefs:root=bundldID
    //3 UIApplicationOpenSettingsURLString
    
    let sharedApplication = UIApplication.shared
    if let url = URL(string: systemsetting.rawValue),
        sharedApplication.canOpenURL(url) {
        if #available(iOS 10.0, *) {
            sharedApplication.open(url, options: [:], completionHandler: { (complete) in
                
            });
        }else{
            sharedApplication.openURL(url)
        }
    }
}

//
//  InternationalManager.swift
//  MySwiftTemplate
//
//  Created by apple on 25/10/2017.
//  Copyright © 2017 apple. All rights reserved.

import UIKit
private let UserLanguageKey = "currentUsedLanguage"

class InternationalController {
    static let sharedInstance = InternationalController()
    private init(){
        initUserLanguage()
    }
    
    private let userDefault = UserDefaults.standard
    var bundle: Bundle!
    
    func initUserLanguage(){
        
        var language = "zh-Hans"
        
        if let str = userDefault.string(forKey: UserLanguageKey) {
            language = str
        }
        else {
            let syslan = Locale.preferredLanguages[0]
            
            if syslan.contains("en-US"){
                language = "en"
            }
            else if syslan.contains("zh-Hans"){
                language = "zh-Hans"
            }
        }
        setUserLanguage(language: language)
    }
    
    func setUserLanguage(language: String){
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            return
        }
        self.bundle = Bundle(path: path)//生成bundle
        //2.持久化
        userDefault.set(language, forKey: UserLanguageKey)
        userDefault.synchronize()
    }
}

extension String{
    func internation(key: String) -> String{
        let str = InternationalController.sharedInstance.bundle.localizedString(forKey: key, value: self, table: "Language")
        return str
    }
}

//
//  BaseViewController.swift
//  swiftProjTemplate
//
//  Created by apple on 8/8/16.
//  Copyright © 2016 oracleen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let boxView = UIView()
    
    //MARK: VC LifeCycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0,*) {
            self.navigationItem.largeTitleDisplayMode = .never
            viewRespectsSystemMinimumLayoutMargins = true
            //            self.tabBarItem.largeContentSizeImage = nil
            //            self.navigationBar.prefersLargeTitles = false
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        if self.tabBarController != nil {
            self.tabBarItem.landscapeImagePhone = nil
        }
        
        boxView.backgroundColor = CommonViewBgColor
        boxView.frame = view.bounds
        view.addSubview(boxView)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: Keyboard show&hide Notifications
    @objc func keyboardWillShow(_ notify:Notification) {
        
    }
    
    @objc func keyboardWillHide(_ notify:Notification) {
        
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //是否依据设备的最小的margins,默认的是true
    @available(iOS 11.0, *)
    func respectSystemMinimumMargins(_ respect:Bool) {
        self.viewRespectsSystemMinimumLayoutMargins = respect
    }
    
    //隐藏左边的navigationItem
    func hideleftBarButtonItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
    }
    
    // MARK:状态栏左上角的网络请求小圈圈
    func showStatusNetworkIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideStatusNetworkIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: dealloc
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("dealloc execute \(self)")
    }
    // MARK: X系列底部home条
    @available(iOS 11.0, *)
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    @available(iOS 11.0, *)
    override var childForHomeIndicatorAutoHidden: UIViewController? {
        return nil
    }
    // MARK: 状态栏样式、隐藏与动画
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    // MARK: 状态栏控制
    override var childForStatusBarStyle: UIViewController? {
        return nil
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return nil
    }
    // MARK: 状态栏旋转
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

extension BaseViewController : UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            guard let viewControllers = self.navigationController?.viewControllers else {
                return false
            }
            if viewControllers.count > 1 {
                return true
            }
            else {
                return false
            }
        }
        return true
    }
}

//MARK: once Swizzling
extension BaseViewController : SelfAware {
    public static func awake() {
        let orgViewWillAppear = #selector(viewWillAppear(_:))
        let swizzViewWillAppear = #selector(zk_viewWillAppear(_:))
        swizzleMethod(self,
                      originalSelector: orgViewWillAppear,
                      swizzledSelector: swizzViewWillAppear)
        
        let orgViewWillDisappear = #selector(viewWillDisappear(_:))
        let swizzViewWillDisappear = #selector(zk_viewWillDisappear(_:))
        swizzleMethod(self,
                      originalSelector: orgViewWillDisappear,
                      swizzledSelector: swizzViewWillDisappear)
    }
    
    @objc public func zk_viewWillAppear(_ animated: Bool) {
        self.zk_viewWillAppear(animated)
        PathTrackController.sharedInstance.trackVC(vc: self, enter: true)
    }
    
    @objc public func zk_viewWillDisappear(_ animated: Bool) {
        self.zk_viewWillDisappear(animated)
        PathTrackController.sharedInstance.trackVC(vc: self, enter: false)
    }
    
    //    override open func responds(to aSelector: Selector!) -> Bool{
    //        debugPrint(aSelector)
    //        return super.responds(to: aSelector)
    //    }
}

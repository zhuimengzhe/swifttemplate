//
//  BaseViewController.swift
//  swiftProjTemplate
//
//  Created by apple on 8/8/16.
//  Copyright © 2016 oracleen. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.whiteColor()
        
        edgesForExtendedLayout = UIRectEdge.None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    func keyboardWillShow(notify:NSNotification) {
        
    }
    
    func keyboardWillHide(notify:NSNotification) {
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

//
//  BatchCommand.swift
//  MySwiftTemplate
//
//  Created by apple on 22/12/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
//批量请求
class BatchCommand {
    //批量请求
    public func batchRequest(_ requests:(()->()),complete:(()->())?) {
        let batchGroup = DispatchGroup()
        requests()
        batchGroup.notify(queue: DispatchQueue.main, execute: {
            [unowned self] in
            //将group置为nil
            //self.batchGroup = nil
            complete?()
        })
        do {
            
        }
    }
}

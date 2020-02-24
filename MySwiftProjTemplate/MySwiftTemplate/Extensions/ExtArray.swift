//
//  ExtArray.swift
//  MySwiftTemplate
//
//  Created by apple on 20/7/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
//MARK:扩展Array
extension Array {
    func accumulate<U>(initial:U,combine:(U,Element) -> U) -> [U] {
        var running = initial
        return self.map{
            next in
            running = combine(running,next)
            return running
        }
    }
    
    func reduce<U>(initial: U, combine: (U, Element) -> U) -> U {
        var result = initial
        for x in self {
            result = combine(result,x) }
        return result
    }
    //使用reduce实现map和filter
    //    func map2<U>(transform: (Element) -> U) -> [U] {
    //        return reduce([]) {
    //            $0 + [transform($1)]
    //        }
    //    }
    //    func  filter2 (includeElement: (Element) -> Bool) -> [Element] {
    //        return reduce([]) {
    //            includeElement($1) ? $0 + [$1] : $0
    //        }
    //    }
    
    mutating func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
    
    mutating func removeAtIndexes (ixs:[Int]) -> () {
        //for i in ixs.sorted().reversed()
        for i in ixs.sorted(by:>) {
            self.remove(at:i)
        }
    }
}

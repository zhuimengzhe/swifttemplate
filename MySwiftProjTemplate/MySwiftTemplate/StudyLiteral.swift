//
//  StudyLiteral.swift
//  MySwiftTemplate
//
//  Created by apple on 25/6/2019.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
enum MyBool: Int {
    case myTrue, myFalse
}

extension MyBool: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        self = value ? .myTrue : .myFalse
    }
}

//不能在extention中书写required初始化方法
class Person: ExpressibleByStringLiteral {
    let name: String
    init(name value:String) {
        self.name = value
    }
    required init(stringLiteral value: String) {
        self.name = value
    }
    required init(unicodeScalarLiteral value: String) {
        self.name = value
    }
    required init(extendedGraphemeClusterLiteral value: String) {
        self.name = value
    }
}

extension Array {
    subscript(input:[Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count,"Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index, i) in input.enumerated() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        let matches = regex.matches(in: input,
                                    options: [],
                                    range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}
precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}
infix operator =~: MatchPrecedence
func =~(lhs:String,rhs:String) -> Bool {
    do {
        return try RegexHelper(lhs).match(rhs)
    }
    catch _ {
        return false
    }
}
//因为Swift switch使用的是~=匹配,这里做一个重载扩展switch
func ~=(pattern:NSRegularExpression,input:String) -> Bool {
    return pattern.numberOfMatches(in: input,
                                   options: [],
                                   range: NSRange.init(location: 0, length: input.count)) > 0
}
// 将string置为nsexpression
//prefix operator ~/
//prefix func ~/(pattern: String) -> NSRegularExpression {
//    return NSRegularExpression.init(pattern: pattern, options: [])
//}

struct Person2 {
    let name: String
    let age: Int
}

func swap<T>(a:inout T,b: inout T) {
    (a, b) = (b, a)
}

// 单项链表 
indirect enum LinkedList<Element: Comparable> {
    case empty
    case node(Element, LinkedList<Element>)
    
    func removing(_ element: Element) -> LinkedList<Element> {
        // 内部有递归实现
        guard case let .node(value, next) = self else {
            return .empty
        }
        return value == element ? next : LinkedList.node(value, next.removing(element))
    }
}

func synchronized(_ lock:AnyObject,closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

func random(in range:Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return Int(Int(arc4random_uniform(count)) + range.startIndex)
}

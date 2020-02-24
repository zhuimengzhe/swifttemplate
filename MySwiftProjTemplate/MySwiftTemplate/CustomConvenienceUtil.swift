//
//  CustomConvenienceUtil.swift
//  MySwiftTemplate
//
//  Created by apple on 24/6/2019.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
// MARK: Target-Action
protocol TargetAction {
    func performAction()
}
// Target-Action封装
struct TargetActionWrapper<T: AnyObject> : TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    func performAction() -> () {
        if let t = target {
            action(t)()
        }
    }
}
// 事件名称
enum ControlEvent {
    case TouchUpInside
    case ValueChanged
}

class Control {
    var actions = [ControlEvent:TargetAction]()
    func setTarget<T: AnyObject>(target: T,
                                 action: @escaping (T) -> () -> (),
                                 controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target,
                                                    action: action)
    }
    //移除controlevent的所有target
    func removeTargetForControlEvent(controlEvent:ControlEvent) {
        actions[controlEvent] = nil
    }
    //执行事件的action
    func performActionForControlEvent(controlEvent:ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}

// MARK:Reversed Sequence
// 先定义一个实现了IteratorProtocol协议的类型
//IteratorProtocol需要制定一个typealias Element
// 以及提供一个返回Element?的方法next()
class ReversedIterator<T>: IteratorProtocol {
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> T? {
        if currentIndex < 0 {
            return nil
        }
        else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

struct ReverseSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    typealias Iterator = ReversedIterator<T>
    func makeIterator() -> ReversedIterator<T> {
        return ReversedIterator(array: self.array)
    }
}


////
////  SecondViewController.swift
////  MySwiftTemplate
////
////  Created by apple on 29/9/2017.
////  Copyright © 2017 apple. All rights reserved.
////
//
import UIKit
import Combine

typealias MyByte = Int8

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

struct Vector2D1 {
    var x = 0.0
    var y = 0.0
}

enum MyEnum : String {
    case one = "aa"
    case two = "two"
}

func +(left: Vector2D, right:Vector2D) -> Vector2D {
    return Vector2D.init(x: left.x + right.x, y: left.y + right.y)
}
// 自定义运算符
precedencegroup DotProductPrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}

infix operator +*
func +*(left:Vector2D, right:Vector2D) -> Double {
    return left.x * right.x + left.y * right.y
}

class SecondViewController: BaseViewController {
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        testCGAffine()
        
        let i: Int = 3
        
//       [1,2,3,4,5].publisher.sink(
//            receiveCompletion: { completion in
//                print("Completion: \(completion)")
//            },
//            receiveValue: { value in
//                print("Receive value: \(value)")
//            }
//        )
        let publisher = [1,2,3,4,5].publisher
        let subscriber = Subscribers.Sink<Int, Never>(
            receiveCompletion: { completion in
                print("Completion: \(completion)")
            },
            receiveValue: { value in
                print("Receive value: \(value)")
            }
        )

        publisher.subscribe(subscriber)
    }
    
    // 可变参数
    @discardableResult
    private func mulParamter(a: Int...) -> (String, Int,String) {
        print(type(of: a))
        return ("",0,"")
    }
    
    @discardableResult
    private func mulParamter(a: [Int]) -> (String, Int) {
        print(type(of: a))
        return ("",0)
    }
    
    func testCupleFunc(a:(Int, String),b:Int) {
        print(a.0,a.1,b)
    }
    
    private func testCGAffine() {
        
    }
}


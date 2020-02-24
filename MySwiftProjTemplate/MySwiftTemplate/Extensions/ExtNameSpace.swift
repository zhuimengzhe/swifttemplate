//
//  ExtNameSpace.swift
//  MySwiftTemplate
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//
// 代表了支持 namespace 形式的扩展
public protocol NamespaceWrappable {
    associatedtype WrapperType
    var hk: WrapperType { get }
    static var hk: WrapperType.Type { get }
}

// 给这个协议 extension 了默认实现。这样实现了这个协议的类型就不需要自行实现协议所约定的内容了
public extension NamespaceWrappable {
    var hk: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }

    static var hk: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

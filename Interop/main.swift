//
//  main.swift
//  Interop
//
//  Created by Victor on 26/7/19.
//  Copyright © 2019 Victor. All rights reserved.
//

import Foundation

protocol CCode
{
    associatedtype Item
    init()
    static func alloc() -> Item
    mutating func dealloc()
}

class Wrapper<T:CCode>
{
    var Ref = T()
    
    init()
    {
        Ref = T.alloc() as! T
    }
    
    deinit
    {
        Ref.dealloc()
    }
}

extension EngineContext : CCode
{
    
    
}

func castToVoid(_ object: AnyObject) -> UnsafeMutableRawPointer
{
    return UnsafeMutableRawPointer(Unmanaged.passUnretained(object).toOpaque())
}

func castFromVoid<T:AnyObject>(_ ptr: UnsafeMutableRawPointer?) -> T
{
    return Unmanaged<T>.fromOpaque(ptr!).takeUnretainedValue()
}

class CallbackSite
{
    func onResult(_ f: Float)
    {
        print("swift callback with data: \(f)")
    }
}

func Execute()
{
    let cbSite = CallbackSite();
    var context : EngineContext = EngineContext.alloc()
    
    context.setOperationHandler { (f: Float) in
        print("swift callback: \(f)")
    }
    
    context.setOperationHandlerWithData(h: { (f: Float, ptr) in
        let data : CallbackSite = castFromVoid(ptr)
        data.onResult(f)
    }, data: castToVoid(cbSite))
    
    context.operation(f: 9.0)
    context.dealloc()
    
    let wrapped = Wrapper<EngineContext>()
    wrapped.Ref.operation(f:10.0)
    
    let opts : EngineOptions = [.Option1, .Option2]
    print("Options: \(opts.rawValue)")
    
    print("Done!")
}

Execute()

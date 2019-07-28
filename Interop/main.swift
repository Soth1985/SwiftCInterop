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
    func dealloc()
}

class Wrapper<T:CCode>
{
    var Ref = T()
    
    init()
    {
        Ref = T.alloc() as! T;
    }
    
    deinit
    {
        Ref.dealloc()
    }
}

extension EngineContext : CCode
{
    
}

func Execute()
{
    let context : EngineContext = EngineContext.alloc()
    context.operation(f: 1.0)
    
    let context2 = EngineContext(v: .Version1)
    context2.operation(f: 1.0)
    
    context.dealloc()
    context2.dealloc()
    
    let wrapped = Wrapper<EngineContext>()
    wrapped.Ref.operation(f:0.0)
}

Execute()

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

//func FromC(

func Execute()
{
    var context : EngineContext = EngineContext.alloc()
    var temp : Int = 10
    context.setOperationHandler { (f: Float) in
        print("cb: \(f)")
    }
    context.operation(f: 1.0)
    context.dealloc()
    
    let wrapped = Wrapper<EngineContext>()
    wrapped.Ref.operation(f:10.0)
    
    print("Done!")
}

Execute()

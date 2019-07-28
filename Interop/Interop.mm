//
//  Interop.cpp
//  Interop
//
//  Created by Victor on 26/7/19.
//  Copyright © 2019 Victor. All rights reserved.
//

#include "Interop.hpp"

struct EngineContextData
{
    float i;
};


void EngineContextOperation(EngineContext ctx, float f)
{
    ctx.Impl->i = f;
}

EngineContext EngineContextCreateContext()
{
    EngineContext Result;
    Result.Impl = new EngineContextData();
    Result.Impl->i = 0.0f;
    return Result;
}

EngineContext EngineContextCreateContext2(EngineVersion v)
{
    return EngineContextCreateContext();
}

void EngineContextDestroyContext(EngineContext ctx)
{
    delete ctx.Impl;
}

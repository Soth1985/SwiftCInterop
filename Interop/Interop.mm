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
    EngineContextOperationHandler h;
};


void EngineContextOperation(EngineContext* ctx, float f)
{
    ctx->Impl->i = f;
    
    if (ctx->Impl->h)
        ctx->Impl->h(f);
}

EngineContext EngineContextCreateContext()
{
    EngineContext Result;
    Result.Impl = new EngineContextData();
    Result.Impl->i = 0.0f;
    Result.Impl->h = nullptr;
    return Result;
}

void EngineContextDestroyContext(EngineContext* ctx)
{
    if (ctx->Impl)
    {
        delete ctx->Impl;
        ctx->Impl = nullptr;
    }
}

void EngineContextSetOperationHandler(EngineContext* ctx, EngineContextOperationHandler h)
{
    ctx->Impl->h = h;
}

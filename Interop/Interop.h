//
//  Interop.h
//  Interop
//
//  Created by Victor on 26/7/19.
//  Copyright © 2019 Victor. All rights reserved.
//

#ifndef Interop_h
#define Interop_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, EngineVersion){
    Version1,
    Version2
};

struct EngineContext
{
    struct EngineContextData* Impl;
};

typedef struct EngineContext EngineContext;
typedef void (*EngineContextOperationHandler)(float f);
typedef void (*EngineContextOperationHandlerWithData)(float f, void* data);

EngineContext EngineContextCreateContext(void)CF_SWIFT_NAME(EngineContext.alloc());
void EngineContextDestroyContext(EngineContext* ctx)CF_SWIFT_NAME(EngineContext.dealloc(self:));
void EngineContextOperation(EngineContext* ctx, float f) CF_SWIFT_NAME(EngineContext.operation(self:f:));
void EngineContextSetOperationHandler(EngineContext* ctx, EngineContextOperationHandler h) CF_SWIFT_NAME(EngineContext.setOperationHandler(self:h:));
void EngineContextSetOperationHandlerWithData(EngineContext* ctx, EngineContextOperationHandlerWithData h, void* data) CF_SWIFT_NAME(EngineContext.setOperationHandlerWithData(self:h:data:));

#endif /* Interop_h */

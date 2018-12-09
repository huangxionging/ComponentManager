//
//  CMDispatchManager.m
//  32TeethDoc
//
//  Created by huangxiong on 2017/5/2.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import "CMDispatchManager.h"

@implementation CMDispatchManager
+ (instancetype)shareManager {
    static CMDispatchManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (void) dispatchTarget:(id)target method:(NSString *)method, ... {
    
    // 方法
    SEL selector = NSSelectorFromString(method);
    
    if (![target respondsToSelector: selector]) {
        
        NSLog(@"target :%@ 不能响应方法: %@", target, method);
//        return;
        //        NSAssert(0, @"目标不能响应方法");
    }
    
    // 生成签名
    NSMethodSignature *methodSignature = [target methodSignatureForSelector: selector];
    // 生成调用器
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置调用目标
    [invocation setTarget: target];
    // 设置方法
    [invocation setSelector: selector];
    
    // 可变指针
    va_list ap;
    va_start(ap, method);
    
    // 循环获取参数
    id object = nil;
    NSInteger index = 2;
    while ((object = va_arg(ap, id))) {
        // 配置参数
        [invocation setArgument: &object atIndex: index++];
    }
    // 结束
    va_end(ap);
    
    // 保持参数
    [invocation retainArguments];
    // 调用 执行方法, 无返回值
    [invocation invoke];
}

- (id)dispatchReturnValueTarget:(id)target method:(NSString *)method, ... {
    
    // 方法
    SEL selector = NSSelectorFromString(method);
    
    if (![target respondsToSelector: selector]) {
        
        NSLog(@"target :%@ 不能响应方法: %@", target, method);
        return nil;
        //        NSAssert(0, @"目标不能响应方法");
    }
    
    // 生成签名
    NSMethodSignature *methodSignature = [target methodSignatureForSelector: selector];
    // 生成调用器
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置调用目标
    [invocation setTarget: target];
    // 设置方法
    [invocation setSelector: selector];
    
    // 可变指针
    va_list ap;
    va_start(ap, method);
    
    // 循环获取参数
    id object = nil;
    NSInteger index = 2;
    while ((object = va_arg(ap, id))) {
        // 配置参数
        [invocation setArgument: &object atIndex: index++];
    }
    // 结束
    va_end(ap);
    
    // 保持参数
    [invocation retainArguments];
    // 调用
    [invocation invoke];
    // 这里只能写 void *
    void *result = nil;
    if (methodSignature.methodReturnLength != 0) {
        // 获得返回值
        [invocation getReturnValue:&result];
    }
    // 转换
    return (__bridge id)(result);
}

- (NSInteger)dispatchReturnIntegerTarget:(id)target method:(NSString *)method, ... {
    // 方法
    SEL selector = NSSelectorFromString(method);

    if (![target respondsToSelector: selector]) {

        NSLog(@"target :%@ 不能响应方法: %@", target, method);
        return NSNotFound;
        //        NSAssert(0, @"目标不能响应方法");
    }

    // 生成签名
    NSMethodSignature *methodSignature = [target methodSignatureForSelector: selector];
    // 生成调用器
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置调用目标
    [invocation setTarget: target];
    // 设置方法
    [invocation setSelector: selector];

    // 可变指针
    va_list ap;
    va_start(ap, method);

    // 循环获取参数
    id object = nil;
    NSInteger index = 2;
    while ((object = va_arg(ap, id))) {
        // 配置参数
        [invocation setArgument: &object atIndex: index++];
    }
    // 结束
    va_end(ap);

    // 保持参数
    [invocation retainArguments];
    // 调用
    [invocation invoke];
    // 这里只能写 void *
    NSInteger integer = NSNotFound;
    if (methodSignature.methodReturnLength != 0) {
        // 获得返回值
        [invocation getReturnValue:&integer];
    }
    // 转换
    return integer;
}
- (BOOL)dispatchReturnBoolTarget:(id)target method:(NSString *)method, ... {
    // 方法
    SEL selector = NSSelectorFromString(method);

    if (![target respondsToSelector: selector]) {

        NSLog(@"target :%@ 不能响应方法: %@", target, method);
        return NSNotFound;
        //        NSAssert(0, @"目标不能响应方法");
    }

    // 生成签名
    NSMethodSignature *methodSignature = [target methodSignatureForSelector: selector];
    // 生成调用器
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置调用目标
    [invocation setTarget: target];
    // 设置方法
    [invocation setSelector: selector];

    // 可变指针
    va_list ap;
    va_start(ap, method);

    // 循环获取参数
    id object = nil;
    NSInteger index = 2;
    while ((object = va_arg(ap, id))) {
        // 配置参数
        [invocation setArgument: &object atIndex: index++];
    }
    // 结束
    va_end(ap);

    // 保持参数
    [invocation retainArguments];
    // 调用
    [invocation invoke];
    // 这里只能写 void *
    BOOL boolValue = NO;
    if (methodSignature.methodReturnLength != 0) {
        // 获得返回值
        [invocation getReturnValue:&boolValue];
    }
    // 转换
    return boolValue;
}
@end

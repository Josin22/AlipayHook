//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  AlipayDylib.m
//  AlipayDylib
//
//  Created by baoshg on 2018/2/11.
//  Copyright (c) 2018年 baoshg. All rights reserved.
//

#import "AlipayDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>

static __attribute__((constructor)) void entry(){
    NSLog(@"\n               🎉!!！congratulations!!！🎉\n👍----------------insert dylib success----------------👍");
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);
#endif
        
    }];
}

@interface CustomViewController

-(NSString*)getMyName;

@end

CHDeclareClass(CustomViewController)

CHOptimizedMethod(0, self, NSString*, CustomViewController,getMyName){
    //get origin value
    NSString* originName = CHSuper(0, CustomViewController, getMyName);
    
    NSLog(@"origin name is:%@",originName);
    
    //get property
    NSString* password = CHIvar(self,_password,__strong NSString*);
    
    NSLog(@"password is %@",password);
    
    //change the value
    return @"AloneMonkey";
    
    
}

CHConstructor{
    CHLoadLateClass(CustomViewController);
    CHClassHook(0, CustomViewController, getMyName);
}


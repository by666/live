//
//  Singleton.h
//  CoreLibrary
//
//  Created by mark.zhang on 2/26/16.
//  Copyright © 2016 ids. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

// MARK: 声明单例.

#define SINGLETON_DECLARATION(name) \
+ (name *)shared##name;

#define SINGLETON_DECLARATION_N(name) \
+ (instancetype)shared##name;

#define SINGLETON_DECLARATION_DEFAULT(name) \
+ (instancetype)default##name;

// MARK: 实现单例.
 
#define SINGLETON_IMPLEMENTION(name) \
+ (name *)shared##name { \
static name *_shared##name = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_shared##name = [[name alloc] init]; \
}); \
return _shared##name; \
}

#define SINGLETON_IMPLEMENTION_N(name) \
+ (instancetype)shared##name { \
static id _instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#define SINGLETON_IMPLEMENTION_DEFAULT(name) \
+ (instancetype)default##name { \
static id _instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#endif /* Singleton_h */

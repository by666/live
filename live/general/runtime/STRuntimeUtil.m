//
//  STRuntimeUtil.m
//  framework
//
//  Created by 黄成实 on 2018/4/18.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "STRuntimeUtil.h"
#import <objc/runtime.h>

@implementation STRuntimeUtil

+(NSArray *)getAllPropertyNames:(id)tempClass{
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([tempClass class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys);
    return allNames;
}


+(NSArray *)getAllMethodNames:(id)tempClass{
    NSMutableArray *allMethods = [[NSMutableArray alloc] init];
    unsigned int count;
    Method *methods = class_copyMethodList([tempClass class], &count);
    for (int i = 0; i < count; i++){
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        if(![name isEqualToString:@".cxx_destruct"]){
            [allMethods addObject:name];
        }
    }
    return allMethods;
}


+(id)getPropertyValue:(id)tempClass key:(NSString *)key{
    return [tempClass valueForKey:key];

}

@end

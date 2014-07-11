//
//  JSONModel.m
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 5/28/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "JSONModel.h"

@implementation JSONModel

-(instancetype)init{

    if (self = [super init]) {
        return  self;
    }
    else return nil;
}

-(instancetype)initWithDictionary:(NSMutableDictionary *)jsonObject{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:jsonObject];
    }
    return self;

    
}

@end

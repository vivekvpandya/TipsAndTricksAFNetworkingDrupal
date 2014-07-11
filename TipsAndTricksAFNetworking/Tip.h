//
//  Tip.h
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 6/22/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "JSONModel.h"

@interface Tip : JSONModel

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *tag;
@property (nonatomic,strong) NSString *changed;
@property (nonatomic,strong) NSNumber *uid;
@property (nonatomic,strong) NSNumber *nid;





@end

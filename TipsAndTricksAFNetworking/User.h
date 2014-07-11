//
//  User.h
//  LoginWithKeyChain
//
//  Created by Vivek Pandya on 5/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface User : JSONModel
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray *roles;
@property (nonatomic,strong) NSString *basicAuthString;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *email;


-(void)fillUserWithUserJSONObject:(NSDictionary *)UserJSONObject;
-(void)clearUserDetails;
//-(BOOL)performLoginWithBasicAuthString:(NSString *)basicAuthString;


+(User *)sharedInstance;


@end

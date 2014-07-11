//
//  TipsandTricks.h
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 5/3/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

/*
 
 This class provides class methods to create NSURL for the site created with Drupal to which the application will connect.
 It will also contain authorization related stuffs.
 
 
 */

#import <Foundation/Foundation.h>

@interface TipsandTricks : NSObject


// URL helper methods

+(NSURL *)baseURL;
+(NSURL *)createURLForPath:(NSString *)path;
+(NSURL *)createURLForNodeID:(NSString *)nid;
+(NSString *)basicAuthStringforUsername:(NSString *)username Password:(NSString *)password;

// login helper method 
+(void)performLoginWithUsername:(NSString *)username andPassword:(NSString *)password;



@end

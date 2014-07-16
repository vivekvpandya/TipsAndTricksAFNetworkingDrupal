//
//  Drupal8RESTSessionManager.h
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Drupal8RESTSessionManager : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager; // a session manager object that will be shred among all the REST operation.


-(void)clearAuthorizationHeader;
-(void)setValue:(NSString *) forHTTPAuthorizationHeader;

-(NSURLSessionDataTask *)POSTNode:(NSString *)url
                       bundleType:(NSString *)bundleType
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
-(NSURLSessionDataTask *)PATCHNode:(NSString *)url
                        bundleType:(NSString *)bundleType
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)POSTUser:(NSString *)url
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
-(NSURLSessionDataTask *)PATCHUser:(NSString *)url
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;





@end

//
//  Drupal8RESTSessionManager.h
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.
//  
//

#import <Foundation/Foundation.h>

@interface Drupal8RESTSessionManager : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager; // a session manager object that will be shred among all the REST operation.

#pragma configuration methods for SessionManagerObject
-(void)clearAuthorizationHeader;
-(void)setValue:(NSString *)value forHTTPRequestHeader:(NSString *)header;


#pragma  CRUD for node
-(NSURLSessionDataTask *)GETNode:(NSString *)url
                            nodeId:(NSString *)nid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)POSTNode:(NSString *)url
                       bundleType:(NSString *)bundleType
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)PATCHNode:(NSString *)url
                        bundleType:(NSString *)bundleType
                            nodeId:(NSString *)nid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)DELETENode:(NSString *)url
                            nodeId:(NSString *)nid
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


#pragma  CRUD for user

-(NSURLSessionDataTask *)GETUser:(NSString *)url
                            userId:(NSString *)uid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)POSTUser:(NSString *)url
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)PATCHUser:(NSString *)url
                            userId:(NSString *)uid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(NSURLSessionDataTask *)DELETEUser:(NSString *)url
                            userId:(NSString *)uid
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


#pragma GET method for view

-(NSURLSessionDataTask *)GetView:(NSString *)url
                        viewName:(NSString *)viewName
                      parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end

//
//  Drupal8RESTSessionManager.m
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.
//  
//

#import "Drupal8RESTSessionManager.h"

@implementation Drupal8RESTSessionManager


-(AFHTTPSessionManager *)sessionManager{
    
    if (!_sessionManager ) {
        _sessionManager = [AFHTTPSessionManager manager];// A singleton AFHTTPSessionManager object will be returned.
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/hal+json"];
        
    }
    
 
    
    return _sessionManager;

}

#pragma mark configuration methods implementation for SessionManagerObject

-(void)setValue:(NSString *)value forHTTPRequestHeader:(NSString *)header{

    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:header];
    
}

-(void)clearAuthorizationHeader{
    
    [self.sessionManager.requestSerializer clearAuthorizationHeader];

}

#pragma mark CRUD methods for  Entity - implementation

-(NSURLSessionDataTask *)POSTEntity:(NSString *)url
                         parameters:(id)parameters
                            success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{


    NSURLSessionDataTask *postEntityTask = [self.sessionManager POST:url
                                                          parameters:parameters
                                                             success:success
                                                             failure:failure];
    
    return postEntityTask;
    
    
}



-(NSURLSessionDataTask *)GETEntity:(NSString *)url
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                           failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{
    
    NSURLSessionDataTask *getEntityTask = [self.sessionManager GET:url
                                                        parameters:parameters
                                                           success:success
                                                           failure:failure];
    return getEntityTask;
    
}


-(NSURLSessionDataTask *)PATCHEntity:(NSString *)url
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                             failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{
    
    NSURLSessionDataTask *patchEntityTask = [self.sessionManager PATCH:url
                                                            parameters:parameters
                                                               success:success
                                                               failure:failure];
    return patchEntityTask;
}


-(NSURLSessionDataTask *)DELETEEntity:(NSString *)url
                           parameters:(id)parameters
                              success:(void (^)(NSURLSessionDataTask *,id resopnseObject))success
                              failure:(void (^)(NSURLSessionDataTask *, NSError *error))failure{
    
    NSURLSessionDataTask *deleteEntityTask = [self.sessionManager DELETE:url
                                                              parameters:parameters
                                                                 success:success
                                                                 failure:failure];
    return deleteEntityTask;
    
}


#pragma mark CRUD methods for node - implementation


-(NSURLSessionDataTask *)POSTNode:(NSString *)url
                       bundleType:(NSString *)bundleType
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    

    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
  
    
    NSString *nodeRESTEndpointURL = [NSString stringWithFormat:@"%@/entity/node",url];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/node/%@",url,bundleType];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *postNodeTask = [self POSTEntity:nodeRESTEndpointURL
                                               parameters:requestBody
                                                  success:success
                                                  failure:failure];
    return postNodeTask;
}

-(NSURLSessionDataTask *)DELETENode:(NSString *)url
                             nodeId:(NSString *)nid
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    NSString *deleteRESTEndpointURL = [NSString stringWithFormat:@"%@/node/%@",url,nid];
    NSURLSessionDataTask *deleteNodeTask = [self DELETEEntity:deleteRESTEndpointURL
                                                   parameters:nil
                                                      success:success
                                                      failure:failure];
    return deleteNodeTask;
    

}

-(NSURLSessionDataTask *)GETNode:(NSString *)url
                          nodeId:(NSString *)nid
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    
    
     NSString *getRESTEndpointURL = [NSString stringWithFormat:@"%@/node/%@",url,nid];
  
    
    NSURLSessionDataTask *getNodeTask = [self GETEntity:getRESTEndpointURL parameters:nil success:success failure:failure];
    
    return getNodeTask;


}

-(NSURLSessionDataTask *)PATCHNode:(NSString *)url
                        bundleType:(NSString *)bundleType
                            nodeId:(NSString *)nid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *, id))success
                           failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *nodeRESTEndpointURL = [NSString stringWithFormat:@"%@/node/%@",url,nid];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/node/%@",url,bundleType];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *patchNodeTask = [self PATCHEntity:nodeRESTEndpointURL
                                               parameters:requestBody
                                                  success:success
                                                  failure:failure];
    return patchNodeTask;

    

}

#pragma mark GET method for View - implementation

-(NSURLSessionDataTask *)GetView:(NSString *)url
                        viewName:(NSString *)viewName
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    
    
    NSString *viewURL = [NSString stringWithFormat:@"%@/%@",url,viewName];
  
    NSURLSessionDataTask *getViewDataTask = [self.sessionManager GET:viewURL
                                                          parameters:parameters
                                                             success:success failure:failure];
    
    return getViewDataTask;
    


}

#pragma mark CRUD methods for User - implementation

-(NSURLSessionDataTask *)GETUser:(NSString *)url
                          userId:(NSString *)uid
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSString *getRESTEndpointURL = [NSString stringWithFormat:@"%@/user/%@",url,uid];
    
    
    NSURLSessionDataTask *getUserTask = [self GETEntity:getRESTEndpointURL
                                             parameters:nil
                                                success:success
                                                failure:failure];
    
    return getUserTask;


}

-(NSURLSessionDataTask *)DELETEUser:(NSString *)url
                             userId:(NSString *)uid
                            success:(void (^)(NSURLSessionDataTask *, id))success
                            failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSString *deleteRESTEndpointURL = [NSString stringWithFormat:@"%@/user/%@",url,uid];
    NSURLSessionDataTask *deleteUserTask =[self DELETEEntity:deleteRESTEndpointURL
                                                   parameters:nil
                                                      success:success
                                                      failure:failure];
    return deleteUserTask;
    
}

-(NSURLSessionDataTask *)POSTUser:(NSString *)url
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *, id))success
                          failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *userRESTEndpointURL = [NSString stringWithFormat:@"%@/entity/user",url];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/user/user",url];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *postUserTask = [self POSTEntity:userRESTEndpointURL
                                               parameters:requestBody
                                                  success:success
                                                  failure:failure];
    return postUserTask;


}

-(NSURLSessionDataTask *)PATCHUser:(NSString *)url
                            userId:(NSString *)uid
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *, id))success
                           failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    [self setValue:@"application/hal+json" forHTTPRequestHeader:@"Content-Type"];
    
    
    NSString *userRESTEndpointURL = [NSString stringWithFormat:@"%@/user/%@",url,uid];
    
    NSString *linkType = [NSString stringWithFormat:@"%@/rest/type/user/user",url];
    
    
    NSMutableDictionary *requestBody = [(NSDictionary *)parameters mutableCopy];
    
    [requestBody addEntriesFromDictionary:@{@"_links":@{@"type":@{@"href":linkType}}}];
    
    
    
    NSURLSessionDataTask *patchUserTask = [self PATCHEntity:userRESTEndpointURL
                                                 parameters:requestBody
                                                    success:success
                                                    failure:failure];
    return patchUserTask;
    


}

@end

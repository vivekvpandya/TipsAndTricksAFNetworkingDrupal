//
//  Drupal8RESTSessionManager.m
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "Drupal8RESTSessionManager.h"

@implementation Drupal8RESTSessionManager


-(AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager ) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;

}

-(NSURLSessionDataTask *)POSTNode:(NSString *)url bundleType:(NSString *)bundleType parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    NSString *linkTypeHref = [NSString stringWithFormat:@"%@/rest/type/node/%@",url,bundleType];
    NSDictionary *linkTypeDictionary = @{@"_links": @{@"type":@{@"href":linkTypeHref}}};
    
    
    NSMutableDictionary *nodeDictionary = [(NSDictionary *)parameters mutableCopy];
    [nodeDictionary addEntriesFromDictionary:linkTypeDictionary];
    
    /* code given above should create a dictionary object as shown below
     * here all node related values like title, format,uid should be provided by calling method
     
     NSDictionary *nodeDictionary = @{@"_links": @{@"type":@{@"href":@"http://tntfoss-vivekvpandya.rhcloud.com/rest/type/node/tip" }},@"uid":@[@{@"target_id":user.uid} ],@"field_tag":@[@{@"target_id":tagID}],@"body":@[@{@"value":[self.bodyTextView.textStorage mutableString],@"format":@"full_html"}],@"title":@[@{@"value":self.tipTitle.text}]};
    */
    NSLog(@"%@",nodeDictionary);

    return nil;
}

@end

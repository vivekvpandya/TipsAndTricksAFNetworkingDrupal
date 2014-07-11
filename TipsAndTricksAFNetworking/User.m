//
//  User.m
//  LoginWithKeyChain
//
//  Created by Vivek Pandya on 5/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "User.h"
#import "TipsandTricks.h" // this was added to support performLogin method


@interface User()

@property(nonatomic,strong) NSURLSession *sessoin;



@end

@implementation User

static User *sharedDataInstance = nil;
+(User *)sharedInstance{

    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
    
        sharedDataInstance = [[User alloc]init];
        [sharedDataInstance clearUserDetails];
    
    });
    
    return sharedDataInstance;


}

-(void)clearUserDetails{

    self.name = nil;
    self.roles = nil;
    self.basicAuthString = nil;
    self.email = nil;
    self.uid = nil;
    

}

-(void)fillUserWithUserJSONObject:(NSDictionary *)UserJSONObject{


  /*  self.name = [UserJSONObject objectForKey:@"name"];
    self.roles = [UserJSONObject objectForKey:@"roles"];
    self.basicAuthString = [UserJSONObject objectForKey:@"basicAuthString"];
    self.uid = [UserJSONObject objectForKey:@"uid"];
    
    */
    [self setValuesForKeysWithDictionary:UserJSONObject];
    NSLog(@"initialized");
    

}

/*-(BOOL)performLoginWithBasicAuthString:(NSString *)basicAuthString{
    
    __block BOOL flag = NO;
    
   
    
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    
    dispatch_async(queue, ^{
        
        
        

        NSURL *loginRequestURL = [TipsandTricks createURLForPath:@"user/verify"];
        
        NSURLRequest *loginRequest = [NSURLRequest requestWithURL:loginRequestURL];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        [config setHTTPAdditionalHeaders:@{@"Authorization": basicAuthString}];
        
        self.sessoin = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDataTask *loginTask = [self.sessoin dataTaskWithRequest:loginRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                
                if(httpResponse.statusCode == 200) {
                
                
                    NSDictionary *retrievedJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    NSMutableDictionary *userDictionary = [retrievedJSON mutableCopy];
                    [userDictionary setObject:basicAuthString forKey:@"basicAuthString"];
                    
                    [self initializeUserWithUserJSONObject:userDictionary];
                    
                    flag = YES;
                    
                
                }
                else if(httpResponse.statusCode == 403 ){
                
                    NSLog(@"access forbidden");
                }
                
                
            }
            else{
                NSLog(@"error -> %@",error.localizedDescription);
            
            }
            
          
            
        }];
        
        
        [loginTask resume];
        
       
        
        
    });
    
    
    
    
    return flag;
    
}

*/

@end

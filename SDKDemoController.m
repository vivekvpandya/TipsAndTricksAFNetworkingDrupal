//
//  SDKDemoController.m
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.
// 
//

#import "SDKDemoController.h"
#import "Drupal8RESTSessionManager.h"

@interface SDKDemoController ()
@property (nonatomic,strong) NSString *baseURL;
@end

@implementation SDKDemoController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.baseURL = [NSString stringWithFormat:@"http://tntfoss-vivekvpandya.rhcloud.com"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)test:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
  NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"1"} ],@"field_tag":@[@{@"target_id":@"1"}],@"body":@[@{@"value":@"This is text",@"format":@"full_html"}],@"title":@[@{@"value":@"Tip Via Drupal 8 iOS sdk"}]};
    
    
   [manager POSTNode:self.baseURL
          bundleType:@"tip"
          parameters:parameters
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"OK POSTED");
   }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error.description);
             }];
    
}
- (IBAction)testDelete:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    
    
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    
    [manager DELETENode:self.baseURL nodeId:@"55" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"ok deleted");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}
- (IBAction)getView:(id)sender {
    
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager GETView:self.baseURL
            viewName:@"vocabulary/foss"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"%@",responseObject);
    }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error.description);
             }];
    

    
    
}
- (IBAction)testGetNode:(id)sender {
    
     Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
   
    [manager setValue:@"application/hal+json" forHTTPRequestHeader:@"Accept"];
    
    
    
    [manager GETNode:self.baseURL
              nodeId:@"57"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"%@",responseObject);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error.description);
             }];
    
    
}
- (IBAction)getUser:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    [manager setValue:@"application/hal+json" forHTTPRequestHeader:@"Accept"];
    
    [manager GETUser:self.baseURL userId:@"7" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
- (IBAction)deleteUser:(id)sender {

    // this method will require Administrator credentials
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    [manager DELETEUser:self.baseURL
                 userId:@"122"
                success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"OK Delete");
    }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];

}
- (IBAction)patchNode:(id)sender {
    
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"1"} ],@"field_tag":@[@{@"target_id":@"2"}],@"body":@[@{@"value":@" Hey I have updated this node via drupal 8 ios kit ",@"format":@"full_html"}],@"title":@[@{@"value":@"Tip Via Drupal 8 iOS sdk"}]};
    
    [manager PATCHNode:self.baseURL bundleType:@"tip" nodeId:@"61" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"UPDATED !");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
    
}
- (IBAction)postUser:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    [manager setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPRequestHeader:@"Authorization"];
    
    NSDictionary *parameters = @{@"name":@[@{@"value":@"Dr8Test"}],@"mail":@[@{@"value":@"someunique@gmail.com"}],
                                 @"pass":@[@{@"value":@"New@123"}]};
    
    [manager POSTUser:self.baseURL
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"User Created");
    }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
    
}
- (IBAction)patchUser:(id)sender {
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary *parameters = @{@"name":@[@{@"value":@"Dr8Testing"}],@"mail":@[@{@"value":@"some1unique@gmail.com"}],
                                 @"pass":@[@{@"value":@"New@123"}]};
    
    [manager PATCHUser:self.baseURL userId:@"181" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"User UPDATED !");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
- (IBAction)postArticle:(id)sender {
    
    
    Drupal8RESTSessionManager *manager = [[Drupal8RESTSessionManager alloc]init];
    
    [manager.sessionManager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"1"} ],@"body":@[@{@"value":@"New Article first time with REST API ",@"format":@"full_html"}],@"title":@[@{@"value":@"Article Via Drupal 8 iOS sdk"}]};
    
    
    [manager POSTNode:self.baseURL
           bundleType:@"article"
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSLog(@"OK POSTED");
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  NSLog(@"%@",error.description);
              }];
    
}

@end

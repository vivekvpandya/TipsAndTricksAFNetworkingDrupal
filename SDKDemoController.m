//
//  SDKDemoController.m
//  TipsAndTricksAFNetworking
//
//  Created by Vivek Pandya on 7/16/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "SDKDemoController.h"
#import "Drupal8RESTSessionManager.h"

@interface SDKDemoController ()

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
    
  NSDictionary *parameters=  @{@"uid":@[@{@"target_id":@"2"} ],@"field_tag":@[@{@"target_id":@"3"}],@"body":@[@{@"value":@"text",@"format":@"full_html"}],@"title":@[@{@"value":@"value"}]};
   
    [manager POSTNode:@"http://tntfoss-vivekvpandya.rhcloud.com" bundleType:@"tip" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

@end

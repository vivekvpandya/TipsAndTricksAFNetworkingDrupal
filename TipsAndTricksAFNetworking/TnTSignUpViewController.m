//
//  TnTSignUpViewController.m
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 6/15/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "TnTSignUpViewController.h"
#import "TipsandTricks.h"
#import "UIAlertView+AFNetworking.h"

@interface TnTSignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TnTSignUpViewController

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
- (IBAction)cancle:(id)sender {
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signup:(id)sender {
    
    
    
    
    
    
    [self.usernameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    
    NSString *username = [self.usernameField text];
    NSString *email = [self.emailField text];
    
 
    
    
    NSDictionary *requestBodyDictionary = @{
                                            @"_links":@{
                                                    @"type":@{
                                                            @"href":@"http://tntfoss-vivekvpandya.rhcloud.com/rest/type/user/user"
                                                            }
                                                    },
                                            @"name":@[@{@"value":username}],
                                            @"mail":@[@{@"value":email}],
                                            @"status":@[@{@"value":@"0"}] // 0 -> blocked state 1 -> active state
                                            
                                            
                                            };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/hal+json" forHTTPHeaderField:@"Content-Type" ];
    [manager.requestSerializer setValue:@"Basic cm9vdDprfjNpVHJhaEQ=" forHTTPHeaderField:@"Authorization"];
    
    // here we need to pass root credential with user POST request
    // It shoud not be like that
    // for more details ferer this https://www.drupal.org/node/2291055
    
NSURLSessionDataTask *postUser = [manager POST:@"http://tntfoss-vivekvpandya.rhcloud.com/entity/user" parameters:requestBodyDictionary success:^(NSURLSessionDataTask *task, id responseObject) {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sign-up Successful" message:@"A mail with further details has been sent to your mail id" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    
    
}];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:postUser delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
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


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0){
    
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }

}



@end

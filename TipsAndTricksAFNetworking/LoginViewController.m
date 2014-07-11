//
//  LoginViewController.m
//  LoginWithKeyChain
//
//  Created by Vivek Pandya on 5/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "LoginViewController.h"
#import "SGKeychain.h"
#import "User.h"
#import "TipsandTricks.h"
#import "TnTSignUpViewController.h"
#import "UIAlertView+AFNetworking.h"


@interface LoginViewController ()

@property (nonatomic,strong) NSURLSession *session;


@end

@implementation LoginViewController 

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
    self.navigationItem.title = @"Login to tntfoss";
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
- (IBAction)login:(id)sender {
    
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    [self.activityIndicator startAnimating];
    
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    
    
  
    NSString *basicAuthString = [TipsandTricks basicAuthStringforUsername:username Password:password];
    AFHTTPSessionManager *sessionManager =[AFHTTPSessionManager manager];
    [sessionManager.requestSerializer setValue:basicAuthString forHTTPHeaderField:@"Authorization"];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *loginOperation = [sessionManager GET:@"http://tntfoss-vivekvpandya.rhcloud.com/user/details"
                                                    parameters:nil
                                                       success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *userDictionary = [responseObject mutableCopy];
        [userDictionary addEntriesFromDictionary:@{@"basicAuthString":basicAuthString}];
        NSError *setPasswordError = nil;
        [SGKeychain setPassword:password username:username serviceName:@"Drupal 8" accessGroup:nil updateExisting:YES error:&setPasswordError];
        
        if (userDictionary != nil) {
             NSLog(@"userDictionary %@", userDictionary );
            User *user = [User sharedInstance];
            [user fillUserWithUserJSONObject:userDictionary];
            
        }
                                                           
            [self.activityIndicator stopAnimating];
                                                           
           
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                           
    // remove login view from stack and add userDetails view to stack
    [self.navigationController setViewControllers:[NSArray arrayWithObject:[storyboard instantiateViewControllerWithIdentifier:@"userDetails"]] animated:YES];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.activityIndicator stopAnimating];
        NSLog(@"faliure %@",error.description);
        
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:loginOperation delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    
    
       
    
}

- (IBAction)hideKeyBoard:(UITapGestureRecognizer *)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

/*- (IBAction)loadSignUpView:(id)sender {
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    TnTSignUpViewController *signUpViewController = [storyBoard instantiateViewControllerWithIdentifier:@"signUp"];
    
    [self.navigationController pushViewController:signUpViewController animated:YES];
    
}

*/
@end

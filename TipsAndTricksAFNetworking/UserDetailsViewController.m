//
//  UserDetailsViewController.m
//  LoginWithKeyChain
//
//  Created by Vivek Pandya on 5/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "SGKeychain.h"
#import "User.h"
#import "TipsandTricks.h"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

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
    self.navigationItem.title = @"User Details";
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

    User *user = [User sharedInstance];
    
    if (user.name != nil) {
        [self setUIwithUserDetails];
    }

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
- (IBAction)logout:(id)sender {
    

    NSError *deleteError = nil;
    

    
// delete keychain item with service name "Drupal 8"
    
    BOOL deleteItemFlag = [SGKeychain deletePasswordandUserNameForServiceName:@"Drupal 8" accessGroup:nil error:&deleteError];
    User *user = [User sharedInstance];
    [user clearUserDetails];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];

    // present login view controller
    if (deleteItemFlag == YES) {
        
        
        [self.navigationController setViewControllers:[NSArray arrayWithObject:vc] animated:YES];
    }
    
}

-(void)setUIwithUserDetails{


    User *user = [User sharedInstance];
    if (user.name != nil) {
        
        
        self.usernameLabel.text = user.name;
        
        NSMutableString *roleString = [[NSMutableString alloc]init];
        
        for (id value in user.roles ) {
            [roleString appendString:[NSString stringWithFormat:@"%@ \n",value]];
            
        }
        self.rolesLabel.text = roleString;
    }
    else{
        NSLog(@"can't set UI as user is empty");
    
    }
    

}

@end

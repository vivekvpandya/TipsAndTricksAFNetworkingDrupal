//
//  NavigationController.m
//  LoginWithKeyChain
//
//  Created by Vivek Pandya on 5/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//



#import "NavigationController.h"
#import "SGKeychain.h" // a keychain item wrrapper class
#import "User.h" // A singleton user object that will be initialized as user logs in
#import "TipsandTricks.h" // some hepler methods

@interface NavigationController ()

@end

@implementation NavigationController

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

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    User *user = [User sharedInstance];
    if ( user.name != nil)
    {
        
        [self setViewControllers:[NSArray arrayWithObject:[storyboard instantiateViewControllerWithIdentifier:@"userDetails"]] animated:YES];        // here we can say that previously user has tried to log in
        // it may be possible that user has killed the app and reopend it
        
    }
    
    
    else
    {
        
        [self setViewControllers:[NSArray arrayWithObject:[storyboard instantiateViewControllerWithIdentifier:@"login"]] animated:YES];        // no credentials are found for "Drupal 8" service name that means that user has not logged in
        
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

@end

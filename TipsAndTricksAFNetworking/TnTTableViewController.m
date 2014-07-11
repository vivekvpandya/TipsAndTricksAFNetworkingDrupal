//
//  TnTTableViewController.m
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 4/30/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
// This is a TableViewController Class for Drupal Tips.

#import "TnTTableViewController.h"
#import "TnTTipViewController.h"
#import "TipsandTricks.h"
#import "User.h"
#import "Tip.h"
#import "UIAlertView+AFNetworking.h"
#import "SGKeychain.h"


@interface TnTTableViewController ()

@property (nonatomic,strong) NSMutableArray *tipList; // to hold NSDictionaries that are created with JSON Response and each NSDictionary represent tip object i.e it will contain all the fields which you have enabled from RESTExport for the view
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addTipButton;



@end

@implementation TnTTableViewController




-(IBAction)getData{

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
   
    
    
   NSURLSessionDataTask *getTipData = [sessionManager GET:@"http://tntfoss-vivekvpandya.rhcloud.com/fossTips/rest" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
   
            
       
            
            [self.tipList removeAllObjects];
            for (NSDictionary *tip in responseObject)
            {
                
                [self.tipList addObject:tip];
                
            }
            [self.tableView reloadData];
       
        
            
            
            
            
       
        
       
        [self.refreshControl endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.refreshControl endRefreshing];
        NSLog(@"%@",error.description);
        
        
        
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:getTipData delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
}

-(NSMutableArray *)tipList{

    if(!_tipList)
        _tipList = [[NSMutableArray alloc]init];
    
    return _tipList;

}




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSError *fetchPasswordError = nil;
    
    NSArray *credentials = [SGKeychain usernamePasswordForServiceName:@"Drupal 8" accessGroup:nil error:&fetchPasswordError];
    NSString *basicAuthString = [TipsandTricks basicAuthStringforUsername:credentials[0] Password:credentials[1]];
    
  
    
    if (credentials != nil ) {
        
        
        
        AFHTTPSessionManager *sessionManager =[AFHTTPSessionManager manager];
        [sessionManager.requestSerializer setValue:basicAuthString forHTTPHeaderField:@"Authorization"];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSURLSessionDataTask *loginOperation = [sessionManager GET:@"http://tntfoss-vivekvpandya.rhcloud.com/user/details"
                                                        parameters:nil
                                                           success:^(NSURLSessionDataTask *task, id responseObject) {
                                                               
                                                               NSMutableDictionary *userDictionary = [responseObject mutableCopy];
                                                               [userDictionary addEntriesFromDictionary:@{@"basicAuthString":basicAuthString}];
                                                               NSError *setPasswordError = nil;
                                                               [SGKeychain setPassword:credentials[1]
                                                                              username:credentials[0] serviceName:@"Drupal 8" accessGroup:nil updateExisting:YES error:&setPasswordError];
                                                               
                                                               if (userDictionary != nil) {
                                                                   NSLog(@"userDictionary %@", userDictionary );
                                                                   User *user = [User sharedInstance];
                                                                   [user fillUserWithUserJSONObject:userDictionary];
                                                                   
                                                                   
                                                                   [self getData];
                                                                   self.addTipButton.enabled = YES;
                                                               }
                                                               
                                                            
                                                               
                                                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                               self.addTipButton.enabled = NO;
                                                               NSError *deleteCredentialError = nil;
                                                               NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) task.response;
                                                               if (httpResponse.statusCode == 403) {
                                                                   [SGKeychain deletePasswordandUserNameForServiceName:@"Drupal 8" accessGroup:nil error:&deleteCredentialError];
                                                               }
                                                               
                                                           }
                                                ];
        
        [UIAlertView showAlertViewForTaskWithErrorOnCompletion:loginOperation delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        

        
    }
    else{
    [self getData];
    self.addTipButton.enabled = NO;
        
    }

    [self.refreshControl addTarget:self action:@selector(getData) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    
    
    
}



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self getData];
   
    User *user = [User sharedInstance];
    
    if (user.name) {
        self.addTipButton.enabled = YES;
    }
    else
    {
        self.addTipButton.enabled = NO;
    }

    
   }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.tipList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"push" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.tipList objectAtIndex:indexPath.row] valueForKeyPath:@"title"];
    cell.detailTextLabel.text = [[self.tipList objectAtIndex:indexPath.row] valueForKeyPath:@"changed"];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"basicAuthString"] != nil ) {
        
        return YES;
        
    }
    else{
        return NO;
    }
    
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
 */
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        
        if ([segue.destinationViewController isKindOfClass:[TnTTipViewController class]]) {
            
            if ([segue.identifier isEqualToString:@"push"]) {
                
                TnTTipViewController *newVC = (TnTTipViewController *)segue.destinationViewController;
                newVC.tip = [self.tipList objectAtIndex:[self.tableView indexPathForCell:sender].row];
                
            }
        }
    }
    
    
}




@end

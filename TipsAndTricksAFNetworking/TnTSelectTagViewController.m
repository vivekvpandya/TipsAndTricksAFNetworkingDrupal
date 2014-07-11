//
//  TnTSelectTagViewController.m
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 6/3/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import "TipsandTricks.h"
#import "TnTSelectTagViewController.h"
#import "UIAlertView+AFNetworking.h"


@interface TnTSelectTagViewController ()

@property (nonatomic,strong) NSArray *tags; // Actually you should load all related taxonomy terms here from your site, for that can create a REST export to a view that gives taxonomy terms for particular vocabulary for my site I have created /vocabulary/foss

@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation TnTSelectTagViewController

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
     // first time load tags from server
    
   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getTags];
   // [self.tableView reloadData];

    NSLog(@"%@ --- ",self.selectedValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTags:(NSArray *)tags{

    _tags = tags;
    [self.tableView reloadData];
}





#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tags count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"tagValue" forIndexPath:indexPath];
    cell.textLabel.text = [[self.tags objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    if (self.selectedValue) {
        if ([cell.textLabel.text isEqualToString:[self.selectedValue objectForKey:@"name"]]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    return cell;

}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectedValue != nil) {
        NSInteger index = [self.tags indexOfObject:self.selectedValue];
        NSIndexPath *selecationIndexPath = [NSIndexPath indexPathForRow:index
                                                              inSection:0];
        [[tableView cellForRowAtIndexPath:selecationIndexPath]setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedValue = [self.tags objectAtIndex:indexPath.row];
    [self.delegate backButtonSelected:self.selectedValue];
    

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

-(void)getTags{
  
    
    /*
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    NSMutableURLRequest *tagRequest = [NSMutableURLRequest requestWithURL:[TipsandTricks createURLForPath:@"vocabulary/foss"]];
  
    
    
  //  NSURLSessionConfiguration *config  = [NSURLSessionConfiguration defaultSessionConfiguration];
    [tagRequest setHTTPMethod:@"GET"];
    [tagRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    [tagRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    dispatch_queue_t fatchQ = dispatch_queue_create("fetchQ", NULL);
    
    dispatch_async(fatchQ, ^{
        
        
        NSURLSessionDataTask *getTagTask = [ session dataTaskWithRequest:tagRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                
                if (httpResponse.statusCode == 200) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
                        NSArray *tags = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                        
                        self.tags = tags;
                    });
                    
                    
                    
                    
                }
                else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error while getting content " message:[NSString stringWithFormat:@"%ld %@ ",(long)httpResponse.statusCode,[NSHTTPURLResponse localizedStringForStatusCode:httpResponse.statusCode]] delegate:self cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
                        [alert show];
                        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
                        
                    });
                    
                }
                
            }
            else{
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error while getting content " message:@"error in request" delegate:self cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
                    [alert show];
                    
                    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
                });
                
                
            }
            
        }];
        
        [getTagTask resume];
        

        
    });
    
    */
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *getTagTask = [manager GET:@"http://tntfoss-vivekvpandya.rhcloud.com/vocabulary/foss" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.tags = (NSArray *)responseObject;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:getTagTask delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

        [self.navigationController popViewControllerAnimated:YES];
}

@end

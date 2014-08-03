//
//  TnTSelectTagViewController.m
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 6/3/14.
//  

/*
 The MIT License (MIT)
 
 Copyright (c) 2014 Vivek Pandya. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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

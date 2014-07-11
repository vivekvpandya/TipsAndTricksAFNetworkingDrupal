//
//  TnTEditandNewTipViewController.h
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 6/2/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TnTSelectTagViewController.h"

@interface TnTEditandNewTipViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIWebViewDelegate, TnTSelectTagProtocol>

@property (nonatomic,strong) NSMutableDictionary *tip;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

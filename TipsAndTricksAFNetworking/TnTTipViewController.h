//
//  TnTTipViewController.h
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 6/1/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TnTSelectTagViewController.h"
#import "Tip.h"
@interface TnTTipViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate, TnTSelectTagProtocol, UIWebViewDelegate, UIActionSheetDelegate>

@property (nonatomic,strong) Tip *tip;
@end

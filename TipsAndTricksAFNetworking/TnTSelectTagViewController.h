//
//  TnTSelectTagViewController.h
//  TipsAndTricksCFNetwork
//
//  Created by Vivek Pandya on 6/3/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TnTSelectTagProtocol <NSObject>

-(void)backButtonSelected:(id)object;

@end

@interface TnTSelectTagViewController : UIViewController <UITableViewDataSource , UITableViewDelegate, UIAlertViewDelegate>
@property (weak)id<TnTSelectTagProtocol> delegate;
@property (nonatomic,strong) NSDictionary *selectedValue;
@end

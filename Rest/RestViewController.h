//
//  RestViewController.h
//  Rest
//
//  Created by Josh Gray on 5/21/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) IBOutlet UITextField *CaptureInformation;
@property (strong, nonatomic) IBOutlet UIButton *SendInformation;

@property (strong, nonatomic) IBOutlet UITextField *CaptureInformation2;
@property (strong, nonatomic) IBOutlet UITextField *CaptureInformation_first;
@property (strong, nonatomic) IBOutlet UITextField *CaptureInformation_last;

@property (strong, nonatomic) IBOutlet UIButton *SendInformation2;

- (IBAction)fetchGreeting;

@end

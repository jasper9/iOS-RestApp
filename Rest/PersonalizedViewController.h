//
//  PersonalizedViewController.h
//  Rest
//
//  Created by Josh Gray on 6/23/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalizedViewController : UIViewController

@property (nonatomic, strong) NSString *nameFirst;
@property (nonatomic, strong) NSString *nameLast;

@property (strong, nonatomic) IBOutlet UITextField *CaptureInformation2;
@property (strong, nonatomic) IBOutlet UIButton *SendInformation2;

@property (strong, nonatomic) IBOutlet UITextField *CaptureInformation_first;
@property (strong, nonatomic) IBOutlet UITextField *CaptureInformation_last;

@end

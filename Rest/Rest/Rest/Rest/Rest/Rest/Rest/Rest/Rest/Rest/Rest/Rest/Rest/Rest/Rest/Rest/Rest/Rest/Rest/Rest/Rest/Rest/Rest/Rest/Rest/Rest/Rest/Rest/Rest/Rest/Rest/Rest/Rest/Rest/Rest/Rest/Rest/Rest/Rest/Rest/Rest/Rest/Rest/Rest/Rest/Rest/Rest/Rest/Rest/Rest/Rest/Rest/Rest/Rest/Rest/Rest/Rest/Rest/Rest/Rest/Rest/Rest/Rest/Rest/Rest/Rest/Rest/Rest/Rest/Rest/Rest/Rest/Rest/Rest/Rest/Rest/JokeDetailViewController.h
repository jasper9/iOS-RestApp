//
//  JokeDetailViewController.h
//  Rest
//
//  Created by Josh Gray on 5/31/14.
//  Copyright (c) 2014 Spring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JokeDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *jokeLabel;
@property (nonatomic, strong) NSString *jokeName;

@end

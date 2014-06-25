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
@property (nonatomic) int *jokeID;

// not sure it won't work without this.
// i think i accidentially created this IBOutlet then deleted
// something still wants it??
@property (nonatomic, strong) IBOutlet UILabel *btnFacebookSharing_Clicked;

- (IBAction)btnFacebookSharing_Clicked2:(id)sender;
- (IBAction)btnTwitterSharing_Clicked:(id)sender;

@end

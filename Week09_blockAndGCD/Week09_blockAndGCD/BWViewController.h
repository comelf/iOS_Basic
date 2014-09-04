//
//  BWViewController.h
//  Week09_blockAndGCD
//
//  Created by byungwoo on 2014. 9. 2..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWViewController : UIViewController <NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *firstButton;

- (IBAction)firstButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@end

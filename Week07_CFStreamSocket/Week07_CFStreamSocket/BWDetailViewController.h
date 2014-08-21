//
//  BWDetailViewController.h
//  Week07_CFStreamSocket
//
//  Created by byungwoo on 2014. 8. 21..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWDetailViewController : UIViewController <NSStreamDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@end

//
//  BWViewController.h
//  Week08_Mission_View
//
//  Created by byungwoo on 2014. 8. 26..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWBarGraphView.h"
#import "BWPieGraphView.h"

@interface BWViewController : UIViewController
@property (weak, nonatomic) IBOutlet BWBarGraphView *barGraphView;
@property (weak, nonatomic) IBOutlet BWPieGraphView *pieGraphView;
@end

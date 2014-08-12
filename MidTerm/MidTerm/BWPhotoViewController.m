//
//  BWPhotoViewController.m
//  MidTerm
//
//  Created by byungwoo on 2014. 8. 12..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWPhotoViewController.h"

@interface BWPhotoViewController ()
{
    NSDictionary* viewData;
}
@end

@implementation BWPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_titleLabel setText: [viewData objectForKey:@"title"]];
    UIImage* img = [UIImage imageNamed:[viewData objectForKey:@"image"]];
    [_imgView setImage:img];
    [_dateLabel setText: [viewData objectForKey:@"date"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sendData:(NSDictionary*)data
{
    viewData = data;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

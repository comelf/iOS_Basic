//
//  BWViewController.m
//  Week08_Mission_View
//
//  Created by byungwoo on 2014. 8. 26..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWViewController.h"


@interface BWViewController ()

@end

@implementation BWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *dataString = @"[{\"title\":\"April\", \"value\":5},{\"title\":\"May\", \"value\":12},{\"title\":\"June\", \"value\":18},{\"title\":\"July\",\"value\":11},{\"title\":\"August\", \"value\":15},{\"title\":\"September\", \"value\":9},{\"title\":\"October\",\"value\":17},{\"title\":\"November\", \"value\":25},{\"title\":\"December\", \"value\":31}]";
    
    NSArray *json1 = [NSJSONSerialization
                           JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding]
                                    options:0 error:nil];
    
    [_barGraphView setData:json1];
    [_barGraphView refresh];
    
    
    NSString *dataString2 = @"[{\"title\":\"April\", \"percentage\":18},{\"title\":\"May\", \"percentage\":12},{\"title\":\"June\",\"percentage\":18},{\"title\":\"July\", \"percentage\":13},{\"title\":\"August\", \"percentage\":18},{\"title\":\"September\", \"percentage\":9},{\"title\":\"October\", \"percentage\":18}]";
    NSArray *json2 = [NSJSONSerialization
                     JSONObjectWithData:[dataString2 dataUsingEncoding:NSUTF8StringEncoding]
                     options:0 error:nil];
    
    [_pieGraphView setData:json2];
    [_pieGraphView refresh];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

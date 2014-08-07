//
//  BWViewController.m
//  Week05_Cache
//
//  Created by byungwoo on 2014. 8. 7..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWViewController.h"

@interface BWViewController ()
{
    NSMutableArray *imgCacheArray, *imgNameArr;
}
@end

@implementation BWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int count = 21;
    
    imgCacheArray   = [[NSMutableArray alloc] initWithCapacity:count];
    imgNameArr      = [[NSMutableArray alloc] initWithCapacity:count];
    
    for (int i =0; i<count; i++){
        [imgNameArr addObject:[NSString stringWithFormat:@"%02d.jpg",i+1]];
        if (i<3) {
            [self insertImage:i];
        }else{
            [imgCacheArray  insertObject:[NSNull null] atIndex:i];
        }
    }

    [_scrollView setDelegate:self];
    [_scrollView setContentSize:CGSizeMake(320, 250*count)];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertImage:(int)position
{
    NSString* path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] bundlePath],imgNameArr[position]];
    UIImage* img = [UIImage imageWithContentsOfFile:path];
    UIImageView* imgView = [[UIImageView alloc]initWithImage:img];
    int y = 250 * position;
    [imgView setFrame:CGRectMake(0 , y, 320, 250)];
    [imgCacheArray insertObject:imgView atIndex:position];
    [_scrollView addSubview:imgView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int position = (scrollView.contentOffset.y/ 250);
    
    
    if(position > 1){
        UIImageView *temp = [imgCacheArray objectAtIndex:position-2];
        if(temp!=[NSNull null]){
            [temp removeFromSuperview];
            //[[imgCacheArray objectAtIndex:position-1] removeFromSuperview];
            [imgCacheArray  removeObjectAtIndex:position-2];
            [imgCacheArray  insertObject:[NSNull null] atIndex:position-2];
        }
    }
    
    if (position > 0) {
        UIImageView *temp = [imgCacheArray objectAtIndex:position - 1];
        if(temp==[NSNull null]){
            [imgCacheArray removeObjectAtIndex:position -1];
            [self insertImage: position - 1];
        }
    }
    
    
    if (position + 3 < 21) {
        UIImageView *temp = [imgCacheArray objectAtIndex:position + 3];
        if(temp==[NSNull null]){
            [imgCacheArray removeObjectAtIndex:position +3];
            [self insertImage: position + 3];
        }
    }
    
    if (position + 4 < 21) {
        UIImageView *temp = [imgCacheArray objectAtIndex:position+4];
        if(temp!=[NSNull null]){
            [temp removeFromSuperview];
            //[[imgCacheArray objectAtIndex:position-1] removeFromSuperview];
            [imgCacheArray  removeObjectAtIndex:position + 4];
            [imgCacheArray  insertObject:[NSNull null] atIndex:position+4];
        }
    }
}
@end

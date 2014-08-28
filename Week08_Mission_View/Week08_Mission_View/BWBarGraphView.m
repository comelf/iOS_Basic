//
//  BWBarGraphView.m
//  Week08_Mission_View
//
//  Created by byungwoo on 2014. 8. 28..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//
#define BAR_HEIGHT 20
#define BAR_SPACE 10
#import "BWBarGraphView.h"

@implementation BWBarGraphView
{
    NSArray *yearData;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(NSArray*)data
{
    yearData = data;
}

-(void)refresh
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if(yearData!=nil){
        int dis = BAR_HEIGHT + BAR_SPACE;
        
        for(int i = 0; i<9; i++){
            NSString* title = [yearData[i] objectForKey:@"title"];
            int value = [[yearData[i] objectForKey:@"value"] intValue];
            
            //NSLog(@"title = %@, value = %d",title,value);
            
            //title
            CGRect re = CGRectMake(10, dis*i, 100, BAR_HEIGHT);
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            [style setAlignment:NSTextAlignmentCenter];
            NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
            [title drawInRect:re withAttributes:attr];
            
            
            //bar graph
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGSize myShadowOffset = CGSizeMake (3,  3);
            CGContextSetShadow(context, myShadowOffset, 5);
            CGRect rectangle = CGRectMake(100, dis*i, value*5 , BAR_HEIGHT);
            CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextFillRect(context, rectangle);
            
        }
    }
}


@end

//
//  BWPieGraphView.m
//  Week08_Mission_View
//
//  Created by byungwoo on 2014. 8. 28..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWPieGraphView.h"

@implementation BWPieGraphView
{
    NSArray *yearData;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"GraphView init");
    }
    return self;
}


-(void)setData:(NSArray*)data
{
    yearData = data;
    
            NSLog(@"GraphView data");
}

-(void)refresh
{
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    
    NSArray* myColorArray=[[NSArray alloc]initWithObjects:[UIColor purpleColor],[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blackColor],[UIColor grayColor],[UIColor brownColor],[UIColor lightGrayColor], nil];
    
    if(yearData!=nil){
        int c=[yearData count];
        
        CGFloat angleArray[c];
        CGFloat offset;
        int sum=0;
        int radius = 100;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        
        CGContextSetAllowsAntialiasing(context, false);
        CGContextSetShouldAntialias(context, false);
        
        
        
        for(int i=0;i<[yearData count];i++)
        {
            
            sum +=[[yearData[i] objectForKey:@"percentage"] intValue];
        }
        
        NSLog(@"%d",sum);
        for(int i=0;i<[yearData count];i++)
        {
            angleArray[i]=(float)(([[yearData[i] objectForKey:@"percentage"] intValue])/(float)sum)*(2*3.14);
            CGContextMoveToPoint(context, radius, radius);
            if(i==0)
                CGContextAddArc(context, radius, radius, radius, 0,angleArray[i], 0);
            else
                CGContextAddArc(context, radius, radius, radius,offset,offset+angleArray[i], 0);
            offset+=angleArray[i];
            
            
            CGContextSetFillColorWithColor(context,((UIColor *)[myColorArray objectAtIndex:i]).CGColor);
            CGContextClosePath(context); 
            CGContextFillPath(context);
            
            
        }
    }
}

@end

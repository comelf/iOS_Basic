//
//  BWPathView.m
//  Week08_Mission_View
//
//  Created by byungwoo on 2014. 8. 26..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWPathView.h"

@implementation BWPathView
{
    UIBezierPath *path;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    int height = rect.size.height;
    int width = rect.size.width;
    
    CGFloat randHeight = arc4random() % height;
    CGFloat randWidth  = arc4random() % width;
    
    path = [UIBezierPath bezierPath];
    
    CGPoint startPoint = CGPointMake(randWidth, randHeight);
    [path moveToPoint:startPoint];
    
    for (int i=0; i<9; i++) {
        randHeight = arc4random() % height;
        randWidth  = arc4random() % width;
        
        CGPoint nextPoint = CGPointMake(randWidth, randHeight);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];

    }
        [path stroke];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i=0; i<10; i++) {
        randHeight = arc4random() % height;
        randWidth  = arc4random() % width;
        
        int size = arc4random() % 50 + 50;
        
        CGContextSetLineWidth(context, 1.0);
        CGRect rectangle = CGRectMake(randWidth, randHeight, size ,size);
        CGContextAddEllipseInRect(context, rectangle);
        
        CGFloat randR = drand48();
        CGFloat randG = drand48();
        CGFloat randB = drand48();
        
        UIColor *color = [UIColor colorWithRed:randR green:randG blue:randB alpha:1.0f];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
        
    }
    //CGContextStrokePath(context);
    
    
    NSString* string = @"HELLO WORLD!";

    
    CGRect re = CGRectMake(100, 200, 100, 100);
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
    [string drawInRect:re withAttributes:attr];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self setNeedsDisplay];
}


@end

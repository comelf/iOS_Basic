//
//  BWMyView.m
//  Week08_Mission_View
//
//  Created by byungwoo on 2014. 8. 26..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWMyView.h"

@implementation BWMyView
{
    NSArray* colorArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            }
    return self;
}


- (void)drawRect:(CGRect)rect
{
//    [[UIColor redColor] setFill];
//    UIRectFill(self.bounds);
    
    UIColor *c1 = [UIColor redColor];
    UIColor *c2 = [UIColor whiteColor];
    UIColor *c3 = [UIColor blueColor];
    UIColor *c4 = [UIColor brownColor];
    UIColor *c5 = [UIColor yellowColor];
    UIColor *c6 = [UIColor greenColor];
    colorArr = [[NSArray alloc] initWithObjects:c1,c2,c3,c4,c5,c6, nil];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    int ran = arc4random() % 6;
    
    UIColor * startColor = colorArr[ran];
    UIColor * endColor = colorArr[(arc4random() % 6)];
    
    CGGradientRef gradient = [self gradient:startColor endColor:endColor];
    CGPoint startPoint
    = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint
    = CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMaxY(self.bounds));
    
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);
    CGGradientRelease(gradient);
}

- (CGGradientRef) gradient :(UIColor*)startColor endColor:(UIColor*)endColor
{
    
    CGGradientRef result;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[2] = {0.0f , 1.0f};
    CGFloat startRed, startGreen, startBlue, startAlpha;
    CGFloat endRed, endGreen, endBlue, endAlpha;
    
    
    
    [endColor getRed:&endRed green:&endGreen blue:&endBlue alpha:&endAlpha];
    [startColor getRed:&startRed green:&startGreen blue:&startBlue alpha:&startAlpha];
    
    CGFloat componnents[8] = {
        startRed, startGreen, startBlue, startAlpha,
        endRed, endGreen, endBlue, endAlpha
    };
    
    result = CGGradientCreateWithColorComponents(colorSpace, componnents, locations, 2);
    CGColorSpaceRelease(colorSpace);
    return result;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}

@end

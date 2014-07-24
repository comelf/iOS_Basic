//
//  puzzle.h
//  Week03_Mrc
//
//  Created by byungwoo on 2014. 7. 24..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWPuzzle : NSObject
-(id)initWithCapacity:(int)num;
-(void)print;
-(void)moveUp;
-(void)moveDown;
-(void)moveRight;
-(void)moveLeft;
-(void)randomMove:(int)num;
@end

//
//  puzzle.m
//  Week03_Mrc
//
//  Created by byungwoo on 2014. 7. 24..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWPuzzle.h"
struct position
{
    int x;
    int y;
};

@implementation BWPuzzle
{
    NSMutableArray* puzzle;
    int max;
    struct position blankPosition;
    BOOL isUser;
    int movecount;
}

-(id)initWithCapacity:(int)num
{
    max = num;
    self = [super init];
    if(self){
        
        puzzle = [[NSMutableArray alloc]initWithCapacity:(NSUInteger)num];
        
        NSNumber* count = [NSNumber numberWithInt:1];
        
        for(int i=0; i<num; i++){
            NSMutableArray* row = [[NSMutableArray alloc]initWithCapacity:(NSUInteger)num];
            
            for(int j=0; j<num; j++){
                row[j] = count;
                int current = [count intValue] + 1;
                count = [NSNumber numberWithInt:current];
            }
            
            [puzzle addObject:row];
            [row release];
        }
        
        count = [NSNumber numberWithInt:0];
        
        blankPosition.x = num-1;
        blankPosition.y = num-1;
        
        puzzle[blankPosition.x][blankPosition.y] = count;
        
    }
    return self;
}

-(void)print
{

    
    NSMutableString* barString = [[NSMutableString alloc]init];
    [barString appendString:@"*"];
    for (int k = 0; k<max; k++)
        [barString appendString:@"*****"];
    
    NSLog(@"%@",barString);
    
    for(int i=0; i<max; i++){
        
        NSMutableString* rowString = [[NSMutableString alloc]init];
        [rowString appendString:@"*"];
        for(int j=0; j<max; j++){
            int temp = [puzzle[i][j] intValue];
            if(temp == 0){
                [rowString appendString:[NSString stringWithFormat:@"    *"]];
            }else{
                [rowString appendString:[NSString stringWithFormat:@" %2d *" ,temp]];
            }
            
        }
        NSLog(@"%@",rowString);
        NSLog(@"%@",barString);
        [rowString release];
    }
    [barString release];
}

-(void)moveUp
{
    if (blankPosition.y >= max-1)
        return;
    
    NSNumber* blank = puzzle[blankPosition.y][blankPosition.x];
    NSNumber* target = puzzle[blankPosition.y+1][blankPosition.x];
    
    puzzle[blankPosition.y+1][blankPosition.x] = blank;
    puzzle[blankPosition.y][blankPosition.x] = target;
    
    blankPosition.y++;
    
    [self afterMove];
}
-(void)moveDown
{
    if (blankPosition.y <= 0)
        return;
    
    NSNumber* blank = puzzle[blankPosition.y][blankPosition.x];
    NSNumber* target = puzzle[blankPosition.y-1][blankPosition.x];

    puzzle[blankPosition.y-1][blankPosition.x] = blank;
    puzzle[blankPosition.y][blankPosition.x] = target;
    
    blankPosition.y--;
    
    [self afterMove];
}
-(void)moveRight
{
    if (blankPosition.x <= 0)
        return;
    
    NSNumber* blank = puzzle[blankPosition.y][blankPosition.x];
    NSNumber* target = puzzle[blankPosition.y][blankPosition.x-1];
    
    puzzle[blankPosition.y][blankPosition.x-1] = blank;
    puzzle[blankPosition.y][blankPosition.x] = target;
    
    blankPosition.x--;
    
    [self afterMove];

}
-(void)moveLeft
{
    if (blankPosition.x >= max-1)
        return;
    
    NSNumber* blank = puzzle[blankPosition.y][blankPosition.x];
    NSNumber* target = puzzle[blankPosition.y][blankPosition.x+1];
    
    puzzle[blankPosition.y][blankPosition.x+1] = blank;
    puzzle[blankPosition.y][blankPosition.x] = target;
    
    blankPosition.x++;
    
    [self afterMove];

}
-(void)afterMove
{
    if(isUser){
        [self print];
        if([self isFinish]){
            NSLog(@"Success!!");
            movecount++;
            NSLog(@"총 %d번 움직였습니다",movecount);
        }else{
            movecount++;
            NSLog(@"%d번 움직였습니다",movecount);
        }
    }
}
-(void)randomMove:(int)num
{

    for (int i =0; i<100; i++) {
        int r = arc4random() % 4;
    
        switch (r) {
            case 0:
                [self moveUp];
                break;
            case 1:
                [self moveDown];
                break;
            case 2:
                [self moveRight];
                break;
            case 3:
                [self moveLeft];
                break;
            
            default:
                break;
        }
    }
    
    isUser = YES;
    movecount = 0;
    [self print];
}
-(BOOL)isFinish
{
    
    int check = 1;
    
    for(int i=0; i<max; i++){
        for(int j=0; j<max; j++){
            int temp = [puzzle[i][j] intValue];
            if(temp!=0 && temp != check)
                return NO;
            check ++;
        }

    }
    
    return YES;
}
@end

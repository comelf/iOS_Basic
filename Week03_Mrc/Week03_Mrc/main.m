//
//  main.m
//  Week03_Mrc
//
//  Created by byungwoo on 2014. 7. 24..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWPuzzle.h"
#include <stdlib.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BWPuzzle* puzzle = [[BWPuzzle alloc]initWithCapacity:3];

        [puzzle print];
        
        [puzzle randomMove:100];

        
        int c;
        c = getchar();
        while (c != EOF) {
            switch (c) {
                case 'w':
                    [puzzle moveUp];
                    break;
                case 's':
                    [puzzle moveDown];
                    break;
                case 'd':
                    [puzzle moveRight];
                    break;
                case 'a':
                    [puzzle moveLeft];
                    break;
                    
                default:
                    break;
            }
            
            c = getchar();
            
        }

        [puzzle release];
    }
    

    return 0;
}


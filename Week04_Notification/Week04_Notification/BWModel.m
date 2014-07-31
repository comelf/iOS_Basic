//
//  BWModel.m
//  Week04_Notification
//
//  Created by byungwoo on 2014. 7. 31..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWModel.h"
#include <stdlib.h>
@implementation BWModel

-(void)randomize{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    int rand = arc4random() % 3;
    NSString* result;

    switch (rand) {
        case 0:
            result = @"paper.png";
            self.KVOTest = @"paper.png";
            break;
        case 1:
             result = @"scissors.png";
            self.KVOTest= @"scissors.png";
            break;
        case 2:
             result = @"rock.png";
            self.KVOTest= @"rock.png";
            break;
        default:
            
            break;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:result forKey:@"result"];
    [notificationCenter postNotificationName:@"rand" object:self userInfo:dic];

}


@end

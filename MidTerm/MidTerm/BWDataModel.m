//
//  BWDataModel.m
//  MidTerm
//
//  Created by byungwoo on 2014. 8. 12..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWDataModel.h"

@implementation BWDataModel
{
    NSArray* dataArr;
    NSArray* sortedArray;
}


- (id)init
{
    self = [super init];
    if (self) {

        char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\{\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\{\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\{\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\{\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\{\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\{\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\{\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\{\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
        
        int length = strlen(data);
        NSData* cData = [NSData dataWithBytes:data length:length];
        
        dataArr = [NSJSONSerialization JSONObjectWithData: cData
                                              options: NSJSONReadingMutableContainers
                                                error: nil];
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:@"dataLoad" object:self userInfo:nil];
    }
    
    return self;
}

-(NSInteger)numberOfData
{
    return [dataArr count];
}

-(NSDictionary*)objectAtIndex:(NSUInteger)index
{
    return dataArr[index];
}
-(void)dataSort
{

    sortedArray = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int firstDate = [[obj1 objectForKey:@"date"] intValue];
        int secondDate = [[obj2 objectForKey:@"date"] intValue];
        
        if (firstDate > secondDate) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (firstDate < secondDate) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    dataArr = sortedArray;
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"dataLoad" object:self userInfo:nil];
}

-(void)removeData:(int)index
{
    NSMutableArray *reversedCalEvents = [[[dataArr reverseObjectEnumerator] allObjects] mutableCopy];
    
    [reversedCalEvents removeObjectAtIndex:index];
    
    dataArr = [NSArray arrayWithArray:reversedCalEvents];
    
}
@end


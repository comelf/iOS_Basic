//
//  BWDataModel.h
//  MidTerm
//
//  Created by byungwoo on 2014. 8. 12..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWDataModel : NSObject 

-(NSInteger)numberOfData;
-(NSDictionary*)objectAtIndex:(NSUInteger)index;
-(void)dataSort;
-(void)removeData:(int)index;
@end

//
//  BWJson.h
//  Week2_Collection_JSON
//
//  Created by byungwoo on 2014. 7. 17..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWJson : NSObject

 -(id)MyJSONSerializationFrom:(NSString*)jsonData;
- (NSString*) MyJSONMakerWithArray:(NSArray*)array;
- (NSString*) MyJSONMakerWithDictionary:(NSDictionary*)dictionary;
@end

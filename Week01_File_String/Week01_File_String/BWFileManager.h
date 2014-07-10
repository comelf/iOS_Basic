//
//  BWFileManager.h
//  Week01_File_String
//
//  Created by byungwoo on 2014. 7. 10..
//  Copyright (c) 2014년 next. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWFileManager : NSObject

-(void) displayAllFilesAtPath:(NSString*)path;
-(NSArray*) allFilesAtPath:(NSString*)path;
-(BOOL) isExistFilename:(NSString*)filename atPath:(NSString*)path;
@end

//
//  BWFileManager.m
//  Week01_File_String
//
//  Created by byungwoo on 2014. 7. 10..
//  Copyright (c) 2014년 next. All rights reserved.
//

#import "BWFileManager.h"

@implementation BWFileManager
{
    NSFileManager* fileManager;
}
-(id)init
{
    self = [super init];
    if(self){
        fileManager = [[NSFileManager alloc] init];
    }
    return self;
}
-(void) displayAllFilesAtPath:(NSString*)path
{
   
    NSURL *directoryURL = [NSURL URLWithString:path];
    
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:nil];
    
    for (NSURL *url in enumerator) {
        NSNumber *isDirectory = NO;
        if (! [isDirectory boolValue]) {
//            NSLog(@"file : %@",url);
            NSString* fileName = [url.path lastPathComponent];
            NSLog(fileName);
        }
    }
}
-(BOOL) isExistFilename:(NSString*)filename atPath:(NSString*)path
{
    NSArray* arr = [self allFilesAtPath:path];
    
    for (NSString* file in arr) {
        if ([file isEqualTo:filename]) {
            return YES;
        }
    }
    return NO;
}

-(NSArray*) allFilesAtPath:(NSString*)path
{
    return [fileManager contentsOfDirectoryAtPath:path error:NULL];
}


//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"== %@", filename];
//return [predicate evaluateWithObject:arr];

//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'png'"];
//for (NSURL *fileURL in [contents filteredArrayUsingPredicate:predicate]) {
//    // Enumerate each .png file in directory
//}
@end

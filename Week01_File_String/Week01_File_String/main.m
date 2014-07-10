//
//  main.m
//  Week01_File_String
//
//  Created by byungwoo on 2014. 7. 10..
//  Copyright (c) 2014년 next. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWFileManager.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        BWFileManager* fm = [[BWFileManager alloc]init];
        
        // Mission 1 : 특정 디렉터리 내부 뒤지기
        NSLog(@"Mission 1");
        
        //찾고 싶으 경로 설정
        NSString* path =  [[NSBundle mainBundle] bundlePath];
        [fm displayAllFilesAtPath:path];
        
        
        // Mission 2 : File Matcher 구현
        NSLog(@"Mission 2");
        
        NSString* filename = @".git";
        BOOL isExist = [fm isExistFilename:(NSString*)filename atPath:(NSString*)path];
        
        
        if(isExist){
            NSLog(@"%@ 에 %@ 파일이 존재합니다.",path,filename);
        }else{
            NSLog(@"%@ 에 %@ 파일이 존하지 않음.",path,filename);
        }
        
    }
    return 0;
}






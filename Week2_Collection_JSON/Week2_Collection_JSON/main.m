//
//  main.m
//  Week2_Collection_JSON
//
//  Created by byungwoo on 2014. 7. 17..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWJson.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString* sample1 = @"{ “id” : 007, “name” : “james”, “weapons” : [ gun, pen ] }";
        NSString* sample2 = @"[ { “id”: “001”, “name” : “john” },{ “id”: “007”, “name” : “james” } ]";
        
        BWJson* json = [[BWJson alloc]init];
        
        //#1. JSON Serialization
        NSDictionary* dic = (NSDictionary*) [json MyJSONSerializationFrom:sample1];
        NSArray* arr      = [json MyJSONSerializationFrom:sample2];
        
        NSLog(@"%@",dic);
        NSLog(@"%@",arr);
        
        
        NSArray* array = [[NSArray alloc]initWithObjects:@"aaa",@"bbb",@"ccc",@"ddd", nil];
        NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", @"key3", nil];
        NSArray *objs = [NSArray arrayWithObjects:@"obj1", @"obj2", @"obj3", nil];
        NSDictionary* dictionary = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        //#2. JSON 문자열 만들기
        NSString* result1 = [json MyJSONMakerWithArray:array];
        NSString* result2 = [json MyJSONMakerWithDictionary:dictionary];
        NSLog(@"%@", result1);
        NSLog(@"%@", result2);
        
    }
    return 0;
}


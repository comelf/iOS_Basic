//
//  BWJson.m
//  Week2_Collection_JSON
//
//  Created by byungwoo on 2014. 7. 17..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWJson.h"

#define ARRAY 1
#define DICTIONARY 2
#define COMMA 3
#define DATA 4

@implementation BWJson


-(id)MyJSONSerializationFrom:(NSString*)jsonData
{
    NSString* data  = [self trim:jsonData];
    int type        = [self typeCheck:data];
    
    if ( type == DICTIONARY ) {
        NSDictionary* dic = [[NSDictionary alloc] initWithDictionary:[self dicParsing:data]];
        return dic;
    }else if( type == ARRAY ){
        NSArray* arr = [[NSArray alloc] initWithArray:[self arrParsing:data]];
        return arr;
    }
    
    NSLog(@"알수없는 형식입니다.");
    return nil;
}




- (NSDictionary*) dicParsing:(NSString*)origin
{
    NSString* data = [self splitOneChar:origin];
    NSMutableDictionary* mDic = [[NSMutableDictionary alloc]init];
    
    while (![data isEqualToString:@""]) {
        
        data = [self trim:data];
        NSRange keyRange = [data rangeOfString:@":"];
        NSString* key    = [data substringToIndex:keyRange.location];
        data             = [data substringFromIndex:keyRange.location+1];
        
        data = [self trim:data];
        int type = [self typeCheck:data];
        
        if (type == DICTIONARY) {
            NSRange range = [data rangeOfString:@"}"];
            NSString* spt = [data substringToIndex:range.location];
            data          = [data substringFromIndex:range.location+1];
            NSDictionary* dic = [self dicParsing:spt];
            [mDic setObject:dic forKey:key];
            
        }else if(type == ARRAY){
            NSRange range = [data rangeOfString:@"]"];
            NSString* spt = [data substringToIndex:range.location];
            data          = [data substringFromIndex:range.location+1];
            NSArray* arr  = [self arrParsing:spt];
            [mDic setObject:arr forKey:key];
        }else if(type == COMMA){
            data          = [data substringFromIndex:1];
        }else{
            NSRange valueRange = [data rangeOfString:@","];
            
            if(valueRange.location < data.length){
                NSString* value = [data substringToIndex:valueRange.location];
                data = [data substringFromIndex:valueRange.location+1];
                [mDic setObject:value forKey:key];
            }else{

                NSString* value = data;
                data = @"";
                [mDic setObject:value forKey:key];
            }
        }
        
        
    }
    
    return [NSDictionary dictionaryWithDictionary: mDic];
}
- (NSArray*) arrParsing:(NSString*)origin
{
    NSString* data = [self splitOneChar:origin];
    
    NSMutableArray* mArr = [[NSMutableArray alloc]init];
    NSUInteger end = data.length;
    
    while (![data isEqualToString:@""]) {
        data = [self trim:data];
        NSRange valueRange;
        NSString* value = @"";
        
        int type = [self typeCheck:data];
        
        if (type == DICTIONARY) {
            NSRange range = [data rangeOfString:@"}"];
            NSString* spt = [data substringToIndex:range.location];
            data          = [data substringFromIndex:range.location+1];
            NSDictionary* dic = [self dicParsing:spt];
            [mArr addObject:dic];
        }else if(type == ARRAY){
            NSRange range = [data rangeOfString:@"]"];
            NSString* spt = [data substringToIndex:range.location];
            data          = [data substringFromIndex:range.location+2];
            NSArray* arr  = [self arrParsing:spt];
            [mArr addObject:arr];
        }else if(type == COMMA){
            data          = [data substringFromIndex:1];
        }else{
            valueRange = [data rangeOfString:@","];
            if(valueRange.location<end){
                value = [data substringToIndex:valueRange.location];
                data = [data substringFromIndex:valueRange.location+1];
                [mArr addObject:value];
            }else{
                value = data;
                data = @"";
                [mArr addObject:value];
            }
            
        }
    }
    
    return [NSArray arrayWithArray:mArr];
}




- (int)typeCheck:(NSString*)String
{
    NSString* type = [String substringToIndex:1];
    if ([type isEqualToString:@"{"]) {
        return DICTIONARY;
    }else if([type isEqualToString:@"["]){
        return ARRAY;
    }else if([type isEqualToString:@","]){
        return COMMA;
    }else{
        return DATA;
    }
}
- (NSString*)trim:(NSString*)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString*)splitOneChar:(NSString*)string
{
    string = [self trim:string];
    long end = string.length-2;
    return [string substringWithRange:NSMakeRange(1, end)];
}



- (NSString*) MyJSONMakerWithArray:(NSArray*)array
{
    
    NSString* result = @"[";
    NSString* last = array.lastObject;
    for (NSString* value in array) {
        
        if(![value isEqualToString:last]){
            result = [result stringByAppendingFormat:@"%@, ", value];
        }else{
            result = [result stringByAppendingFormat:@"%@]",value];
        }
        
    }
    
    return result;
}
- (NSString*) MyJSONMakerWithDictionary:(NSDictionary*)dictionary
{
    NSUInteger count = [dictionary count];
    NSUInteger now = 0;
    
    NSString* result = @"{";
    //NSString* last = dictionary.;
    
    for (NSString* key in dictionary) {
        now ++;
        if(now <count){
            NSString* value = [dictionary objectForKey:key];
            result = [result stringByAppendingFormat:@"%@ : %@, ",key, value];
        }else{
            NSString* value = [dictionary objectForKey:key];
            result = [result stringByAppendingFormat:@"%@ : %@}",key, value];
        }

    }
    
    
    return result;
}



@end

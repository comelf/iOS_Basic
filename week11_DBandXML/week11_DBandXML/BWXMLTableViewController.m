//
//  BWXMLTableViewController.m
//  week11_DBandXML
//
//  Created by byungwoo on 2014. 9. 18..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWXMLTableViewController.h"

@interface BWXMLTableViewController ()
{
    sqlite3* database;
    sqlite3_stmt *statment;
    NSArray* arr;
    NSMutableArray* parserArr;
    NSMutableDictionary* parserDic;
    NSMutableString* currentStringValue;
    NSString* currentKey;
}

@end

@implementation BWXMLTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(sqlite3_open([[self filePath] UTF8String],&database)!= SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Database failed to open");
    }
    
    NSURL* url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [xmlParser setDelegate:self];
    parserArr = [[NSMutableArray alloc] init];
    [xmlParser parse];
    
    NSLog(@"%@",parserArr);
}

-(NSString*)filePath
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"newsfeed.db"];
}

//Start Element를 만났을때
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {

    currentKey = nil;
    currentStringValue = nil;
    
    if([elementName isEqualToString:@"item"]) {
        parserDic = [[NSMutableDictionary alloc] init];
        return;
    }else if([elementName isEqualToString:@"title"]){
        currentKey = elementName;
        return;
    }else if ([elementName isEqualToString:@"link"]){
        currentKey = elementName;
        return;
    }else if ([elementName isEqualToString:@"description"]){
        currentKey = elementName;
        return;
    }else if ([elementName isEqualToString:@"pubDate"]){
        currentKey = elementName;
        return;
    }
}

//End Element를 만났을때
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"item"]){
        [parserArr addObject:parserDic];
        [self insertNewsfeed:parserDic];
        parserDic = nil;
        return;
    }else if([elementName isEqualToString:@"title"]){
        [parserDic setObject:currentStringValue forKey:currentKey];
        return;
    }else if ([elementName isEqualToString:@"link"]){
        [parserDic setObject:currentStringValue forKey:currentKey];
        return;
    }else if ([elementName isEqualToString:@"description"]){
        [parserDic setObject:currentStringValue forKey:currentKey];
        return;
    }else if ([elementName isEqualToString:@"pubDate"]){
        [parserDic setObject:currentStringValue forKey:currentKey];
        return;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(currentKey){
        if(!currentStringValue){
            currentStringValue = [[NSMutableString alloc] init];
        }
        [currentStringValue appendString:string];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (BOOL)insertNewsfeed:(NSDictionary*)data
{
    NSString* title     = [data objectForKey:@"title"];
    NSString* link      = [data objectForKey:@"link"];
    NSString* desc      = [data objectForKey:@"description"];
    NSString* pub       = [data objectForKey:@"pubDate"];
    
    NSString *sql= [NSString stringWithFormat:@"INSERT INTO tbl_newsfeed ('%@','%@','%@','%@') VALUES ('%@','%@', '%@', '%@');",@"title",@"link",@"description",@"pubDate", title,link,desc,pub];
    char *err;
    if (sqlite3_exec(database,[sql UTF8String],NULL,NULL,&err)!=SQLITE_OK){
        NSAssert(0,@"Could not insert data");
        return NO;
    }
    return YES;
}



@end

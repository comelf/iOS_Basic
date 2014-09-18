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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

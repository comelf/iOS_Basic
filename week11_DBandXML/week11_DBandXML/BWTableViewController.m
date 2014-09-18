//
//  BWTableViewController.m
//  week11_DBandXML
//
//  Created by byungwoo on 2014. 9. 18..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWTableViewController.h"

@interface BWTableViewController ()
{
    sqlite3* database;
    sqlite3_stmt *statment;
    NSArray* arr;
}
@end

@implementation BWTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(sqlite3_open([[self filePath] UTF8String],&database)!= SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Database failed to open");
    }else{
        arr = [self selectAll];
    }
    
    NSLog(@"%@",arr);
}

-(NSString*)filePath
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"top25.db"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//(id integer primary key, title text, category text, image text);
- (NSArray*)selectAll
{
    NSString *sql= @"SELECT * FROM tbl_songs;";
    
    sqlite3_prepare(database, [sql UTF8String], sql.length, &statment, nil);
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    while (sqlite3_step(statment)==SQLITE_ROW) {
        int aField0     = sqlite3_column_int(statment, 0);
        char* aField1   = (char*)sqlite3_column_text(statment, 1);
        char* aField2   = (char*)sqlite3_column_text(statment, 2);
        char* aField3   = (char*)sqlite3_column_text(statment, 3);
        
        NSNumber *Field0int  = [NSNumber numberWithInt:aField0];
        NSString *Field1Text = [NSString stringWithCString:aField1 encoding:NSUTF8StringEncoding];
        NSString *Field2Text = [NSString stringWithCString:aField2 encoding:NSUTF8StringEncoding];
        NSString *Field3Text = [NSString stringWithCString:aField3 encoding:NSUTF8StringEncoding];
        
        NSDictionary *record = [[NSDictionary alloc] initWithObjectsAndKeys:Field0int,@"id",
                                Field1Text,@"title",
                                Field2Text,@"category",
                                Field3Text,@"image", nil];
        [array addObject:record];
    }
    return array;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(arr==nil)
        return 0;
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary* data = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text =[data objectForKey:@"title"];
    cell.detailTextLabel.text = [data objectForKey:@"category"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* data = [arr objectAtIndex:indexPath.row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[data objectForKey:@"image"]]];
}
@end

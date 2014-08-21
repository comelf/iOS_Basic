//
//  BWViewController.m
//  MidTerm
//
//  Created by byungwoo on 2014. 8. 12..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWAlbumViewController.h"
#import "BWPhotoViewController.h"

@interface BWAlbumViewController ()
{
    NSArray* dataArr;
}
@end

@implementation BWAlbumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    _dataModel = [[BWDataModel alloc] init];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(dataLoadCompleted:) name:@"dataLoad" object:nil];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(dataSort:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataLoadCompleted :(NSNotification *)notification
{
    [self.tableView reloadData];
}

-(IBAction)dataSort:(id)sender
{
    [_dataModel dataSort];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        _dataModel = [[BWDataModel alloc] init];
    }
}

#pragma mark - DataSource

-(NSInteger)tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataModel numberOfData];
}



-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = [_dataModel objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSURL *url = [NSURL URLWithString:[item objectForKey:@"image"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection* con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"date"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        NSDictionary* item = [_dataModel objectAtIndex:ip.row];
        BWPhotoViewController* photoViewController = [segue destinationViewController];
        [photoViewController sendData:item];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_dataModel removeData:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    
    UIImage* image = [[UIImage alloc] initWithData:data];
    
    NSString* fath = [self getFileData:@"qqq"];
    NSLog(@"%@",fath);
}

- (NSString *)getFileData: (NSString *)fileDirPath
{
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *myPath    = [myPathList  objectAtIndex:0];
    NSError *err        = nil;
    NSString *fData     = @"";
    
    myPath = [myPath stringByAppendingPathComponent:fileDirPath];
    if([[NSFileManager defaultManager] fileExistsAtPath:myPath])
    {
        fData = [NSString stringWithContentsOfFile:myPath encoding:NSUTF8StringEncoding error:&err];
        if(err) NSLog(@"getFileData() - ERROR: %@",[err localizedDescription]);
    }
    else
    {
        NSLog(@"getFileData() - ERROR: This file '%@' does not exist",myPath);
    }
    return fData;
}

@end

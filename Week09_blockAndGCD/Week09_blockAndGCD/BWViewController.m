//
//  BWViewController.m
//  Week09_blockAndGCD
//
//  Created by byungwoo on 2014. 9. 2..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWViewController.h"
#include <mach/mach_time.h>
@interface BWViewController ()
{
    NSMutableData *responseData;
    NSString* bookfile;
}
@end

@implementation BWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_firstButton setBackgroundColor:[UIColor grayColor]];
    [_firstButton setTitle:@"first" forState:UIControlStateNormal];
    

    bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                  pathForResource:@"bookfile" ofType:@".txt"]
                                         encoding:NSUTF8StringEncoding error:nil];
    
    NSUInteger count = [self countOfSubstring:@" " atContents:bookfile];
    
    NSLog(@"count = %d",count);
    
    
    
    responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://125.209.194.123/wordlist.php"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents
{
    int count = 0;
    unichar contentsChar, substringChar;
    
    substringChar = [substring characterAtIndex:0];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i =0; i<contents.length; i++) {
        contentsChar = [contents characterAtIndex:i];
        if (substringChar == contentsChar) {
            NSNumber *location = [NSNumber numberWithInt:i];
            [arr addObject: location];
        }
    }
    
    for (NSNumber *a in arr) {
        NSRange range;
        range.location = [a intValue];
        range.length = substring.length;
        NSString* temp =[contents substringWithRange:range];
        
        if([temp isEqual:substring]){
            count++;
        }
    }
    
    return count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)firstButtonClick:(id)sender {
    
    CGRect origin     = [sender frame];
    CGRect temp       = [sender frame];
//    temp.origin.x    += 100;
    temp.origin.y    += 300;
//    temp.size.width  += 50;
//    temp.size.height -= 50;
    
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [sender setBackgroundColor:[UIColor yellowColor]];
                         [sender setFrame:temp];
                         [sender setTitle:@"clicked" forState:UIControlStateNormal];
                         [sender setAlpha:0.5f];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              [sender setBackgroundColor:[UIColor grayColor]];
                                              [sender setFrame:origin];
                                              [sender setTitle:@"first" forState:UIControlStateNormal];
                                              [sender setAlpha:1.0f];
                                          }];
                     }];
}


- (IBAction)bookButtonClicked:(id)sender {
    _progress.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}

-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"] encoding:NSUTF8StringEncoding error:nil];
    int length = bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;
        
        dispatch_sync(mainQueue, ^{
            _progress.progress = progress;
        });
        
    }
    
    dispatch_sync(mainQueue, ^{
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });

}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    NSError *myError = nil;
    NSArray *wordList = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    [self wordListCount:wordList];
}

- (void) wordListCount:(NSArray*)list
{
    NSDate *date = [NSDate date];
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    
    dispatch_group_t group = dispatch_group_create();
    for (NSString* word in list){
        dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
            NSNumber* wordCount = [NSNumber numberWithInt:[self countOfSubstring:word atContents:bookfile]];
            [dic setObject:wordCount forKey:word];
        });
    }
    
    dispatch_group_notify(group,dispatch_get_main_queue(), ^ {
        NSString* maxCountWord;
        int maxCount = 0;
        NSString* minCountWord;
        int minCount = 999999;
        
        for (NSString* key in dic) {
            NSNumber* count = [dic objectForKey:key];
            if (maxCount < [count intValue]) {
                maxCountWord = key;
                maxCount = [count intValue];
            }
            if (minCount > [count intValue]) {
                minCountWord = key;
                minCount = [count intValue];
            }
        }
        
        NSLog(@"END - %@, 걸린시간 : %f초", @"doAction", 0 - [date timeIntervalSinceNow]);
        NSLog(@"max = %@ : %d", maxCountWord, maxCount);
        NSLog(@"min = %@ : %d", minCountWord, minCount);
        
        
        NSString* msg = [NSString stringWithFormat:@"가장 많은 단어 [%@] %d회\n 가장 작은 단어 [%@] %d회", maxCountWord, maxCount, minCountWord, minCount];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"결과"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    });
}
@end

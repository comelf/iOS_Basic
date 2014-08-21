//
//  BWDetailViewController.m
//  Week07_CFStreamSocket
//
//  Created by byungwoo on 2014. 8. 21..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWDetailViewController.h"

@interface BWDetailViewController ()
{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}
- (void)configureView;
@end

@implementation BWDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self readRequestToServer:@"127.0.0.1"];
    
    [self configureView];
}


-(void)readRequestToServer:(NSString*)hostAddress
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)hostAddress, 8000, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}


#pragma mark - NSStreamDelegate

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	switch (streamEvent) {
            
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
			break;
            
		case NSStreamEventHasBytesAvailable:
            
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len=0;
                
                int maxSize= 0;
                
                len = [inputStream read:buffer maxLength:8];
                if (len > 0) {
                    
                    NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                    maxSize = [output intValue];
                    
                    if (nil != output) {
                        NSLog(@"server : %@", output);
                    }
                }
                
                NSMutableData *imgData = [[NSMutableData alloc] init];

                while ([inputStream hasBytesAvailable] && ( 0 < maxSize)) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        [imgData appendBytes:buffer length:len];
                        maxSize -= 1024;
                    }
                }
                
                UIImage *image = [UIImage imageWithData:imgData];
                [_detailImage setImage:image ];
                
                NSString *ack  = @"ACK";
                NSData *response = [[NSData alloc] initWithData:[ack dataUsingEncoding:NSASCIIStringEncoding]];
                [outputStream write:[response bytes] maxLength:[response length]];
            }
            
			break;
            
		case NSStreamEventErrorOccurred:
			NSLog(@"Can not connect to the host!");
			break;
            
		case NSStreamEventEndEncountered:
            
			break;
            
		default:
			NSLog(@"Unknown event");
	}
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [inputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    inputStream = nil;
    [outputStream close];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    outputStream = nil;
}

@end

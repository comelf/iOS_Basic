//
//  BWViewController.m
//  Week04_Notification
//
//  Created by byungwoo on 2014. 7. 31..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import "BWViewController.h"
#import "BWModel.h"

@interface BWViewController ()
{
    BWModel* model;
}
@end

@implementation BWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* save = [[NSUserDefaults standardUserDefaults] stringForKey:@"save"];
    if(save!=nil && ![save isEqualToString:@""]){
        [self setImageWithImageName:save];
    }
    
    model = [[BWModel alloc]init];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(imgChange:) name:@"rand" object:nil];
    
    //KVO (Key Value Observing)
    [model addObserver:self
            forKeyPath:@"KVOTest"
               options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
               context:NULL];
}

- (void)imgChange :(NSNotification *)notification
{
    NSString* result = [[notification userInfo] objectForKey:@"result"];
    [self setImageWithImageName:result];
}

- (void)setImageWithImageName:(NSString*)imgName
{
    UIImage* img = [UIImage imageNamed:imgName];
    [_imgView setImage:img];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [model randomize];
    } 
}

//KVO (Key Value Observing) 변경시 알림 받는 메서드
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
//    NSLog(@"%@ is changed from %p", keyPath, object);
//    NSLog(@"%@ changed from %@.",
//          [change objectForKey:NSKeyValueChangeNewKey],
//          [change objectForKey:NSKeyValueChangeOldKey]);
    
    if([keyPath isEqual:@"KVOTest"]){
        NSString* result = [change objectForKey:NSKeyValueChangeNewKey];
        NSLog(@"%@",result);
    }
}

@end

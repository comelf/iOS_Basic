//
//  BWViewController.h
//  MidTerm
//
//  Created by byungwoo on 2014. 8. 12..
//  Copyright (c) 2014년 nhnnext. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWDataModel.h"
@interface BWAlbumViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>


@property BWDataModel *dataModel;
@end

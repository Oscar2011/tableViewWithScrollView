//
//  KEViewController.h
//  Table With Scrollview
//
//  Created by Eduardo Carrillo Albor on 16/02/13.
//  Copyright (c) 2013 Eduardo Carrillo Albor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KETableViewDataSource.h"
#import "KETableView.h"
@interface KEViewController : UIViewController
@property (weak, nonatomic) IBOutlet KETable *table;

@end

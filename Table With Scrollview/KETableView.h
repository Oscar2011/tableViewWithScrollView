//
//  KETable.h
//  Table With Scrollview
//
//  Created by Eduardo Carrillo Albor on 16/02/13.
//  Copyright (c) 2013 Eduardo Carrillo Albor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KETableViewDataSource.h"
#import "KETableViewDelegate.h"

@interface KETable : UIView<UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIScrollView* scrollView;
@property (nonatomic, weak) id<KETableViewDataSource> dataSource;
@property (nonatomic, weak) id<KETableViewDelegate> delegate;
-(id)dequeCell;
-(void)registerClassForCells:(Class)cellClass;
-(void) reloadData;
@end

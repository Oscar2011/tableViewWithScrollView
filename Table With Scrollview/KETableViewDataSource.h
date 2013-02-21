//
//  KETableViewDataSource.h
//  Table With Scrollview
//
//  Created by Eduardo Carrillo Albor on 16/02/13.
//  Copyright (c) 2013 Eduardo Carrillo Albor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KETableViewDataSource <NSObject>
-(NSInteger)numberOfRows;
-(UIView *)cellForRow:(NSInteger)row;

@end

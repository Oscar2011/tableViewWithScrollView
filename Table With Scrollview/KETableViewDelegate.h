//
//  KETableViewDelegate.h
//  Table With Scrollview
//
//  Created by Eduardo Carrillo Albor on 19/02/13.
//  Copyright (c) 2013 Eduardo Carrillo Albor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KETableViewDelegate <NSObject>
@optional
-(void) didSelectRowAtIndex:(NSInteger)index;
-(void) willDisplayCell:(UITableViewCell*)cell;
-(CGFloat) heightForFooter;
-(CGFloat) heightForRow;
@end

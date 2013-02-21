//
//  KEViewController.m
//  Table With Scrollview
//
//  Created by Eduardo Carrillo Albor on 16/02/13.
//  Copyright (c) 2013 Eduardo Carrillo Albor. All rights reserved.
//

#import "KEViewController.h"
#import "KETableViewDelegate.h"

@interface KEViewController ()<KETableViewDataSource, KETableViewDelegate>

@end

@implementation KEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.table registerClassForCells:[UITableViewCell class]];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.backgroundColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark KETableViewDataSource
-(NSInteger)numberOfRows{
    return 25;
}

-(UIView *)cellForRow:(NSInteger)row{
    UITableViewCell * cell = [self.table dequeCell];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"Hi %d",row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}
/*
-(CGFloat)heightForRow{
    return 40.0f;
}
*/
#pragma mark KETableViewDelegate
-(void)didSelectRowAtIndex:(NSInteger)index{
    NSLog(@"Index %d",index);
}

-(void)willDisplayCell:(UITableViewCell *)cell{
    cell.backgroundColor = [UIColor purpleColor];
    cell.textLabel.textColor = [UIColor whiteColor];
}

-(CGFloat)heightForRow{
    return 40.0f;
}
@end

//
//  KETable.m
//  Table With Scrollview
//
//  Created by Eduardo Carrillo Albor on 16/02/13.
//  Copyright (c) 2013 Eduardo Carrillo Albor. All rights reserved.
//

#import "KETableView.h"

@implementation KETable{
    NSMutableSet * _reusableCell;
    Class _cellClass;
}
#pragma mark public methods
-(id)dequeCell{
    UIView * cell = [_reusableCell anyObject];
    if (cell){
        [_reusableCell removeObject:cell];
    }
    if (!cell){
        cell = [[_cellClass alloc] init];
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectRowAtIndex:)]];
    }
    return cell;
}

-(void)registerClassForCells:(Class)cellClass{
    _cellClass = cellClass;
}

-(void) reloadData{
    [_reusableCell removeAllObjects];
    [self refreshView];
}
#pragma mark constructor
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectNull];
		_scrollView.delegate = self;
        [self addSubview:_scrollView];
		_scrollView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _reusableCell = [NSMutableSet set];
    }
    return self;
}

#pragma mark private methods

-(void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame = self.frame;
    [self refreshView];
}

-(void)setDataSource:(id<KETableViewDataSource>)dataSource{
    _dataSource = dataSource;
    [_reusableCell removeAllObjects];
    [self refreshView];
}

-(void)setDelegate:(id<KETableViewDelegate>)delegate{
    _delegate = delegate;
    [_reusableCell removeAllObjects];
    [self refreshView];
}

-(void) refreshView{
	//1
    if (CGRectIsNull(_scrollView.frame)) {
        return;
    }
	//2
    CGFloat rowHeight = (_delegate && [_delegate respondsToSelector:@selector(heightForRow)])?[_delegate heightForRow] : 50.0f;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width,
                                         rowHeight * [_dataSource numberOfRows]);
	//3
    for (__weak UIView * cell in [self cellSubViews]) {
        (cell.frame.origin.y + cell.frame.size.height < _scrollView.contentOffset.y)?[self recycleCell:cell]:nil;
        (cell.frame.origin.y > _scrollView.contentOffset.y + _scrollView.frame.size.height)?[self recycleCell:cell]:nil;
    }
	//4
    int firstVisibleIndex = MAX(0, floor(_scrollView.contentOffset.y/rowHeight));
    int lastVisibleIndex = MIN([_dataSource numberOfRows], firstVisibleIndex + 1 + ceil(_scrollView.frame.size.height/rowHeight));
    NSArray * cellSubViews=[self cellSubViews];
    //5
    for (int row=firstVisibleIndex; row <lastVisibleIndex; row++) {
        UITableViewCell * cell = (UITableViewCell*)cellForRow(row, rowHeight, cellSubViews);
        if (!cell) {
            cell = (UITableViewCell*)[_dataSource cellForRow:row];
        }
        cell.frame = CGRectMake(0, row * rowHeight, _scrollView.frame.size.width, rowHeight);
        //We set the position of the row on the table.
        cell.tag = row;
        (_delegate && [_delegate respondsToSelector:@selector(willDisplayCell:)])?[_delegate willDisplayCell:cell]:nil;
        //Delegate exist and implements the optional method of willDisplayCell, the method is called.
        [_scrollView insertSubview:cell atIndex:0]; //Add the row.
    }
}

-(NSArray*)cellSubViews{
    NSMutableArray * cells = [@[] mutableCopy];
    for ( UIView * view in _scrollView.subviews)
        [view isKindOfClass:_cellClass]?[cells addObject:view]:nil;
    return cells;
}

-(void)recycleCell:(UIView*)view{
    [_reusableCell addObject:view];
    [view removeFromSuperview];
}

UIView * cellForRow(int index, CGFloat rowHeight, NSArray * subviews){
    float topEdgeRow = index * rowHeight;
    for (UIView * view in subviews) {
        if (view.frame.origin.y == topEdgeRow) {
            return view;
        }
    }
    return nil; 
}

#pragma mark KETableViewDelegate
-(void)didSelectRowAtIndex:(id)sender{
    UITapGestureRecognizer * recognizer = sender;
    (_delegate && [_delegate respondsToSelector:@selector(didSelectRowAtIndex:)])?[_delegate didSelectRowAtIndex:recognizer.view.tag]:nil;
    
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self refreshView];
}
@end

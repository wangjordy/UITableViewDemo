//
//  ViewController.m
//  UITableViewDemo
//
//  Created by jordy on 13-7-24.
//  Copyright (c) 2013年 bitcar. All rights reserved.
//

#import "ViewController.h"
#import "CustomerCell.h"

@interface ViewController ()
{
    CGFloat oldOffsetY;
    BOOL dragFlag;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [rootTableView setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    [rootTableView setScrollIndicatorInsets:UIEdgeInsetsMake(100, 0, 0, 0)];
}



#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *cellIndentifier = @"CustomerCellIndentifier";
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

#pragma mark -
#pragma mark ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    oldOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
        
    CGFloat endDragOffsetY = scrollView.contentOffset.y;
    
    dragFlag = (endDragOffsetY - oldOffsetY > 50) ? NO : YES;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    if (oldOffsetY - currentOffsetY > 50 && dragFlag){
        //向上滚动---显示出menu
        [self showMenuViewAnimation];
    }
    
    if (!scrollView.tracking) {
        return;
    }
    
    if (currentOffsetY - oldOffsetY > 50) {
        //向下滚动---menu收回
        [self scrollUpMenuHiddenAnimation];
    }
}

//显示一级菜单与tableview
- (void)showMenuViewAnimation
{
    CGRect menuRect = firstMenuView.frame;
    menuRect.size.height = 50;
    [UIView animateWithDuration:0.3f animations:^{
        [firstMenuView setFrame:menuRect];
        [rootTableView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
        [rootTableView setScrollIndicatorInsets:UIEdgeInsetsMake(50, 0, 0, 0)];
    } completion:^(BOOL finished) {
    }];
    
}

//向上隐藏一级和二级导航条
- (void)scrollUpMenuHiddenAnimation
{
    //如果是tableView滚动的，隐藏一级二级菜单目录
    if ([showSubButton isSelected]) {
        [UIView animateWithDuration:0.3f animations:^{
            [self hiddenSubMenuView];
        } completion:^(BOOL finished) {
            [showSubButton setSelected:NO];
            //开始隐藏一级菜单
            [self hiddenMenuViewAnimation];
        }];
        
    }else if (firstMenuView.frame.size.height>0){
        //隐藏一级菜单
        [self hiddenMenuViewAnimation];
    }
}

#pragma mark -
#pragma mark 二级菜单显示与隐藏
//隐藏
- (void)hiddenSubMenuView
{
    //默认二级菜单是收回状态
    CGRect subMenuViewRect = subMenuView.frame;
    subMenuViewRect.size.height = 0;
    [subMenuView setFrame:subMenuViewRect];
    //table的变长
    [rootTableView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
    [rootTableView setScrollIndicatorInsets:UIEdgeInsetsMake(49, 0, 0, 0)];
}
//显示
- (void)showSubMenuView
{
    CGRect subMenuViewRect = subMenuView.frame;
    subMenuViewRect.size.height = 50;
    [subMenuView setFrame:subMenuViewRect];
    
    [rootTableView setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    [rootTableView setScrollIndicatorInsets:UIEdgeInsetsMake(100, 0, 0, 0)];
}

//隐藏一级菜单与tableview
- (void)hiddenMenuViewAnimation
{
    CGRect menuRect = firstMenuView.frame;
    CGFloat height = menuRect.size.height;
    
    if (height<50) {
        return;  //表示当前已经开始隐藏的动画
    }
    menuRect.size.height = 0;
    [UIView animateWithDuration:0.3f animations:^{
        [firstMenuView setFrame:menuRect];
        [rootTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [rootTableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }];
}


//显示隐藏二级菜单的button响应事件
- (IBAction)onShowSubMenuButtonClick:(id)sender
{
    if (![showSubButton isSelected]) {
        //显示二级菜单
        [self showSubMenuViewAnimate];
    }else if ([showSubButton isSelected]){
        //隐藏二级菜单
        [self hiddenSubMenuViewAnimate];
    }
}

- (void)showSubMenuViewAnimate
{
    [UIView animateWithDuration:0.3f animations:^{
        [self showSubMenuView];
    } completion:^(BOOL finished) {
        [showSubButton setSelected:YES];
    }];
}

- (void)hiddenSubMenuViewAnimate
{
    //显示二级菜单--->未显示二级菜单
    [UIView animateWithDuration:0.3f animations:^{
        [self hiddenSubMenuView];
    } completion:^(BOOL finished) {
        [showSubButton setSelected:NO];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

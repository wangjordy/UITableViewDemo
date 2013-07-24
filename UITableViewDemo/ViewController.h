//
//  ViewController.h
//  UITableViewDemo
//
//  Created by 王兴朝 on 13-7-24.
//  Copyright (c) 2013年 bitcar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *rootTableView;
    
    __weak IBOutlet UIView *firstMenuView;   //一级菜单

    __weak IBOutlet UIButton *showSubButton;  //显示隐藏二级菜单的按钮
    
    __weak IBOutlet UIView *subMenuView;
    
}
@end

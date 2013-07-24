//
//  CustomerCell.m
//  UITableViewDemo
//
//  Created by jordy on 13-7-24.
//  Copyright (c) 2013年 bitcar. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

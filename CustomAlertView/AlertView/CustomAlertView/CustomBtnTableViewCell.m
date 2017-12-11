//
//  CustomBtnTableViewCell.m
//  AlertView
//
//  Created by Fangjw on 2017/12/8.
//  Copyright © 2017年 Fangjw. All rights reserved.
//

#import "CustomBtnTableViewCell.h"

@interface CustomBtnTableViewCell()

@property (nonatomic, strong) UIColor *separatorTextColor;

@end

@implementation CustomBtnTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)updateCell:(NSString *)cellText{
    self.textLabel.text=cellText;
    self.textLabel.textAlignment=NSTextAlignmentCenter;
}

-(UIView *)setLineView{
    UIView *lineView=[UIView new];
    lineView.backgroundColor=_separatorTextColor;
    return lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

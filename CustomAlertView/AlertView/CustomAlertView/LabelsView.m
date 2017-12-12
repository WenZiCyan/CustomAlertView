//
//  LabelsView.m
//  AlertView
//
//  Created by Fangjw on 2017/11/28.
//  Copyright © 2017年 Fangjw. All rights reserved.
//

#import "LabelsView.h"
#import <Masonry/Masonry.h>

@interface LabelsView()

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UILabel *centerLabel;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation LabelsView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    return self;
}

-(void)updateLabelsView:(LabelsViewType)type lLabelStr:(NSString *)lLabelStr cLabelStr:(NSString *)cLabelStr rLabelStr:(NSString *)rLabelStr{
    
    self.leftLabel=[UILabel new];
    self.leftLabel.textAlignment=NSTextAlignmentLeft;
    self.leftLabel.font=[UIFont systemFontOfSize:14];
    self.leftLabel.text=lLabelStr;
    [self addSubview:self.leftLabel];
    
    if (type==LabelsViewTypeOne) {
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }else if (type==LabelsViewTypeTwo){
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.left.equalTo(self).offset(10);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.rightLabel=[UILabel new];
        self.rightLabel.font=[UIFont systemFontOfSize:14];
        self.rightLabel.text=rLabelStr;
        [self addSubview:self.rightLabel];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }else if (type==LabelsViewTypeThree){
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.left.equalTo(self).offset(10);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.rightLabel=[UILabel new];
        self.rightLabel.font=[UIFont systemFontOfSize:14];
        self.rightLabel.text=rLabelStr;
        [self addSubview:self.rightLabel];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.centerLabel=[UILabel new];
        self.centerLabel.font=[UIFont systemFontOfSize:14];
        self.centerLabel.text=cLabelStr;
        [self addSubview:self.centerLabel];
        
        [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.left.equalTo(self.leftLabel.mas_right).offset(10);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
}
@end

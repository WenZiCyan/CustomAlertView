//
//  LabelsView.h
//  AlertView
//
//  Created by Fangjw on 2017/11/28.
//  Copyright © 2017年 Fangjw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LabelsViewType) {
    LabelsViewTypeOne   = 0,
    LabelsViewTypeTwo   = 1
};

@interface LabelsView : UIView

-(void)updateLabelsView:(LabelsViewType)type lLabelStr:(NSString *)lLabelStr rLabelStr:(NSString *)rLabelStr;

@end

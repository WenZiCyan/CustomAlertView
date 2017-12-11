//
//  CustomAlertView.m
//  AlertView
//
//  Created by Fangjw on 2017/12/8.
//  Copyright © 2017年 Fangjw. All rights reserved.
//

#import "CustomAlertView.h"
#import <Masonry/Masonry.h>
#import "UIImage+Tint.h"
#import "CustomBtnTableViewCell.h"
#import "LabelsView.h"

#define HEIGHTOFSCREEN [[UIScreen mainScreen] bounds].size.height
#define WIDTHOFSCREEN [[UIScreen mainScreen] bounds].size.width

#define Cell_Id @"CustomBtnTableViewCell"

@interface CustomAlertView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    CGFloat tipViewWidth;
    CGFloat totalHeight;
    CGFloat topHeight;
    CGFloat centerHeight;
    CGFloat bottomHeight;
    
    BOOL haveTextField;
}

@property (readwrite) NSString         *title;
@property (readwrite) NSString         *message;
@property (readwrite) NSString         *content;
@property (readwrite) NSArray          *lContentTitles;
@property (readwrite) NSArray          *rContentTitles;
@property (readwrite) NSArray          *buttonTitles;

@property (readwrite) NSMutableDictionary    *textDictionary;

@property (strong, nonatomic) UIView         *backView;

@property (strong, nonatomic) UIView         *tipView;

@property (strong, nonatomic) UIView         *topView;

@property (strong, nonatomic) UIScrollView   *scrollerView;

@property (strong, nonatomic) UITextField    *textField;

@property (strong, nonatomic) UIView         *buttomView;

@property (strong, nonatomic) UITableView    *buttomTableView;

@property (strong, nonatomic) UIView         *lineView;

@property (assign, nonatomic) NSUInteger     numberOfControl;

@property (copy, nonatomic) CustomAlertViewControlSetupHandler controlSetupHandler;

@property (strong, nonatomic) UILabel        *titleLabel;

@property (strong, nonatomic) UILabel        *messageLabel;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (strong, nonatomic) UILabel        *contentLabel;

@property (copy, nonatomic) CustomAlertViewLabelSetupHandler labelSetupHandler;

@property (assign, nonatomic) NSUInteger numberOfTextFields;

@property (copy, nonatomic) CustomAlertViewTextFieldsSetupHandler textFieldsSetupHandler;

@end

@implementation CustomAlertView

- (nonnull instancetype)initWithUserDefinedAlertView:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                     numberOfControl:(NSUInteger)numberOfControl
                                 controlSetupHandler:(CustomAlertViewControlSetupHandler)controlSetupHandler
                                        buttonTitles:(nullable NSArray<NSString *> *)buttonTitles{
    self=[super init];
    self.title=title;
    self.message=message;
    self.numberOfControl=numberOfControl;
    self.controlSetupHandler=controlSetupHandler;
    self.buttonTitles=buttonTitles.mutableCopy;
    [self initDefaults];
    return self;
}

- (nonnull instancetype)initWithContentAndTitle:(nullable NSString *)title
                                        message:(nullable NSString *)message
                                        content:(nullable NSString *)content
                              labelSetupHandler:(CustomAlertViewLabelSetupHandler)labelSetupHandler
                                   buttonTitles:(nullable NSArray<NSString *> *)buttonTitles{
    self=[self initWithUserDefinedAlertView:title message:message numberOfControl:1 controlSetupHandler:nil buttonTitles:buttonTitles];
    if (self) {
        self.content=content;
        self.labelSetupHandler=labelSetupHandler;
    }
    return self;
}

- (nonnull instancetype)initWithContentsImgAndTitle:(nullable NSString *)title
                                            message:(nullable NSString *)message
                                     lContentTitles:(nullable NSArray<NSString *> *)lContentTitles
                                     rContentTitles:(nullable NSArray<NSString *> *)rContentTitles
                                       buttonTitles:(nullable NSArray<NSString *> *)buttonTitles{
    self=[self initWithUserDefinedAlertView:title message:message numberOfControl:1 controlSetupHandler:nil buttonTitles:buttonTitles];
    if (self) {
        self.lContentTitles=lContentTitles;
        self.rContentTitles=rContentTitles;
    }
    return self;
}

- (nonnull instancetype)initWithSendSecurityCodeAndTitle:(nullable NSString *)title
                                                 message:(nullable NSString *)message
                                      numberOfTextFields:(NSUInteger)numberOfTextFields
                                  textFieldsSetupHandler:(CustomAlertViewTextFieldsSetupHandler)textFieldsSetupHandler
                                            buttonTitles:(nullable NSArray<NSString *> *)buttonTitles{
    self=[self initWithUserDefinedAlertView:title message:message numberOfControl:1 controlSetupHandler:nil buttonTitles:buttonTitles];
    if (self) {
        self.numberOfTextFields=numberOfTextFields;
        self.textFieldsSetupHandler=textFieldsSetupHandler;
    }
    return self;
}

#pragma mark - UIAppearance

+ (instancetype)appearance {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)appearanceWhenContainedIn:(Class<UIAppearanceContainer>)ContainerClass, ... {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)appearanceForTraitCollection:(UITraitCollection *)trait {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)appearanceForTraitCollection:(UITraitCollection *)trait whenContainedIn:(Class<UIAppearanceContainer>)ContainerClass, ... {
    return [self sharedAlertViewForAppearance];
}

+ (instancetype)sharedAlertViewForAppearance {
    static CustomAlertView *alertView;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        alertView = [[CustomAlertView alloc] initAsAppearance];
    });
    
    return alertView;
}

- (nonnull instancetype)initAsAppearance {
    self = [super init];
    if (self) {
        _layerCornerRadius=15;
        _viewPadding=30;
        _internalPadding=10;
        _textFieldHeight=44;
        _centerButtonHeight=44;
        _bottomButtonHeight=44;
        _separatorThickness=1;
        
        _titleTextFont=20;
        _messageTextFont=16;
        _textFieldTextFont=16;
        _centerButtonTextFont=17;
        _centerLabelTextFont=14;
        _bottomButtonTextFont=18;
        
        _backGroundColor=[UIColor whiteColor];
        _centerBackColor=[UIColor whiteColor];
        _titleTextColor=[UIColor blackColor];
        _messageTextColor=[UIColor blackColor];
        _separatorTextColor=[UIColor lightGrayColor];
        _cancelButtonTextColor=[UIColor blackColor];
        _destructiveButtonTextColor=[UIColor blackColor];
        
        _backgroundBlurEffect=nil;
        _tipViewBlurEffect=nil;
        
        _backViewTapDismiss=NO;
        _buttomBtnHorizontal=YES;
    }
    return self;
}

-(void)initDefaults{
    CustomAlertView *arance=[CustomAlertView appearance];
    
    _layerCornerRadius=arance.layerCornerRadius;
    _viewPadding=arance.viewPadding;
    _internalPadding=arance.internalPadding;
    _textFieldHeight=arance.textFieldHeight;
    _centerButtonHeight=arance.centerButtonHeight;
    _bottomButtonHeight=arance.bottomButtonHeight;
    _separatorThickness=arance.separatorThickness;
    
    _titleTextFont=arance.titleTextFont;
    _messageTextFont=arance.messageTextFont;
    _textFieldTextFont=arance.textFieldTextFont;
    _centerButtonTextFont=arance.centerButtonTextFont;
    _centerLabelTextFont=arance.centerLabelTextFont;
    _bottomButtonTextFont=arance.bottomButtonTextFont;
    
    _backGroundColor=arance.backGroundColor;
    _centerBackColor=arance.centerBackColor;
    _titleTextColor=arance.titleTextColor;
    _messageTextColor=arance.messageTextColor;
    _separatorTextColor=arance.separatorTextColor;
    _cancelButtonTextColor=arance.cancelButtonTextColor;
    _destructiveButtonTextColor=arance.destructiveButtonTextColor;
    
    _backgroundBlurEffect=arance.backgroundBlurEffect;
    _tipViewBlurEffect=arance.tipViewBlurEffect;
    
    _backViewTapDismiss=arance.backViewTapDismiss;
    _buttomBtnHorizontal=arance.buttomBtnHorizontal;
}

-(void)createUserDefinedView{
    
    [self initBaseTopView];
    
    if (self.controlSetupHandler) {
        int btnTag=0;
        int fieldTag=0;
        for (int i=0; i<self.numberOfControl; i++) {
            
            UIView *view=[UIView new];
            view.frame=CGRectMake(0, 0, tipViewWidth, 50);
            view.backgroundColor=[UIColor whiteColor];
            
            if (self.controlSetupHandler) {
                self.controlSetupHandler(view, i);
                
                for (id obj in view.subviews) {
                    if([obj isKindOfClass:[UITextField class]]){
                        haveTextField=YES;
                        self.textField=[UITextField new];
                        self.textField=obj;
                        self.textField.delegate=self;
                        self.textField.tag=1000+fieldTag;
                        fieldTag++;
                        [self.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
                        [self.textField becomeFirstResponder];
                    }
                    if ([obj isKindOfClass:[UIButton class]]) {
                        UIButton *button=[UIButton new];
                        button=obj;
                        button.tag = 1000+btnTag;
                        btnTag++;
                        [button addTarget:self action:@selector(otherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
            }
            view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y+centerHeight, tipViewWidth, view.frame.size.height);
            [self.scrollerView addSubview:view];
            centerHeight=CGRectGetMinY(view.frame)+CGRectGetHeight(view.frame);
        }
    }
    if (self.labelSetupHandler) {
        if (self.content) {
            self.contentLabel=[UILabel new];
            self.contentLabel.text=self.content;
            self.contentLabel.numberOfLines=0;
            self.contentLabel.backgroundColor=[UIColor clearColor];
            self.contentLabel.textAlignment=NSTextAlignmentCenter;
            self.contentLabel.font=[UIFont systemFontOfSize:_centerLabelTextFont weight:UIFontWeightRegular];
            
            if(self.labelSetupHandler){
                self.labelSetupHandler(self.contentLabel);
            }
            
            CGSize titleLabelSize = [self.contentLabel sizeThatFits:CGSizeMake(tipViewWidth-_internalPadding*2, CGFLOAT_MAX)];
            CGRect titleLabelFrame = CGRectMake(_internalPadding, _internalPadding, tipViewWidth-_internalPadding*2, titleLabelSize.height);
            
            self.contentLabel.frame=titleLabelFrame;
            [self.scrollerView addSubview:self.contentLabel];
            centerHeight=CGRectGetMinY(self.contentLabel.frame)+CGRectGetHeight(self.contentLabel.frame)+_internalPadding;
        }
    }
    if ((self.lContentTitles.count>0&&!self.rContentTitles)||(self.rContentTitles.count>0&&!self.lContentTitles)) {
        for (int i=0; i<self.lContentTitles.count?self.lContentTitles.count:self.rContentTitles.count; i++) {
            LabelsView *labelsView=[[LabelsView alloc]initWithFrame:CGRectMake(_internalPadding, centerHeight, tipViewWidth-_internalPadding*2 , _centerButtonHeight)];
            [self.scrollerView addSubview:labelsView];
            [labelsView updateLabelsView:LabelsViewTypeOne lLabelStr:self.lContentTitles[i]?self.lContentTitles[i]:self.rContentTitles[i] rLabelStr:nil];
            centerHeight=CGRectGetMinY(labelsView.frame)+CGRectGetHeight(labelsView.frame)+_internalPadding;
        }
    }else if (self.lContentTitles.count>0&&self.rContentTitles.count>0){
        for (int i=0; i<self.lContentTitles.count; i++) {
            LabelsView *labelsView=[[LabelsView alloc]initWithFrame:CGRectMake(_internalPadding, centerHeight, tipViewWidth-_internalPadding*2 , _centerButtonHeight)];
            [self.scrollerView addSubview:labelsView];
            [labelsView updateLabelsView:LabelsViewTypeTwo lLabelStr:self.lContentTitles[i] rLabelStr:self.rContentTitles[i]];
            centerHeight=CGRectGetMinY(labelsView.frame)+CGRectGetHeight(labelsView.frame)+_internalPadding;
        }
    }
    if (self.numberOfTextFields) {
        haveTextField = YES;
        for (int i=0; i<self.numberOfTextFields; i++) {
            self.textField = [UITextField new];
            self.textField.font = [UIFont systemFontOfSize:_textFieldTextFont weight:UIFontWeightRegular];
            self.textField.textAlignment = NSTextAlignmentLeft;
            self.textField.adjustsFontSizeToFitWidth = YES;
            self.textField.tag=1000+i;
            self.textField.delegate=self;
            [self.textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
            if (i == self.numberOfTextFields - 1) {self.textField.returnKeyType = UIReturnKeyDone;}
            else {self.textField.returnKeyType = UIReturnKeyNext;}
            
            if (self.textFieldsSetupHandler) {self.textFieldsSetupHandler(self.textField, i);}
            
            if (i==0) {[self.textField becomeFirstResponder];}
            
            self.textField.frame=CGRectMake(_internalPadding, centerHeight, tipViewWidth-_internalPadding*2, _textFieldHeight);
            [self.scrollerView addSubview:self.textField];
            
            [self.scrollerView addSubview:[self setLineView]];
            
            centerHeight=CGRectGetMinY(self.textField.frame)+CGRectGetHeight(self.textField.frame);
            self.lineView.frame=CGRectMake(_internalPadding, centerHeight, tipViewWidth-_internalPadding*2, _separatorThickness);
        }
    }
    
    [self initCenterViewFrame];
    [self initBaseBottomView];
}

-(void)otherBtnClick:(UIButton *)btn{
    if (self.otherBlock) {
        self.otherBlock(self.textDictionary,btn);
    }
}

-(void)initBaseTopView{
    
    self.frame=CGRectMake(0, 0, WIDTHOFSCREEN, HEIGHTOFSCREEN);
    self.alpha=0.0;
    
    tipViewWidth=WIDTHOFSCREEN-_viewPadding*2;
    totalHeight=0.0;
    topHeight=0.0;
    centerHeight=0.0;
    bottomHeight=0.0;
    
    haveTextField=NO;
    self.textDictionary=[[NSMutableDictionary alloc]init];
    
    if (!self.backView) {
        self.backView=[UIView new];
        self.backView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.backView.frame=self.frame;
        self.backView.userInteractionEnabled=YES;
        
        if (_backgroundBlurEffect) {
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:_backgroundBlurEffect];
            effectView.frame =self.bounds;
            effectView.alpha=0.7;
            [self.backView addSubview:effectView];
        }
        
        [self addSubview:self.backView];
        
        if (_backViewTapDismiss) {
            if (!_tapGestureRecognizer) {
                self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView:)];
                self.tapGestureRecognizer.numberOfTapsRequired=1;
            }
            [self.backView addGestureRecognizer:self.tapGestureRecognizer];
        }
    }
    
    if (!self.tipView) {
        self.tipView=[UIView new];
        self.tipView.backgroundColor=_backGroundColor;
        self.tipView.layer.cornerRadius=_layerCornerRadius;
        self.tipView.layer.masksToBounds=YES;
        self.tipView.userInteractionEnabled = YES;
        self.tipView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if (_tipViewBlurEffect) {
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:_tipViewBlurEffect];
            effectView.frame =self.bounds;
            effectView.alpha=0.4;
            [self.tipView addSubview:effectView];
        }
        [self addSubview:self.tipView];
    }
    
    if (self.title) {
        
        if (!self.topView) {
            self.topView=[UIView new];
            [self.tipView addSubview:self.topView];
        }
        
        self.titleLabel=[UILabel new];
        self.titleLabel.text=self.title;
        self.titleLabel.numberOfLines=0;
        self.titleLabel.textColor=_titleTextColor;
        self.titleLabel.backgroundColor=[UIColor clearColor];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:_titleTextFont weight:UIFontWeightMedium];
        
        CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(tipViewWidth, CGFLOAT_MAX)];
        CGRect titleLabelFrame = CGRectMake(0, _internalPadding, tipViewWidth, titleLabelSize.height);
        self.titleLabel.frame=titleLabelFrame;
        [self.topView addSubview:self.titleLabel];
        topHeight=CGRectGetMinY(self.titleLabel.frame)+CGRectGetHeight(self.titleLabel.frame)+_internalPadding;
    }
    
    if (self.message) {
        if (!self.topView) {
            self.topView=[UIView new];
            [self.tipView addSubview:self.topView];
        }
        self.messageLabel=[UILabel new];
        self.messageLabel.text=self.message;
        self.messageLabel.numberOfLines=0;
        self.messageLabel.textColor=_messageTextColor;
        self.messageLabel.backgroundColor=[UIColor clearColor];
        self.messageLabel.textAlignment=NSTextAlignmentCenter;
        self.messageLabel.font=[UIFont systemFontOfSize:_messageTextFont weight:UIFontWeightRegular];
        
        CGSize messageLabelSize = [self.messageLabel sizeThatFits:CGSizeMake(tipViewWidth, CGFLOAT_MAX)];
        CGRect messageLabelFrame = CGRectMake(0, topHeight?topHeight:_internalPadding, tipViewWidth, messageLabelSize.height);
        self.messageLabel.frame=messageLabelFrame;
        [self.topView addSubview:self.messageLabel];
        topHeight=CGRectGetMinY(self.messageLabel.frame)+CGRectGetHeight(self.messageLabel.frame)+_internalPadding;
    }
    
    if (self.topView) {
        topHeight+=_separatorThickness;
        self.topView.frame=CGRectMake(0, 0, tipViewWidth, topHeight);
        [self.topView addSubview:[self setLineView]];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_separatorThickness));
            make.left.right.equalTo(self.topView);
            make.top.equalTo(self.topView.mas_bottom);
        }];
        totalHeight+=topHeight;
    }
    
    if (!self.scrollerView) {
        self.scrollerView=[UIScrollView new];
        self.scrollerView.backgroundColor=_centerBackColor;
        [self.tipView insertSubview:self.scrollerView atIndex:0];
    }
}

-(void)initCenterViewFrame{
    if (self.scrollerView) {
        if (!haveTextField) {
            if (centerHeight>HEIGHTOFSCREEN*0.5) {
                self.scrollerView.contentSize=CGSizeMake(tipViewWidth, centerHeight);
                centerHeight=HEIGHTOFSCREEN*0.5;
            }
            self.scrollerView.frame=CGRectMake(0, topHeight, tipViewWidth, centerHeight);
        }else{
            if (centerHeight>HEIGHTOFSCREEN*0.3) {
                self.scrollerView.contentSize=CGSizeMake(tipViewWidth, centerHeight);
                centerHeight=HEIGHTOFSCREEN*0.3;
            }
            self.scrollerView.frame=CGRectMake(0, topHeight, tipViewWidth, centerHeight);
        }
    }
    totalHeight+=centerHeight;
}

-(void)initBaseBottomView{
    if (self.buttonTitles&&!self.buttomView) {
        self.buttomView=[UIView new];
        [self.tipView addSubview:self.buttomView];
        
        [self.buttomView addSubview:[self setLineView]];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_separatorThickness));
            make.left.right.equalTo(self.buttomView);
            make.top.equalTo(self.buttomView.mas_top);
        }];
    }
    
    if (self.buttonTitles) {
        if (_buttomBtnHorizontal) {
            [self createHorizontalBtn];
        }else{
            [self createVerticalBtn];
        }
    }
    totalHeight+=self.buttomView.frame.size.height;
    self.tipView.frame=CGRectMake(self.viewPadding, (HEIGHTOFSCREEN-totalHeight)/2, tipViewWidth, totalHeight);
}

-(void)createHorizontalBtn{
    
    CGFloat btnWidth=tipViewWidth/self.buttonTitles.count;
    
    for (int i=0; i<self.buttonTitles.count; i++) {
        UIButton *button=[UIButton new];
        [button setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:_cancelButtonTextColor forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:_bottomButtonTextFont];
        button.tag = 1000+i;
   
        [button addTarget:self action:@selector(horizontalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame=CGRectMake(btnWidth*i, _separatorThickness, btnWidth , _centerButtonHeight);
        [self.buttomView addSubview:button];
        if (i>0) {
            [self.buttomView addSubview:[self setLineView]];
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(_bottomButtonHeight));
                make.width.equalTo(@(_separatorThickness));
                make.centerX.equalTo(button.mas_left);
                make.bottom.equalTo(button.mas_bottom);
            }];
        }
    }
    self.buttomView.frame=CGRectMake(0, totalHeight, tipViewWidth, _centerButtonHeight+_separatorThickness);
}
-(void)horizontalBtnClick:(UIButton *)btn{
    [self dismissView];
    if (self.horizontalBlock) {
        self.horizontalBlock(self.textDictionary,btn);
    }
}

-(void)createVerticalBtn{
    self.buttomTableView=[[UITableView alloc]initWithFrame:CGRectNull style:UITableViewStylePlain];
    self.buttomTableView.delegate=self;
    self.buttomTableView.dataSource=self;
    self.buttomTableView.bounces=NO;
    self.buttomTableView.showsVerticalScrollIndicator=NO;
    [self.buttomTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.buttomTableView setLayoutMargins:UIEdgeInsetsZero];
    self.buttomTableView.separatorColor =_separatorTextColor;
    [self.buttomTableView registerClass:[CustomBtnTableViewCell class] forCellReuseIdentifier:Cell_Id];
    [self.buttomView addSubview:self.buttomTableView];
    
    if (!haveTextField) {
        if ((_centerButtonHeight+_separatorThickness)*self.buttonTitles.count>HEIGHTOFSCREEN*0.3) {
            self.buttomView.frame=CGRectMake(0, totalHeight, tipViewWidth,HEIGHTOFSCREEN*0.3);
        }else{
            self.buttomView.frame=CGRectMake(0, totalHeight, tipViewWidth, (_centerButtonHeight+_separatorThickness)*self.buttonTitles.count);
        }
    }else{
        if ((_centerButtonHeight+_separatorThickness)*self.buttonTitles.count>HEIGHTOFSCREEN*0.2) {
            self.buttomView.frame=CGRectMake(0, totalHeight, tipViewWidth,HEIGHTOFSCREEN*0.2);
        }else{
            self.buttomView.frame=CGRectMake(0, totalHeight, tipViewWidth, (_centerButtonHeight+_separatorThickness)*self.buttonTitles.count);
        }
    }
    
    [self.buttomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.buttomView);
        make.top.equalTo(self.buttomView).offset(_separatorThickness);
    }];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.buttonTitles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _centerButtonHeight+_separatorThickness;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_Id forIndexPath:indexPath];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    [cell updateCell:self.buttonTitles[indexPath.row]];
    cell.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self dismissView];
    if (self.verticalBlock) {
        self.verticalBlock(self.textDictionary,indexPath.row);
    }
}

-(UIView *)setLineView{
    self.lineView=[UIView new];
    self.lineView.backgroundColor=_separatorTextColor;
    return self.lineView;
}
/**
 *  显示弹框
 */
-(void)showView{
    [self createUserDefinedView];
    [self addObservers];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1.0;
    }];
}

-(void)dismissView{
    [self removeObservers];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.backView=nil;
    }];
}

-(void)dismissView:(UITapGestureRecognizer *)tap{
    [self dismissView];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldEditChanged:(UITextField *)textField{
    [self.textDictionary setObject:textField.text forKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]];
}
#pragma mark - Observers
- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowChanged:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideChanged:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - Keyboard notifications
- (void)keyboardWillShowChanged:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    CGFloat newy = HEIGHTOFSCREEN-((HEIGHTOFSCREEN-height)/2+height+self.tipView.frame.size.height/2);
    
    self.tipView.frame=CGRectMake(self.tipView.frame.origin.x,newy, self.tipView.frame.size.width, self.tipView.frame.size.height);
}
- (void)keyboardWillHideChanged:(NSNotification *)notification {
    self.tipView.frame=CGRectMake(self.tipView.frame.origin.x, (HEIGHTOFSCREEN-self.tipView.frame.size.height)/2, self.tipView.frame.size.width, self.tipView.frame.size.height);
}

@end

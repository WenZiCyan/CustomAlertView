//
//  CustomAlertView.h
//  AlertView
//
//  Created by Fangjw on 2017/12/8.
//  Copyright © 2017年 Fangjw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ horizontalBlock) (NSMutableDictionary * _Nullable dic, UIButton * _Nonnull btn);
typedef void(^ verticalBlock) (NSMutableDictionary * _Nullable dic, long integer);
typedef void(^ otherBlock) (NSMutableDictionary * _Nullable dic, UIButton * _Nonnull btn);

typedef void (^ _Nullable CustomAlertViewControlSetupHandler)(UIView * _Nonnull view, NSUInteger index);
typedef void (^ _Nullable CustomAlertViewLabelSetupHandler)(UILabel * _Nonnull label);
typedef void (^ _Nullable CustomAlertViewTextFieldsSetupHandler)(UITextField * _Nonnull textField, NSUInteger index);


@interface CustomAlertView : UIView<UIAppearance>

@property (nonatomic, copy) horizontalBlock _Nullable horizontalBlock;

@property (nonatomic, copy) verticalBlock _Nullable verticalBlock;

@property (nonatomic, copy) otherBlock _Nullable otherBlock;

@property (assign, nonatomic) CGFloat layerCornerRadius UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat viewPadding UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat internalPadding UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat textFieldHeight UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat centerButtonHeight UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat bottomButtonHeight UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat separatorThickness UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat titleTextFont UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat messageTextFont UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat textFieldTextFont UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat centerButtonTextFont UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat centerLabelTextFont UI_APPEARANCE_SELECTOR;

@property (assign, nonatomic) CGFloat bottomButtonTextFont UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIColor *backGroundColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIColor *centerBackColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIColor *titleTextColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIColor *messageTextColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIColor *separatorTextColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIColor *cancelButtonTextColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIColor *destructiveButtonTextColor UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIBlurEffect *backgroundBlurEffect UI_APPEARANCE_SELECTOR;

@property (strong, nonatomic, nullable) UIBlurEffect *tipViewBlurEffect UI_APPEARANCE_SELECTOR;
/** Default is NO */
@property (assign, nonatomic) BOOL backViewTapDismiss UI_APPEARANCE_SELECTOR;
/** Default is Yes */
@property (assign, nonatomic) BOOL buttomBtnHorizontal UI_APPEARANCE_SELECTOR;

/**
 *  自定义弹框
 *  @param title 显示的标题
 *  @param message 显示的副标题
 *  @param numberOfControl 自定义view个数
 *  @param controlSetupHandler 自定义view
 *  @param buttonTitles button文字
 */
- (nonnull instancetype)initWithUserDefinedAlertView:(nullable NSString *)title
                                             message:(nullable NSString *)message
                                     numberOfControl:(NSUInteger)numberOfControl
                                 controlSetupHandler:(CustomAlertViewControlSetupHandler)controlSetupHandler
                                        buttonTitles:(nullable NSArray<NSString *> *)buttonTitles;

/**
 *  纯文字单label+按钮弹框
 *  @param title 显示的标题
 *  @param message 显示的副标题
 *  @param content 具体内容
 *  @param labelSetupHandler 自定义label
 *  @param buttonTitles button文字
 */
- (nonnull instancetype)initWithContentAndTitle:(nullable NSString *)title
                                        message:(nullable NSString *)message
                                        content:(nullable NSString *)content
                              labelSetupHandler:(CustomAlertViewLabelSetupHandler)labelSetupHandler
                                   buttonTitles:(nullable NSArray<NSString *> *)buttonTitles;

/**
 *  文字多label/图片+按钮弹框
 *  @param title 显示的标题
 *  @param message 显示的副标题
 *  @param lContentTitles 左具体内容
 *  @param rContentTitles 右具体内容
 *  @param buttonTitles button文字
 */
- (nonnull instancetype)initWithContentsImgAndTitle:(nullable NSString *)title
                                            message:(nullable NSString *)message
                                     lContentTitles:(nullable NSArray<NSString *> *)lContentTitles
                                     rContentTitles:(nullable NSArray<NSString *> *)rContentTitles
                                       buttonTitles:(nullable NSArray<NSString *> *)buttonTitles;

/**
 *  输入框+按钮弹框
 *  @param title 显示的标题
 *  @param message 显示的副标题
 *  @param numberOfTextFields field个数
 *  @param textFieldsSetupHandler 自定义field
 *  @param buttonTitles button文字
 */
- (nonnull instancetype)initWithSendSecurityCodeAndTitle:(nullable NSString *)title
                                                 message:(nullable NSString *)message
                                      numberOfTextFields:(NSUInteger)numberOfTextFields
                                  textFieldsSetupHandler:(CustomAlertViewTextFieldsSetupHandler)textFieldsSetupHandler
                                            buttonTitles:(nullable NSArray<NSString *> *)buttonTitles;

/**
 *  显示弹框
 */
- (void)showView;


@end

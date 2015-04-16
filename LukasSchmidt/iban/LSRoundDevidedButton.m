//
//  LSRoundDevidedButton.m
//  IBAN
//
//  Created by Lukas Schmidt on 24.05.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSRoundDevidedButton.h"
#import "UIColor+IBANColors.h"

@interface LSRoundDevidedButton ()
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;

@end

@implementation LSRoundDevidedButton
- (void)awakeFromNib
{
    [self setupView];
}

- (instancetype)initWithFrame:(CGRect)frame
           leftButtonSelector:(SEL)leftSelector
          rightButtonSelector:(SEL)rightSelector
                       target:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setButtonsWithLeftButtonSelector:leftSelector
                             rightButtonSelector:rightSelector
                                          target:target];
    }
    
    return self;
}

- (void)setButtonsWithLeftButtonSelector:(SEL)leftSelector
                       rightButtonSelector:(SEL)rightSelector
                                    target:(id)target
{
    UIGestureRecognizer *leftTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:leftSelector];
    [self.leftButton addGestureRecognizer:leftTapGesture];
    
    UIGestureRecognizer *rightTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:rightSelector];
    [self.rightButton addGestureRecognizer:rightTapGesture];
}

- (void)setupView
{
    [self.layer setCornerRadius:self.bounds.size.height / 2];
    [self setupLine];
}

- (void)setupLine
{
   CGRect rect = CGRectMake((self.bounds.size.width / 2) - 1, 7, 1, self.bounds.size.height - 14);
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = [UIColor devidedButtonSplitLineColor];
    [self addSubview:line];
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        CGRect rect = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);
        _leftButton = [[UIButton alloc] initWithFrame:rect];
        [self addSubview:_leftButton];
    }
    
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        CGRect rect = CGRectMake( self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
        _rightButton = [[UIButton alloc] initWithFrame:rect];
        [self addSubview:_rightButton];
    }
    
    return _rightButton;
}

- (void)setActivityBothButtons:(BOOL)isActive
{
    [self.leftButton setEnabled:isActive];
    [self.rightButton setEnabled:isActive];
}






@end

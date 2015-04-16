//
//  LSRoundDevidedButton.h
//  IBAN
//
//  Created by Lukas Schmidt on 24.05.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSRoundDevidedButton : UIView
@property (strong, nonatomic, readonly) UIButton *leftButton;
@property (strong, nonatomic, readonly) UIButton *rightButton;

- (instancetype)initWithFrame:(CGRect)frame
           leftButtonSelector:(SEL)leftSelector
          rightButtonSelector:(SEL)rightSelector
                       target:(id)target;
- (void)setButtonsWithLeftButtonSelector:(SEL)leftSelector
                     rightButtonSelector:(SEL)rightSelector
                                  target:(id)target;

- (void)setActivityBothButtons:(BOOL)isActive;
@end

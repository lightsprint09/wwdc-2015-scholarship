//
//  LSRoundTextField.m
//  IBAN
//
//  Created by Lukas Schmidt on 24.05.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSRoundTextField.h"
@interface LSRoundTextField()
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@end

@implementation LSRoundTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup {
    [self.layer setCornerRadius:self.bounds.size.height / 2];
    self.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

@end

//
//  LSRoundLabel.m
//  IBAN
//
//  Created by Lukas Schmidt on 24.05.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSRoundLabel.h"

@implementation LSRoundLabel

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
}

@end

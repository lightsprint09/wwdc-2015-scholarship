//
//  LSRoundButton.m
//  IBAN
//
//  Created by Lukas Schmidt on 26.05.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSRoundButton.h"

@implementation LSRoundButton

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

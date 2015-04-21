//
//  LSProfileImageView.m
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 03.04.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSProfileImageView.h"

@implementation LSProfileImageView

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

- (void)setup
{
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = self.bounds.size.width / 4;
    self.layer.masksToBounds = YES;
}

@end

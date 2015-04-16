//
//  LSBackgroundView.m
//  IBAN
//
//  Created by Lukas Schmidt on 24.05.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSBackgroundView.h"
#import "UIColor+IBANColors.h"

@implementation LSBackgroundView

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
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor backgroundUpperColor] CGColor], (id)[[UIColor backgroundLowerColor] CGColor], nil];
    [self.layer insertSublayer:gradient atIndex:0];
}



@end

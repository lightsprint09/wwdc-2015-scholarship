//
//  LSSettingsButton.m
//  IBAN
//
//  Created by Lukas Schmidt on 10.09.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSSettingsButton.h"

@implementation LSSettingsButton

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
    [super setup];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"icon-ios7-gear-outline.png"];
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
}

@end

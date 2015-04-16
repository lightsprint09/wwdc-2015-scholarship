//
//  UIColor+IBANColors.m
//  IBAN
//
//  Created by Lukas Schmidt on 14.07.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "UIColor+IBANColors.h"

@implementation UIColor (IBANColors)

+ (UIColor *)backgroundUpperColor
{
    return [UIColor colorWithRed:0 / 255.0 green:140 / 255.0 blue:217 / 255.0 alpha:1.0];
}

+ (UIColor *)backgroundLowerColor
{
    return [UIColor colorWithRed:0 / 255.0 green:107 / 255.0 blue:166 / 255.0 alpha:1.0];
}

+ (UIColor *)devidedButtonSplitLineColor
{
    return [UIColor colorWithRed:68 / 255.0 green:145 / 255.0 blue:188 / 255.0 alpha:1.0];
}

+ (UIColor *)invalidInputErrorMessageColor
{
    return [UIColor colorWithRed:253 / 255.0 green:145 / 255.0 blue:38 / 255.0 alpha:1.0];
}

+ (UIColor *)buttonFavoriteStarColor
{
    return [UIColor colorWithRed:255 / 255.0 green:203 / 255.0 blue:1 / 255.0 alpha:1.0];
}

+ (UIColor *)buttonDeactivatedColor{
    return [UIColor colorWithRed:223 / 255.0 green:223 / 255.0 blue:223 / 255.0 alpha:1.0];
}

@end

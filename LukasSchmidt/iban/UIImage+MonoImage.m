//
//  UIImage+MonoImage.m
//
//  Created by Lukas Schmidt on 05.10.13.
//  Copyright (c) 2013 Lukas Schmidt. All rights reserved.
//

#import "UIImage+MonoImage.h"

@implementation UIImage (MonoImage)
+ (UIImage *) generateMonoImage: (UIImage *)icon withColor:(UIColor *)color
{
    UIImage *finishImage;
    CGImageRef alphaImage = CGImageRetain(icon.CGImage);
    CGColorRef colorref = CGColorRetain(color.CGColor);
	
    UIGraphicsBeginImageContext(icon.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    CGRect imageArea = CGRectMake (0, 0,
                                   icon.size.width, icon.size.height);
	
    CGFloat height = icon.size.height;
    CGContextTranslateCTM(ctx, 0.0, height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
	
    CGContextClipToMask(ctx, imageArea , alphaImage);
	
    CGContextSetFillColorWithColor(ctx, colorref);
    CGContextFillRect(ctx, imageArea);
    CGImageRelease(alphaImage);
    CGColorRelease(colorref);
	
    finishImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finishImage;
}

- (UIImage *)imageWithOverlayColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
	
    if (UIGraphicsBeginImageContextWithOptions) {
        CGFloat imageScale = 1.0f;
        if ([self respondsToSelector:@selector(scale)])
            imageScale = self.scale;
        UIGraphicsBeginImageContextWithOptions(self.size, NO, imageScale);
    }
	
    [self drawInRect:rect];
	
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
	
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}
@end

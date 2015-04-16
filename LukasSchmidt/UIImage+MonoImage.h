//
//  UIImage+MonoImage.h
//
//  Created by Lukas Schmidt on 05.10.13.
//  Copyright (c) 2013 Lukas Schmidt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MonoImage)
+ (UIImage *) generateMonoImage: (UIImage *)icon withColor:(UIColor *)color;
- (UIImage *)imageWithOverlayColor:(UIColor *)color;
@end

//
//  LSIBANBICBLZFormatter.h
//  IBAN
//
//  Created by Lukas Schmidt on 08.07.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSIBANBLZFormatter : NSObject
+ (NSString *)formatIBAN:(NSString *)iban;

+ (NSString *)formatBLZ:(NSString *)blz;
@end

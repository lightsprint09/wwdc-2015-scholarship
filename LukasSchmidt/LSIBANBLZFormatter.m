//
//  LSIBANBICBLZFormatter.m
//  IBAN
//
//  Created by Lukas Schmidt on 08.07.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSIBANBLZFormatter.h"

@implementation LSIBANBLZFormatter
+ (NSString *)formatIBAN:(NSString *)iban
{
    NSString *resultIBAN = [NSString stringWithFormat:@""];
    NSRange frontBlockRange = NSMakeRange(0, 4);
    NSString *frontBlock;
    
    while (iban.length > 4) {
        frontBlock = [iban substringWithRange:frontBlockRange];
        resultIBAN = [NSString stringWithFormat:@"%@%@ ", resultIBAN, frontBlock];
        iban = [iban substringFromIndex:4];
    }
    
    if (iban.length != 0) {
        resultIBAN = [resultIBAN stringByAppendingString:iban];
    }
    
    return resultIBAN;
}


+ (NSString *)formatBLZ:(NSString *)blz
{
    return blz;
}
@end

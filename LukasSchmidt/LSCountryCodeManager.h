//
//  LSCountryCodeManager.h
//  IBAN
//
//  Created by Lukas Schmidt on 15.06.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    LSFormatTypeNumeric,
    LSFormatTypeAlphaNumeric
} LSFormatType;

@interface LSCountryCodeManager : NSObject
@property (strong, nonatomic) NSString *countryCode;
@property (strong, nonatomic, readonly) NSDictionary *countryCodes;
@property (strong, nonatomic, readonly) NSDictionary *countryNames;

- (BOOL)currentCountrySupportsBIC;

- (LSFormatType)blzFormatTypeForCurrentCountryCode;

- (LSFormatType)accountNumberFormatTypeForCurrentCountryCode;
@end

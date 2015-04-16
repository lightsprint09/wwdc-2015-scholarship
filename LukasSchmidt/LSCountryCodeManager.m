//
//  LSCountryCodeManager.m
//  IBAN
//
//  Created by Lukas Schmidt on 15.06.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "LSCountryCodeManager.h"

@interface LSCountryCodeManager ()
@property (strong, nonatomic, readwrite) NSDictionary *countryCodes;
@property (strong, nonatomic) NSDictionary *countryNames;
@end

@implementation LSCountryCodeManager
- (NSDictionary *)countryCodes
{
    if (!_countryCodes) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CountryCodes" ofType:@"plist"];
        _countryCodes = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return _countryCodes;
}

@synthesize countryCode = _countryCode;
- (NSString *)countryCode
{
    if (!_countryCode) {
        _countryCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"countryCode"];
        if(!_countryCode) {
            _countryCode = [self getLocaleCountryCode];
        }
    }
    return _countryCode;
}

- (void)setCountryCode:(NSString *)countryCode
{
    _countryCode = countryCode;
    [[NSUserDefaults standardUserDefaults] setObject:countryCode forKey:@"countryCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getLocaleCountryCode
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    countryCode = [self.countryCodes valueForKey:countryCode] ? countryCode : @"DE";
    
    return countryCode;
}

- (NSDictionary *)countryNames
{
    if (!_countryNames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CountryNames" ofType:@"plist"];
        _countryNames = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return _countryNames;
}

- (BOOL)currentCountrySupportsBIC
{
    NSArray *bicSupportedCountryCode = @[@"DE"];
    
    return [bicSupportedCountryCode containsObject:self.countryCode];
}


- (LSFormatType)formatTypeForBankField:(NSString *)bankField
                             andCountryCode:(NSString *)countryCode
{
    NSDictionary *formatDict = [self.countryCodes valueForKeyPath:[NSString stringWithFormat:@"%@.%@", countryCode, bankField]];
    for (NSDictionary *typeDict in [formatDict allValues]) {
        NSString *type = [typeDict valueForKey:@"type"];
        bool isNumeric = [type isEqualToString:@"n"] || [type isEqualToString:@"x"];
        if (!isNumeric) return LSFormatTypeAlphaNumeric;
    }
    
    return LSFormatTypeNumeric;
}

- (LSFormatType)blzFormatTypeForCurrentCountryCode
{
    return [self formatTypeForBankField:@"blz" andCountryCode:self.countryCode];
}

- (LSFormatType)accountNumberFormatTypeForCurrentCountryCode
{
    return [self formatTypeForBankField:@"account" andCountryCode:self.countryCode];
}
@end

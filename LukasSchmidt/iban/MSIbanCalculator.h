//
//  MSIbanCalculator.h
//  IBAN_Model
//
//  Created by Michael Scheuermann on 24.05.14.
//  Copyright (c) 2014 FREI.RAUM IT-Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LSAccountInfo+Category.h"
#import "LSCountryCodeManager.h"

@interface MSIbanCalculator : NSObject
- (instancetype)initWidthCountryCodeManager:(LSCountryCodeManager *)countryCodeManager;

@property (strong, nonatomic) NSString *blz;
@property (strong, nonatomic) NSString *accountNumber;
@property (strong, nonatomic) NSString *iban;

@property (nonatomic, readonly) BOOL wrongInput;

- (NSString *)getErrorMessage;

- (NSString *)bankname;

- (NSString *)bic;

//- (void)setAccountInfoData:(LSAccountInfo *)accountInfo;

@end

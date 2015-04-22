//
//  MSIbanCalculator.m
//  IBAN_Model
//
//  Created by Michael Scheuermann on 24.05.14.
//  Copyright (c) 2014 FREI.RAUM IT-Solutions. All rights reserved.
//

#import "MSIbanCalculator.h"
@interface MSIbanCalculator()

@property (strong, nonatomic) LSCountryCodeManager *countryCodeManager;

@property (strong, nonatomic) NSDictionary *blzBic;
@property (strong, nonatomic) NSCharacterSet *numberCharacterset;
@property (strong, nonatomic) NSCharacterSet *letterCharacterset;
@property (strong, nonatomic) NSCharacterSet *alphanumericCharacterset;

@property (nonatomic) BOOL incorrectAccountNumber;
@property (nonatomic) BOOL incorrectBankCode;
@end

@implementation MSIbanCalculator

- (instancetype)initWidthCountryCodeManager:(LSCountryCodeManager *)countryCodeManager;
{
    self = [super init];
    if (self) {
        self.countryCodeManager = countryCodeManager;
        self.blz = @"";
        self.accountNumber = @"";
    }
    
    return self;
}
#pragma mark - IBAN and BIC

- (NSString *)calculateIbanWithBlz:(NSString *)blz
                      accountnumber:(NSString *)accountnumber
                        countryCode:(NSString *)countryCode
{
    self.incorrectAccountNumber = NO;
    self.incorrectBankCode = NO;
    if([self hasEmptyData]) {
        return @"";
    }
    NSString *blzFull = [self blzFullOutputWithBlz:blz fromCountryCode:countryCode];
    NSString *accountNumberFull = [self accountNumberFullOutputWithBlz:accountnumber fromCountryCode:countryCode];
    NSString *checksumString  = [self returnChecksumForAllCasesWithBlz:blz accountnumber:accountnumber countryCode:countryCode];
    
    return [NSString stringWithFormat:@"%@%@%@%@", countryCode, checksumString, blzFull, accountNumberFull];
}

- (BOOL)hasEmptyData
{
    return [self.accountNumber isEqualToString:@""] || [self.blz isEqualToString:@""];
}

- (NSString *)getInfoFromBlz:(NSString *)blz
                            withKey:(NSString *)key
{
    return [[self getBlzBicEntryDictionaryForBlz:blz] valueForKey:key];
}

- (NSString *)bankname
{
    return [self getInfoFromBlz:self.blz withKey:@"shortName"];
}

- (NSString *)bic
{
    return [self getInfoFromBlz:self.blz withKey:@"bic"];
}

- (NSString *)iban
{
    return [self calculateIbanWithBlz:self.blz accountnumber:self.accountNumber countryCode:self.countryCodeManager.countryCode];
}


#pragma mark - calculate checksum


- (NSDictionary *)getBlzFormatDictionaryForCountryCode:(NSString *)code
{
    return [self.countryCodeManager.countryCodes valueForKeyPath:[NSString stringWithFormat:@"%@.blz", code]];
}

- (NSString *)getFullVersionOfNumber:(NSString *)number
                     fromCountryCode:(NSString *)countryCode
                                 key:(NSString *)key
{
    NSDictionary *numberFormatDict = [self.countryCodeManager.countryCodes valueForKeyPath:[NSString stringWithFormat:@"%@.%@",countryCode, key]];
    NSInteger targetLength = 0;
    for (NSDictionary *valueDict in [numberFormatDict allValues] ) {
        targetLength += [[valueDict valueForKey:@"count"] integerValue];
    }
    targetLength -= number.length;
    for (NSInteger i = 0; i < targetLength; i++) {
        number = [NSString stringWithFormat:@"0%@", number];
    }
    [self validateInputForNumber:number fromCountryCode:countryCode key:key];
    
    return number;
}

+ (NSString *)numberOfCharacter:(NSString *)character
{
    character = [character uppercaseString];
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return [NSString stringWithFormat:@"%lu", [array indexOfObject:character] + 10];
}

- (NSString *)numberFromCountryCode:(NSString *)countryCode
{
    NSString *resultString = @"";
    NSRange range = NSMakeRange(0, 1);
    resultString = [resultString stringByAppendingString:[MSIbanCalculator numberOfCharacter:[countryCode substringWithRange:range]]];
    range = NSMakeRange(1, 1);
    resultString = [resultString stringByAppendingString:[MSIbanCalculator numberOfCharacter:[countryCode substringWithRange:range]]];
    
    return resultString;
}

- (NSString *)translateToNumbersForChecksumFromAllTypesOfCharacters:(NSString *)inputString
{
    NSString *translatedStringForChecksum = @"";
    NSRange currentPosition = NSMakeRange(0, 1);

    for (int i = 0; i < inputString.length; i++) {
        if ([self.letterCharacterset characterIsMember:[inputString characterAtIndex:i]]) {
            translatedStringForChecksum = [translatedStringForChecksum stringByAppendingString:[MSIbanCalculator numberOfCharacter:[inputString substringWithRange:currentPosition]]];
        }
        else if ([self.numberCharacterset characterIsMember:[inputString characterAtIndex:i]]) {
            translatedStringForChecksum = [translatedStringForChecksum stringByAppendingString:[inputString substringWithRange:currentPosition]];
        }
        currentPosition = NSMakeRange(i + 1, 1);
    }
    
    return translatedStringForChecksum;
}

- (NSString *)calculateChecksum:(NSString *)string
{
    NSRange firstRange = NSMakeRange(0, 9);
    NSString *firstSubstring = [string substringWithRange:firstRange];
    string = [string substringFromIndex:9];
    NSInteger tempModulo = [firstSubstring integerValue] % 97;
    
    while (string.length > 7) {
        NSRange subRange = NSMakeRange(0, 7);
        NSString *substring = [string substringWithRange:subRange];
        NSString *muduloString = [NSString stringWithFormat:@"%li%@", (long)tempModulo, substring];
        tempModulo = [muduloString integerValue] % 97;
        string = [string substringFromIndex:7];
    }
    NSString *finalModulo = [NSString stringWithFormat:@"%li%@", (long)tempModulo, string];
    
    NSString *finalChecksum = [NSString stringWithFormat:@"%li", (long)(98 - [finalModulo integerValue] % 97)];
    
    return finalChecksum.length == 1 ? [@"0" stringByAppendingString:finalChecksum] : finalChecksum;
}

- (NSString *)returnChecksumForAllCasesWithBlz:(NSString *)blz
                                 accountnumber:(NSString *)accountnumber
                                   countryCode:(NSString *)countryCode
{
    NSString *blzFullChecksum = [self translateToNumbersForChecksumFromAllTypesOfCharacters:[self blzFullOutputWithBlz:blz fromCountryCode:countryCode]];
    NSString *accountNumberFullChecksum = [self translateToNumbersForChecksumFromAllTypesOfCharacters:[self accountNumberFullOutputWithBlz:accountnumber fromCountryCode:countryCode]];
    NSString *numberCountryCodeChecksum = [self numberFromCountryCode:countryCode];
    NSString *completeBBNChecksum = [NSString stringWithFormat:@"%@%@%@00", blzFullChecksum, accountNumberFullChecksum, numberCountryCodeChecksum];
    return [self calculateChecksum:completeBBNChecksum];
}


#pragma mark - validation

- (void)validateInputForNumber:(NSString *)number
              fromCountryCode:(NSString *)countryCode
                          key:(NSString *)key
{
    [self validateInputForSpellingWithNumber:number fromCountryCode:countryCode key:key];
    if ([countryCode isEqualToString:@"DE"] && [key isEqualToString:@"blz"]) {
        [self validateInputByCheckingBlzWithBlz:number];
    }
}

- (void)validateInputForSpellingWithNumber:(NSString *)number
                          fromCountryCode:(NSString *)countryCode
                                      key:(NSString *)key
{
    NSInteger countOfnumberFormats = [[self getFormatDictionaryForCountryCode:countryCode andKey:key] count];
    
    NSCharacterSet *invertedNumberCharacterset = [self.numberCharacterset invertedSet];
    NSCharacterSet *invertedLetterCharacterset = [self.letterCharacterset invertedSet];
    NSCharacterSet *invertedAlphanumericCharacterset = [self.alphanumericCharacterset invertedSet];
    
    const unichar onlyNumber = 'n';
    const unichar onlyLetter = 'a';
    const unichar onlyAlphanumeric = 'c';
    
    NSRange substringRange;
    substringRange.location = 0;
    NSString *substring;
    NSRange testRange;
    
    for (int i = 1; i <= countOfnumberFormats; i++)
    {
        unichar type = [[[self getFormatEntryDictionaryForCountryCode:countryCode andKey:key andPosition:i] valueForKey:@"type"] characterAtIndex:0];
        NSInteger count = [[[self getFormatEntryDictionaryForCountryCode:countryCode andKey:key andPosition:i] valueForKey:@"count"] integerValue];
        substringRange.length = count;
        substring = [number substringWithRange:substringRange];
        
        switch (type) {
            case onlyNumber:
                testRange = [substring rangeOfCharacterFromSet:invertedNumberCharacterset];
                if (testRange.location != NSNotFound)
                {
                    self.incorrectAccountNumber = ([key isEqualToString:@"account"])? YES : self.incorrectAccountNumber;
                    self.incorrectBankCode = ([key isEqualToString:@"blz"])? YES : self.incorrectBankCode;
                }
                break;
            case onlyLetter:
                testRange = [substring rangeOfCharacterFromSet:invertedLetterCharacterset];
                if (testRange.location != NSNotFound)
                {
                    self.incorrectAccountNumber = ([key isEqualToString:@"account"])? YES : self.incorrectAccountNumber;
                    self.incorrectBankCode = ([key isEqualToString:@"blz"])? YES : self.incorrectBankCode;
                }
                break;
            case onlyAlphanumeric:
                testRange = [substring rangeOfCharacterFromSet:invertedAlphanumericCharacterset];
                if (testRange.location != NSNotFound)
                {
                    self.incorrectAccountNumber = ([key isEqualToString:@"account"])? YES : self.incorrectAccountNumber;
                    self.incorrectBankCode = ([key isEqualToString:@"blz"])? YES : self.incorrectBankCode;
                }
                break;
                
            default:
                break;
        }
        substringRange.location += count;
    }
    if (substringRange.location < number.length)
    {
        self.incorrectAccountNumber = ([key isEqualToString:@"account"])? YES : self.incorrectAccountNumber;
        self.incorrectBankCode = ([key isEqualToString:@"blz"])? YES : self.incorrectBankCode;
    }
}

- (void)validateInputByCheckingBlzWithBlz:(NSString *)blz
{
    if (![self getBlzBicEntryDictionaryForBlz:blz]){
        self.incorrectBankCode = YES;
    }
}

- (BOOL)wrongInput
{
    return self.incorrectBankCode || self.incorrectAccountNumber || !(self.blz.length >= [self lengthOfBlzFromCountryCode:self.countryCodeManager.countryCode]);
}

- (NSString *)getErrorMessage
{
    if (!(self.blz.length >= [self lengthOfBlzFromCountryCode:self.countryCodeManager.countryCode])) {
        return @"";
    }
    if (self.incorrectAccountNumber && self.incorrectBankCode){
        return NSLocalizedString(@"incorrect account number and incorrect bank code", @"message for incorrect account number and incorrect bank code, shown in the iban label");
    }
    else if (self.incorrectAccountNumber) {
        return NSLocalizedString(@"incorrect account number", @"message for incorrect account number, shown in the iban label");
        
    }
    else if (self.incorrectBankCode) {
        return NSLocalizedString(@"incorrect bank code", @"message for incorrect bank code, shown in the iban label");
    }
    return @"";
}

#pragma mark - properties and tools

- (NSString *)blzFullOutputWithBlz:(NSString *)blz fromCountryCode:(NSString *)countryCode
{
    return [self getFullVersionOfNumber:blz fromCountryCode:countryCode key:@"blz"];
}

- (NSString *)accountNumberFullOutputWithBlz:(NSString *)accountNumber fromCountryCode:(NSString *)countryCode
{
    return [self getFullVersionOfNumber:accountNumber fromCountryCode:countryCode key:@"account"];
}

- (NSInteger)lengthOfBlzFromCountryCode:(NSString *)countryCode
{
    NSInteger lengthBLZ = 0;
    NSDictionary *blzFormatDict = [self getFormatDictionaryForCountryCode:countryCode andKey:@"blz"];
    for (NSDictionary *valueDict in [blzFormatDict allValues] ) {
        lengthBLZ += [[valueDict valueForKey:@"count"] integerValue];
    }
    return lengthBLZ;
}

- (NSDictionary *)getBlzBicEntryDictionaryForBlz:(NSString *)blz
{
    return [self.blzBic valueForKey:blz];
}

- (NSDictionary *)getFormatDictionaryForCountryCode:(NSString *)code
                                             andKey:(NSString *)key
{
    return [self.countryCodeManager.countryCodes valueForKeyPath:[NSString stringWithFormat:@"%@.%@", code,key]];
}

- (NSDictionary *)getFormatEntryDictionaryForCountryCode:(NSString *)code
                                                  andKey:(NSString *)key
                                             andPosition:(int)pos
{
    return [[self getFormatDictionaryForCountryCode:code andKey:key] valueForKeyPath:[NSString stringWithFormat:@"%@_%d",key,pos]];
}

- (NSDictionary *)blzBic
{
    if (!_blzBic) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"blz_bic_list" ofType:@"plist"];
        _blzBic = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _blzBic;
}

- (NSCharacterSet *)numberCharacterset
{
    if (!_numberCharacterset) {
        _numberCharacterset = [NSCharacterSet decimalDigitCharacterSet];
    }
    return _numberCharacterset;
}

- (NSCharacterSet *)letterCharacterset
{
    if (!_letterCharacterset)
    {
        NSMutableCharacterSet *letterCharacterset = [[NSMutableCharacterSet alloc] init];
        NSRange lowercaseLettersRange;
        lowercaseLettersRange.location = (unsigned int)'a';
        lowercaseLettersRange.length = 26;
        NSRange uppercaseLettersRange;
        uppercaseLettersRange.location = (unsigned int)'A';
        uppercaseLettersRange.length = 26;
        [letterCharacterset formUnionWithCharacterSet:[NSCharacterSet characterSetWithRange:lowercaseLettersRange]];
        [letterCharacterset formUnionWithCharacterSet:[NSCharacterSet characterSetWithRange:uppercaseLettersRange]];
        _letterCharacterset = letterCharacterset;
    }
    return _letterCharacterset;
}

- (NSCharacterSet *)alphanumericCharacterset
{
    if(!_alphanumericCharacterset)
    {
        NSMutableCharacterSet* alphanumericCharacterset = [[NSMutableCharacterSet alloc] init];
        [alphanumericCharacterset formUnionWithCharacterSet:self.numberCharacterset];
        [alphanumericCharacterset formUnionWithCharacterSet:self.letterCharacterset];
        _alphanumericCharacterset = alphanumericCharacterset;
    }
    return _alphanumericCharacterset;
}

//- (void)setAccountInfoData:(LSAccountInfo *)accountInfo
//{
//    self.blz = accountInfo.blz;
//    self.accountNumber = accountInfo.accountNumber;
//    self.countryCodeManager.countryCode = [accountInfo countryCode];
//}

@end

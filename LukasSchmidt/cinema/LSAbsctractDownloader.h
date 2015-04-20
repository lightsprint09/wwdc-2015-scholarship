//
//  LSAbsctractDownloader.h
//  CinemaPOS
//
//  Created by Lukas Schmidt on 29.01.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSAbsctractDownloader <NSObject>
- (NSArray *)parseJSONDataToArray:(NSData*)data;

- (NSDictionary *)parseJSONDataToDictonary:(NSData*)data;


@end

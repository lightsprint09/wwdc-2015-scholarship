//
//  LSLoginService.h
//  CinemaPOS
//
//  Created by Lukas Schmidt on 05.02.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSLoginService <NSObject>
typedef void (^LSDidLogin)(BOOL, NSError*);
- (void)loginWithUsername:(NSString *)username
              andPassword:(NSString *)password
    withCompletionHandler:(LSDidLogin)didLogin;
@end

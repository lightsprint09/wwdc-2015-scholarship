//
//  LSLoginServiceImpl.m
//  CinemaPOS
//
//  Created by Lukas Schmidt on 05.02.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

#import "LSLoginServiceImpl.h"
#import "LSURLConstants.h"

@implementation LSLoginServiceImpl

- (void)loginWithUsername:(NSString *)username
              andPassword:(NSString *)password
    withCompletionHandler:(LSDidLogin)didLogin
{
    NSURL *url = [NSURL URLWithString:@"/api/login" relativeToURL:[NSURL URLWithString:API_URL]];
    NSDictionary *dict = @{@"username": username, @"password": password};
    NSError *err;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&err];
    
    [self performDataTaskWithWithULR:url
                  HTTPHRequestMethod:@"POST"
                        withHTTPBody:postData withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                            NSDictionary *login = [self parseJSONDataToDictonary:data];
                            NSNumber *isLoggedIn = [login valueForKey:@"loggedIn"];
                            didLogin(isLoggedIn.boolValue, error);
                        }];
}

@end

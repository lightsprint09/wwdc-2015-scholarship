//
//  LSWebticketConnection.m
//  Kinostar
//
//  Created by Lukas Schmidt on 18.04.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import "WTConnection.h"

@interface WTConnection ()
@property (strong, nonatomic) NSURLSessionTask *currentTask;
@end

@implementation WTConnection

- (void)performDataTaskWithWithULR:(NSURL *)url
                HTTPHRequestMethod:(NSString *)requestMethod
             withCompletionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandlder
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60.0];
    
    if (requestMethod) {
        [request setHTTPMethod:requestMethod];
        
    }
    [request setHTTPShouldHandleCookies:YES];
    self.currentTask = [self.urlSession dataTaskWithRequest:request completionHandler:completionHandlder];
    [self.currentTask  resume];
}

- (void)performDataTaskWithWithULR:(NSURL *)url
                HTTPHRequestMethod:(NSString *)requestMethod
                      withHTTPBody:(NSData *)body
             withCompletionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandlder
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:60.0];
    request.HTTPBody = body;
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (requestMethod) {
        [request setHTTPMethod:requestMethod];
        
    }
    [request setHTTPShouldHandleCookies:YES];
    self.currentTask = [self.urlSession dataTaskWithRequest:request completionHandler:completionHandlder];
    [self.currentTask  resume];
}


- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 withCompletionHandler:(void (^)(NSURLRequest *))completionHandler
{
    NSURLRequest *newRequest = request;
    if (response) {
        newRequest = nil;
    }
    
    completionHandler(newRequest);
}

- (NSString *)HTTPHeaderValueForKey:(NSString *)key
                       fromResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
    NSDictionary *fields = [HTTPResponse allHeaderFields];
    
    return [fields valueForKey:key];
}

- (NSURLSession *)urlSession
{
    if (!_urlSession) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPShouldSetCookies = YES;
        sessionConfiguration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
        
        _urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                    delegate:self
                                               delegateQueue:nil];
    }
    
    return _urlSession;
}

- (NSArray *)parseJSONDataToArray:(NSData*)data {
    NSError *jsonError = nil;
    return [NSJSONSerialization
            JSONObjectWithData:data
            options:0
            error:&jsonError];
}

- (NSDictionary *)parseJSONDataToDictonary:(NSData *)data
{
    NSError *jsonError = nil;
    return [NSJSONSerialization
            JSONObjectWithData:data
            options:0
            error:&jsonError];
}
@end

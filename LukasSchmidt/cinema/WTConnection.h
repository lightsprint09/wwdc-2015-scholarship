//
//  LSWebticketConnection.h
//  Kinostar
//
//  Created by Lukas Schmidt on 18.04.14.
//  Copyright (c) 2014 Lukas Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LSAbsctractDownloader.h"

@interface WTConnection : NSObject<NSURLSessionTaskDelegate, LSAbsctractDownloader>

@property (strong, nonatomic) NSURLSession *urlSession;

- (void)performDataTaskWithWithULR:(NSURL *)url
                HTTPHRequestMethod:(NSString *)requestMethod
             withCompletionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandlder;

- (void)performDataTaskWithWithULR:(NSURL *)url
                HTTPHRequestMethod:(NSString *)requestMethod
                      withHTTPBody:(NSData *)body
             withCompletionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandlder;

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 withCompletionHandler:(void (^)(NSURLRequest *))completionHandler;

- (NSString *)HTTPHeaderValueForKey:(NSString *)key
                       fromResponse:(NSURLResponse *)response;

@end

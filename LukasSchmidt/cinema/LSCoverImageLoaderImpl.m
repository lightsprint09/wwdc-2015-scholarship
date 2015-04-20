//
//  LSCoverImageDownloader.m
//  CinemaPOS
//
//  Created by Lukas Schmidt on 26.01.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

#import "LSCoverImageLoaderImpl.h"


@implementation LSCoverImageLoaderImpl

- (void)downloadMovieCoverImageWithURL:(NSURL *)imageURL
                  didFinishLodingImage:(LSDidFindishLoadingImage)didFinisch
{
    [self performDataTaskWithWithULR:imageURL
                  HTTPHRequestMethod:@"GET"
               withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   didFinisch(data, error);
    }];
}
@end

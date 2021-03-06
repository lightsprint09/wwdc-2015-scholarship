//
//  LSCoverImageLoader.h
//  CinemaPOS
//
//  Created by Lukas Schmidt on 26.01.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSCoverImageLoader <NSObject>
typedef void (^LSDidFindishLoadingImage)(NSData*, NSError*);

- (void)downloadMovieCoverImageWithURL:(NSURL *)imageURL
                  didFinishLodingImage:(LSDidFindishLoadingImage)didFinisch;
@end

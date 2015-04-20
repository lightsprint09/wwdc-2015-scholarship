//
//  MoviePlaytimeDownloader.h
//  CinemaPOS
//
//  Created by Lukas Schmidt on 26.01.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSMoviePlaytimeDownloader <NSObject>
typedef void (^LSDidFindishLoadingPlaytimeList)(NSArray*, NSError*);

- (void)loadMoviePlaytimeListFromCinemaWithID:(NSInteger)cinemaID
                                    withBlock:(LSDidFindishLoadingPlaytimeList)didDownload;

- (void)validatePlaytimes:(NSArray *)playtimeIDs
    withCompletionHandler:(LSDidFindishLoadingPlaytimeList)didFinish;
@end

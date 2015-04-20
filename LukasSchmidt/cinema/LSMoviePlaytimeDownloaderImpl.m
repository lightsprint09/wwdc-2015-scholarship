//
//  LSMoviePlaytimeDownloaderImpl.m
//  CinemaPOS
//
//  Created by Lukas Schmidt on 26.01.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

#import "LSMoviePlaytimeDownloaderImpl.h"
#import "LSURLConstants.h"

@implementation LSMoviePlaytimeDownloaderImpl

- (void)loadMoviePlaytimeListFromCinemaWithID:(NSInteger)cinemaID
                                    withBlock:(LSDidFindishLoadingPlaytimeList)didDownload {
    NSURL *url = [self URLForMoviePlaytimes:cinemaID];
    [self performDataTaskWithWithULR:url
                  HTTPHRequestMethod:@"GET" withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *movies = [self parseJSONDATAtoArray:data];
        didDownload(movies, error);
    }];
    
}

- (void)validatePlaytimes:(NSArray *)playtimeIDs
    withCompletionHandler:(LSDidFindishLoadingPlaytimeList)didFinish
{
    NSURL *url = [NSURL URLWithString:@"/api/v1/pos/validatePlaytimes" relativeToURL:[NSURL URLWithString:API_URL]];
    NSError *err;
    NSDictionary *dict = @{@"playtimes":playtimeIDs};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&err];
    [self performDataTaskWithWithULR:url HTTPHRequestMethod:@"POST" withHTTPBody:postData withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSArray *invalidPlaytimes = [self parseJSONDATAtoArray:data];
        didFinish(invalidPlaytimes, error);
    }];
    
}

- (NSURL *)URLForMoviePlaytimes:(NSInteger)cinemaID {
    NSString *urlPathString = [NSString stringWithFormat:@"/api/v1/pos/allMoviesWithPlaytime?cinemaID=%lu", cinemaID];
    
    return [NSURL URLWithString:urlPathString relativeToURL:[NSURL URLWithString:API_URL]];
}


- (NSArray *)parseJSONDATAtoArray:(NSData*)data {
    NSError *jsonError = nil;
    return [NSJSONSerialization
            JSONObjectWithData:data
            options:0
            error:&jsonError];
}
@end

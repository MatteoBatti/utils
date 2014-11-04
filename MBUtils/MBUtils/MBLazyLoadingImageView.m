//
//  MBLazyLoadingImageView.m
//  SinatraClub
//
//  Created by Matteo Battistini on 28/08/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBLazyLoadingImageView.h"
#import "MBDiscartableCache.h"
#import "MBDiscartableObject.h"
#import "NSData+MD5.h"
#import "NSString+MD5.h"

@implementation MBLazyLoadingImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)setImageWithUrl:(NSURL *)url
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        
        // check in cache
        NSString *cacheKey = [url.lastPathComponent MD5];
        UIImage *img = nil;
        img = ((MBDiscartableObject *)[[MBDiscartableCache sharedInstance] getCachedResourceForKey:cacheKey]).object ;
        if (!img) {
            NSData *imgData = nil;
            if ([[MBDiscartableCache sharedInstance] isFileSavedOnDisk:cacheKey]) {
                imgData = [[MBDiscartableCache sharedInstance] getFileFromDisk:cacheKey];
            } else {
                imgData = [NSData dataWithContentsOfURL:url];
            }
            img = [UIImage imageWithData:imgData];
            NSUInteger cost = [imgData length];
            [[MBDiscartableCache sharedInstance] addDiscartableObject:img key:cacheKey cost:cost data:imgData diskCache:YES];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [super setImage:img];
        });
    });
}

-(void)setImageWithUrl:(NSURL *)url animeted:(BOOL) animated;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        
        // check in cache
        NSString *cacheKey = [url.lastPathComponent MD5];
        BOOL isDownloaded = NO;
        UIImage *img = nil;
        img = ((MBDiscartableObject *)[[MBDiscartableCache sharedInstance] getCachedResourceForKey:cacheKey]).object ;
        if (!img) {
            NSData *imgData = nil;
            if ([[MBDiscartableCache sharedInstance] isFileSavedOnDisk:cacheKey]) {
                imgData = [[MBDiscartableCache sharedInstance] getFileFromDisk:cacheKey];
            } else {
                isDownloaded = YES;
                imgData = [NSData dataWithContentsOfURL:url];
            }
            img = [UIImage imageWithData:imgData];
            NSUInteger cost = [imgData length];
            [[MBDiscartableCache sharedInstance] addDiscartableObject:img key:cacheKey cost:cost data:imgData diskCache:YES];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (isDownloaded && animated) {
                self.alpha = 0.0;
                [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.alpha = 1.0;
                } completion:^(BOOL finished) {
                    
                }];
            } else {
                [super setImage:img];
            }
        });
    });
}


@end

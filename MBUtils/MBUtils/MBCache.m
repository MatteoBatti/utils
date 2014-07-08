//
//  MBCache.m
//  MBUtils
//
//  Created by Matteo Battistini on 08/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBCache.h"

// 10 * 1024 * 1024
#define CACHE_LIMIT 10485760

@interface MBCache ()
{
    NSCache *_cache;
}
@end

@implementation MBCache

-(MBCache *)sharedInstance
{
    static MBCache *sharedCache = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedCache = [[MBCache alloc] init];
    });
    return sharedCache;
}

-(id)init
{
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
        [_cache setTotalCostLimit:CACHE_LIMIT];
        [_cache setDelegate:self];
    }
    return self;
}

-(id)getCachedResourceForKey:(id)key
{
    return [_cache objectForKey:key];
}

- (void) setObject:(id)obj forKey:(id)key {
    [_cache setObject:obj forKey:key];
}

- (void)emptyCache
{
    [_cache removeAllObjects];
}


@end

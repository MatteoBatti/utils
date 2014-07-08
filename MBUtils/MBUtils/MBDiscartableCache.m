//
//  MBDiscartableCache.m
//  MBUtils
//
//  Created by Matteo Battistini on 08/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBDiscartableCache.h"
#import "MBDiscartableObject.h"

// 10 * 1024 * 1024
#define DISCARTABLE_CACHE_LIMIT 10485760

@interface MBDiscartableCache ()
{
    NSCache *_cache;
}
@end

@implementation MBDiscartableCache

-(MBDiscartableCache *)sharedInstance
{
    static MBDiscartableCache *sharedCache = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedCache = [[MBDiscartableCache alloc] init];
    });
    return sharedCache;
}

-(id)init
{
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
        [_cache setTotalCostLimit:DISCARTABLE_CACHE_LIMIT];
        [_cache setDelegate:self];
    }
    return self;
}

-(id)getCachedResourceForKey:(id)key
{
    return [_cache objectForKey:key];
}

- (void) setObject:(id)obj forKey:(id)key cost:(NSInteger)cost{
    [_cache setObject:obj forKey:key cost:cost];
}

- (void)emptyCache
{
    [_cache removeAllObjects];
}

-(void)addDiscartableObject:(id)obj key:(id)key cost:(NSInteger)cost{
    MBDiscartableObject *discartableObj = [MBDiscartableObject discartableObject:obj andKey:key andCost:cost];
    [self setObject:discartableObj forKey:key cost:cost];
}

#pragma mark -
#pragma mark NSCacheDelegate

-(void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    DLog(@"will evict object %@ with cost of %i in cache %@", ((MBDiscartableObject *)obj).key,
                                                              ((MBDiscartableObject *)obj).cost,
                                                              cache);
}

@end

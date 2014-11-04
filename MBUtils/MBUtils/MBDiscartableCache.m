//
//  MBDiscartableCache.m
//  MBUtils
//
//  Created by Matteo Battistini on 08/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBDiscartableCache.h"
#import "MBDiscartableObject.h"
#import "MBAssetsFolderUtils.h"

dispatch_queue_t cacheBackGroundQueue () {
    static dispatch_once_t queueCreationGuard;
    static dispatch_queue_t queue;
    dispatch_once(&queueCreationGuard, ^{
        queue = dispatch_queue_create("com.matteoBattistini.cacheBackGroundQueue", 0ul);
        
    });
    return queue;
}

// 10 * 1024 * 1024
#define DISCARTABLE_CACHE_LIMIT 10485760

@interface MBDiscartableCache ()
{
    NSCache *_cache;
}
@end

static NSString *cacheFolderName = @"MBDiscartableCache";

@implementation MBDiscartableCache



+(MBDiscartableCache *)sharedInstance
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
        [MBAssetsFolderUtils createDocumentFolder:cacheFolderName];
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

-(void)addDiscartableObject:(id)obj key:(id)key cost:(NSInteger)cost data:(NSData *)data diskCache:(BOOL) diskCache{
    if (diskCache) {
        dispatch_async(cacheBackGroundQueue(), ^{
            NSString *localCachePath = [[MBAssetsFolderUtils getDocumetFolder:cacheFolderName].path stringByAppendingPathComponent:key];
            NSError *error = nil;
            [data writeToFile:localCachePath options:NSDataWritingAtomic error:&error];
            if (error) {
                DLog(@"ERROR : writing file in MBDiscartableCache error");
            }
        });
    }
    MBDiscartableObject *discartableObj = [MBDiscartableObject discartableObject:obj andKey:key andCost:cost];
    [self setObject:discartableObj forKey:key cost:cost];
}

- (NSString *)getCachePathForFileKey:(id)fileKey
{
    NSString *filePath = [[MBAssetsFolderUtils getDocumetFolder:cacheFolderName].path stringByAppendingPathComponent:fileKey];
    return filePath;
}

-(id) getFileFromDisk:(id)fileKey
{
    if([self isFileSavedOnDisk:fileKey]){
        return [NSData dataWithContentsOfFile:[self getCachePathForFileKey:fileKey]];
    } else {
        return  nil;
    }
}

- (BOOL) isFileSavedOnDisk:(id)fileKey
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return  [fileManager fileExistsAtPath:[self getCachePathForFileKey:fileKey]];

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

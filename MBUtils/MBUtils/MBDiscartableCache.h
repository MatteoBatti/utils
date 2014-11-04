//
//  MBDiscartableCache.h
//  MBUtils
//
//  Created by Matteo Battistini on 08/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDiscartableCache : NSObject <NSCacheDelegate>

+(MBDiscartableCache *)sharedInstance;

- (id)getCachedResourceForKey:(id)key;
- (void) setObject:(id)obj forKey:(id)key cost:(NSInteger)cost;
-(void)addDiscartableObject:(id)obj key:(id)key cost:(NSInteger)cost;
-(void)addDiscartableObject:(id)obj key:(id)key cost:(NSInteger)cost data:(NSData *)data diskCache:(BOOL) diskCache;
- (void) emptyCache;

- (NSString *) getCachePathForFileKey:(id)fileKey;
- (id) getFileFromDisk:(id)fileKey;
- (BOOL) isFileSavedOnDisk:(id)fileKey;
@end

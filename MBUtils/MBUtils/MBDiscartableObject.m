//
//  MBDiscartableObject.m
//  MBUtils
//
//  Created by Matteo Battistini on 09/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBDiscartableObject.h"

@implementation MBDiscartableObject

@synthesize object = _object;
@synthesize accessCount = _accessCount;
@synthesize key = _key;
@synthesize cost = _cost;

+ (MBDiscartableObject *)discartableObject:(id)obj andKey:(NSString *)key andCost:(NSInteger)cost {
    MBDiscartableObject *discartableObj = [[MBDiscartableObject alloc] init];
    discartableObj.object = obj;
    discartableObj.key = key;
    discartableObj.cost = cost;
    discartableObj.accessCount = 0;
    return discartableObj;
}

- (BOOL)beginContentAccess
{
    if (!_object)
        return NO;
    _accessCount +=1;
    return YES;
}

- (void)endContentAccess
{
    _accessCount -=1;
}

- (void)discardContentIfPossible
{
    _object = nil;
}

- (BOOL)isContentDiscarded
{
    return _object == nil;
}

@end

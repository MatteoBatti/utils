//
//  MBDiscartableObject.h
//  MBUtils
//
//  Created by Matteo Battistini on 09/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDiscartableObject : NSObject <NSDiscardableContent>
{
    id _object;
    NSString *_key;
    NSInteger _accessCount;
    NSInteger _cost;
}

@property (nonatomic, retain) id object;
@property (nonatomic, assign) NSInteger accessCount;
@property (nonatomic, assign) NSInteger cost;
@property (nonatomic, retain) NSString *key;

+ (MBDiscartableObject *)discartableObject:(id)obj andKey:(NSString *)key andCost:(NSInteger) cost;

@end

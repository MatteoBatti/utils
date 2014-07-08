//
//  MBStringSubstitution.h
//  MBUtils
//
//  Created by Matteo Battistini on 06/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MBStringSubstitution : NSObject
{
    NSScanner *_scanner;
    NSDictionary *_substitutionDictionary;
    NSString *_startDelimiter;
    NSString *_endDelimiter;
}

-(id)initWithString:(NSString *)string andSubstitutionDictionary:(NSDictionary *)substitutionDictionary;
-(id)initWithString:(NSString *)string startDelimiter:(NSString *)startDelimiter endDelimiter:(NSString *)endDelimiter andSubstitutionDictionary:(NSDictionary *)substitutionDictionary;
-(NSString *)startSubstitution;
//-(NSString *)startSubstitutionOnlyString;

@property (nonatomic, retain) NSDictionary * substitutionDictionary;
@property (nonatomic, retain) NSString * startDelimiter;
@property (nonatomic, retain) NSString * endDelimiter;

@end

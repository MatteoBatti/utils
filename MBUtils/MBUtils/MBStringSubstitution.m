//
//  MBStringSubstitution.m
//  MBUtils
//
//  Created by Matteo Battistini on 06/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBStringSubstitution.h"

@implementation MBStringSubstitution

@synthesize substitutionDictionary = _substitutionDictionary;
@synthesize startDelimiter = _startDelimiter;
@synthesize endDelimiter = _endDelimiter;

-(id)initWithString:(NSString *)string andSubstitutionDictionary:(NSDictionary *)substitutionDictionary
{
    self = [super init];
    if (self) {
        _scanner = [[NSScanner alloc] initWithString:string];
        self.substitutionDictionary = substitutionDictionary;
        self.startDelimiter = @"\"{{";
        self.endDelimiter = @"}}\"";
    }
    return  self;
}



-(id)initWithString:(NSString *)string startDelimiter:(NSString *)startDelimiter endDelimiter:(NSString *)endDelimiter andSubstitutionDictionary:(NSDictionary *)substitutionDictionary
{
    self = [super init];
    if (self) {
        _scanner = [[NSScanner alloc] initWithString:string];
        self.substitutionDictionary = substitutionDictionary;
        self.startDelimiter = startDelimiter;
        self.endDelimiter = endDelimiter;
    }
    return  self;
}


-(NSString *)startSubstitution
{
    NSString *foundString;
    [_scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@""]];
    NSMutableString *formattedResponse = [NSMutableString string];
    
    while(![_scanner isAtEnd]) {
        if([_scanner scanUpToString:_startDelimiter intoString:&foundString]) {
            [formattedResponse appendString:foundString];
        }
        if(![_scanner isAtEnd]) {
            [_scanner scanString:_startDelimiter intoString:nil];
            foundString = @"";
            [_scanner scanUpToString:_endDelimiter intoString:&foundString];
            @try {
                [formattedResponse appendString:[NSString stringWithFormat:@"%@",self.substitutionDictionary[foundString][@"val"]]];
            }
            @catch (NSException *exception) {
                DLog(@"-(NSString *)startSubstitution exception %@", exception.description);
            }
            [_scanner scanString:_endDelimiter intoString:nil];
        }
    }
    return [formattedResponse copy];
}

 
@end

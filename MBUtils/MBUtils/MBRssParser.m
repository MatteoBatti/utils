//
//  MBRssParser.m
//  MBUtils
//
//  Created by Matteo Battistini on 06/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBRssParser.h"
#import "XMLDictionary.h"

@implementation MBRssParser

+(void)parseUrl:(NSURL *)url
{
    NSURLRequest *feedRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:feedRequest returningResponse:&response error:&error];
    
    XMLDictionaryParser *parser = [[XMLDictionaryParser alloc] init];
    NSDictionary * dict =nil;
    @try {
        dict = [parser dictionaryWithData:data];
    }
    @catch (NSException *exception) {
        NSLog(@"eccezione: %@", exception);
        return;
    }
}

@end

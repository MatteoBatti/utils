//
//  UIWebView+MBWebViewYouTubeVideo.m
//  MBUtils
//
//  Created by Matteo Battistini on 06/07/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "UIWebView+MBWebViewYouTubeVideo.h"

@implementation UIWebView (MBWebViewYouTubeVideo)

-(void)LoadYouTubeVideo:(NSString *)videoURL
{
//    NSString *videoURL = @"VCTen3-B8GU";
    [self embedYouTube:videoURL];
}

- (void)embedYouTube:(NSString *)urlString
{
    NSString *embedHTML =[NSString stringWithFormat:@"\
                          <html><head>\
                          <style type=\"text/css\">\
                          body {\
                          background-color: transparent;\
                          color: blue;\
                          }\
                          </style>\
                          </head><body style=\"margin:0\">\
                          <iframe height=\"140\" width=\"325\" src=\"http://www.youtube.com/embed/%@\"></iframe>\
                          </body></html>",urlString];
    [self loadHTMLString:embedHTML baseURL:nil];
}

@end

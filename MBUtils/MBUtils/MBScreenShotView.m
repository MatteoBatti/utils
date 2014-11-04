//
//  MBScreenShotView.m
//  SinatraClub
//
//  Created by Matteo Battistini on 06/09/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBScreenShotView.h"

@implementation MBScreenShotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
}

-(UIImage *)takeScreenShot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

@end

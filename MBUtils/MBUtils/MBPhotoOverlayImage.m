//
//  MBPhotoOverlayImage.m
//  SinatraClub
//
//  Created by Matteo Battistini on 06/09/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBPhotoOverlayImage.h"

@interface MBLazyLoadingImageView ()

@end

@implementation MBPhotoOverlayImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.transform = CGAffineTransformIdentity;
        _xt= 0.0f;
        _yt = 0.0f;
        _zoomScale = 1.0f;
        _thetaRotation = 0.0f;
    }
    return self;
}





@end

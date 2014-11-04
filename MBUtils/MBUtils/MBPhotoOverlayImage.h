//
//  MBPhotoOverlayImage.h
//  SinatraClub
//
//  Created by Matteo Battistini on 06/09/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBLazyLoadingImageView.h"

@interface MBPhotoOverlayImage : MBLazyLoadingImageView <UIGestureRecognizerDelegate>
{
    CGFloat _xt;
    CGFloat _yt;
    CGFloat _zoomScale;
    CGFloat _thetaRotation;
}
@end

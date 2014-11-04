//
//  MBMaskContainerView.h
//  SinatraClub
//
//  Created by Matteo Battistini on 06/09/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBMaskContainerView : UIView
{
    float _zoomScale;
    float _thetaRotation;
    float _xt;
    float _yt;
    float _minImageSizeMultiplier;
    float _maxImageSizeMultiplier;
    BOOL _touchUp;
}

@property (nonatomic, retain) NSMutableArray *images;


@end

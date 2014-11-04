//
//  MBScreenShotView.h
//  SinatraClub
//
//  Created by Matteo Battistini on 06/09/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MBLazyLoadingImageView.h"

@interface MBScreenShotView : UIView

-(UIImage *)takeScreenShot;

@end

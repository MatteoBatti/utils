//
//  MBLazyLoadingImageView.h
//  SinatraClub
//
//  Created by Matteo Battistini on 28/08/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBLazyLoadingImageView : UIImageView
-(void)setImageWithUrl:(NSURL *)url;
-(void)setImageWithUrl:(NSURL *)url animeted:(BOOL) animated;
@end

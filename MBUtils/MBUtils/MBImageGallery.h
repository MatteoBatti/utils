//
//  MBImageGallery.h
//  SinatraClub
//
//  Created by Matteo Battistini on 31/08/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBImageGalleryDelegate <NSObject>
-(void)selectedImagePath:(NSString *)path;
-(void)selectedImageURL:(NSURL *)url;
@end

@interface MBImageGallery : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, retain) NSArray *pathImages;
@property (nonatomic, assign) NSInteger visibleImages;
@property (nonatomic, assign) NSInteger marginImages;

@property (nonatomic, assign) id <MBImageGalleryDelegate> imageGalleryDelegate;

-(id)initWithFrame:(CGRect)frame andPathImages:(NSArray *)pathImages;
-(id)initWithFrame:(CGRect)frame andPathImages:(NSArray *)pathImages visibleImages:(NSInteger)visibleImages;
-(void)setUpGallery;

@end

//
//  MBImageGallery.m
//  SinatraClub
//
//  Created by Matteo Battistini on 31/08/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBImageGallery.h"
#import "MBLazyLoadingImageView.h"

@interface MBImageGallery ()
{
    NSMutableSet *_visibleViews;
    NSMutableSet *_recycledViews;
}

@end


@implementation MBImageGallery
@synthesize  pathImages = _pathImages;
@synthesize visibleImages = _visibleImages;
@synthesize marginImages = _marginImages;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _recycledViews = [[NSMutableSet alloc] init];
        _visibleViews = [[NSMutableSet alloc] init];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andPathImages:(NSArray *)pathImages
{
    self = [self initWithFrame:frame];
    if (self) {
        self.pathImages = pathImages;
    }
    return  self;
}

-(id)initWithFrame:(CGRect)frame andPathImages:(NSArray *)pathImages visibleImages:(NSInteger)visibleImages
{
    self = [self initWithFrame:frame];
    if (self) {
        self.pathImages = pathImages;
        self.visibleImages = visibleImages;
    }
    return  self;
}

-(void)setUpGallery
{
    // set deletage
    self.delegate = self;
    
    // hide scroll Indicator
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    // calculate contentSize
    [self setContentSize:CGSizeMake((self.marginImages * (self.pathImages.count+1)) + (self.pathImages.count * (self.bounds.size.width / self.visibleImages)), 0)];
    
    // initial contentOffset
    [self setContentOffset:CGPointMake(0, 0)];

    //
    [self performSelectorOnMainThread:@selector(updateGallery) withObject:nil waitUntilDone:NO];
}

-(void)dealloc
{
    [_recycledViews release];
    [_visibleViews release];
    [self.pathImages release];
    [super dealloc];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self) {
        [self updateGallery];
    }
}


-(void) updateGallery
{
    CGRect visibleBounds = self.bounds;
    NSInteger firstGalleryIndex = 0;
    NSInteger lastGalleryIndex = 0;
    firstGalleryIndex = floor(CGRectGetMinX(visibleBounds) / ((visibleBounds.size.width/self.visibleImages) + self.marginImages));
    lastGalleryIndex  = floor(CGRectGetMaxX(visibleBounds) / ((visibleBounds.size.width/self.visibleImages) + self.marginImages));
    firstGalleryIndex = MAX(firstGalleryIndex - 1, 0);
    lastGalleryIndex = MIN(lastGalleryIndex + 1, self.pathImages.count - 1);
    
    // Recycle no-longer-visible pages
    NSInteger firstPage = firstGalleryIndex;
    NSInteger lastPage = lastGalleryIndex;
    for(UIView* view in _visibleViews) {
        if(view.tag < firstPage || view.tag > lastPage) {
            [_recycledViews addObject:view];
            [view removeFromSuperview];
        }
        
    }
    [_visibleViews minusSet:_recycledViews];
    
    for(NSInteger currentPage = firstGalleryIndex; currentPage <= lastGalleryIndex; currentPage++) {
        if(![self isDisplayingPageViewForPage:currentPage]) {
            MBLazyLoadingImageView *imageView = [(MBLazyLoadingImageView*)[self dequeueRecycledPage] retain];
            
            if (!imageView) {
                imageView = [[MBLazyLoadingImageView alloc] initWithFrame:CGRectZero];
                [imageView setUserInteractionEnabled:YES];
                imageView.tag = currentPage;
                imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                imageView.autoresizesSubviews = YES;
                
                UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectZero];
                imageButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                imageButton.autoresizesSubviews = YES;
                [imageButton addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:imageButton];
                [imageButton release];
            }
            
            [self configureImageView:imageView forPage:currentPage];
            [self addSubview:imageView];
            [_visibleViews addObject:imageView];
            [imageView release];
        }
    }
}


-(void) configureImageView:(MBLazyLoadingImageView *)view forPage:(NSInteger) page
{
    UIButton *button = nil;
    for (UIView *sv in view.subviews) {
        if ([sv isMemberOfClass:[UIButton class]]) {
            button = (UIButton*)sv;
            break;
        }
    }
    
    
    CGFloat imageWidth = (self.frame.size.width - self.marginImages * self.visibleImages)/self.visibleImages;
    CGFloat imageHeigh = self.frame.size.height - (self.marginImages *2);
    CGFloat originX = (self.marginImages*(page+1)) + page * imageWidth;
    CGFloat originY = self.marginImages;
    
    view.frame = CGRectMake(originX,
                            originY,
                            imageWidth,
                            imageHeigh);
    
    if (button) {
        button.frame = view.bounds;
        button.tag = page;
    }
    
    NSURL *imageUrl = [self.pathImages objectAtIndex:page];
    [view setImageWithUrl:imageUrl animeted:YES];
    view.tag = page;
    [self setNeedsDisplay];
}


-(BOOL)isDisplayingPageViewForPage:(NSInteger)page
{
    for (UIView *imageView in _visibleViews)
    {
        if (imageView.tag == page) {
            return YES;
        }
    }
    return NO;
}

- (UIView *)dequeueRecycledPage {
    UIView *view = [_recycledViews anyObject];
    if(view) {
        [[view retain] autorelease];
        [_recycledViews removeObject:view];
    }
    
    return view;
}

-(void)imageButtonClicked:(UIButton *)button
{
    DLog(@"image %i", button.tag);
}

@end

//
//  MBMaskContainerView.m
//  SinatraClub
//
//  Created by Matteo Battistini on 06/09/14.
//  Copyright (c) 2014 Matteo Battistini. All rights reserved.
//

#import "MBMaskContainerView.h"
#import "MBPhotoOverlayImage.h"

@implementation MBMaskContainerView
@synthesize images = _images;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.images = [[NSMutableArray alloc] init];
        _minImageSizeMultiplier = 100.0;
        _maxImageSizeMultiplier = 600.0;
        self.clipsToBounds = YES;
        self.multipleTouchEnabled = YES;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.images = [[NSMutableArray alloc] init];
        _minImageSizeMultiplier = 100.0;
        _maxImageSizeMultiplier = 600.0;
        self.clipsToBounds = YES;
        self.multipleTouchEnabled = YES;
    }
    return  self;
}

-(void)dealloc
{
    [self.images release];
    [super dealloc];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([touches count]==1){
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:self];
        
        for(UIView *view in self.subviews ){
            if(CGRectContainsPoint(view.frame, location)){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"maskTouchStartInOverlayImage" object:nil];
                [self bringSubviewToFront:view];
                _touchUp = NO;
            }
            
        }
    }
    
    
    if([touches count]==2){
        
        CGPoint touch1 = [[[touches allObjects] objectAtIndex:0]locationInView:self];
        CGPoint touch2 = [[[touches allObjects] objectAtIndex:1] locationInView:self];
        CGPoint middlePoint;
        
        middlePoint = CGPointMake((fabsf(touch2.x-touch1.x)/2)+MIN(touch1.x, touch2.x),(fabsf(touch2.y-touch1.y)/2)+MIN(touch1.y, touch2.y));
        
        for(UIView *view in self.subviews ){
            if(CGRectContainsPoint(view.frame, middlePoint)){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"maskTouchStartInOverlayImage" object:nil];
                [self bringSubviewToFront:view];
            }
            
        }
    }
    
    
    
    DLog(@"touchesBegan %i", [touches count]);
    _xt = ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.tx;
    _yt = ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.ty;
    DLog(@"Matrice : tx: %f, ty : %f, a : %f, b : %f, c : %f, d : %f  ",
         ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.tx,
         ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.ty,
         ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.a,
         ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.b,
         ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.c,
         ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.d);
    
    
    [super touchesBegan:touches withEvent:event];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    DLog(@"%i", [touches count]);
    
    if( [touches count] == 1 ) {
        
        
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:self];
        
        float difx = [[touches anyObject] locationInView: ((MBPhotoOverlayImage *) [self.subviews lastObject])].x - [[touches anyObject] previousLocationInView: ((MBPhotoOverlayImage *) [self.subviews lastObject])].x;
        
        float dify = [[touches anyObject] locationInView: ((MBPhotoOverlayImage *) [self.subviews lastObject])].y - [[touches anyObject] previousLocationInView: ((MBPhotoOverlayImage *) [self.subviews lastObject])].y;
        
        UIView *lastView = [self.subviews lastObject];
        if(CGRectContainsPoint(lastView.frame, location) && !_touchUp){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"maskTouchStartInOverlayImage" object:nil];
            _touchUp = NO;
            DLog(@"%f - %f", [[touches anyObject] locationInView:self].x, [[touches anyObject] locationInView:self].y );
            CGAffineTransform newTransform1 = CGAffineTransformTranslate(((MBPhotoOverlayImage *) [self.subviews lastObject]).transform, difx, dify);
            ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform = newTransform1;
        }
        
    }else if( [touches count] == 2 ) {
        
        CGPoint touch1Before = [[[touches allObjects] objectAtIndex:0] previousLocationInView:(MBPhotoOverlayImage *) [self.subviews lastObject]];
        CGPoint touch2Before = [[[touches allObjects] objectAtIndex:1] previousLocationInView:(MBPhotoOverlayImage *) [self.subviews lastObject]];
        
        CGPoint touch1After=[[[touches allObjects] objectAtIndex:0] locationInView:(MBPhotoOverlayImage *) [self.subviews lastObject]];
        CGPoint touch2After=[[[touches allObjects] objectAtIndex:1] locationInView:(MBPhotoOverlayImage *) [self.subviews lastObject]];
        
        CGPoint middlePointBefore = CGPointMake((fabsf(touch2Before.x-touch1Before.x)/2)+MIN(touch1Before.x, touch2Before.x),(fabsf(touch2Before.y-touch1Before.y)/2)+MIN(touch1Before.y, touch2Before.y));
        CGPoint middlePointAfter = CGPointMake((fabsf(touch2After.x-touch1After.x)/2)+MIN(touch1After.x, touch2After.x),(fabsf(touch2After.y-touch1After.y)/2)+MIN(touch1After.y, touch2After.y));
        
        
        int difx = middlePointAfter.x - middlePointBefore.x;
        int dify =  middlePointAfter.y - middlePointBefore.y;
        
        
        
        CGPoint prevPoint1 = [[[touches allObjects] objectAtIndex:0] previousLocationInView:self];
        CGPoint prevPoint2 = [[[touches allObjects] objectAtIndex:1] previousLocationInView:self];
        CGPoint curPoint1 = [[[touches allObjects] objectAtIndex:0] locationInView:self];
        CGPoint curPoint2 = [[[touches allObjects] objectAtIndex:1] locationInView:self];
        float prevDistance = [self distanceBetweenPoint1:prevPoint1 andPoint2:prevPoint2];
        float newDistance = [self distanceBetweenPoint1:curPoint1 andPoint2:curPoint2];
        float sizeDifference = (newDistance / prevDistance);
        CGAffineTransform newTransform1 = CGAffineTransformTranslate(((MBPhotoOverlayImage *) [self.subviews lastObject]).transform, difx, dify);
        ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform=newTransform1;
        
        
        CGAffineTransform newTransform2 = CGAffineTransformScale(((MBPhotoOverlayImage *) [self.subviews lastObject]).transform, sizeDifference, sizeDifference);
        
        if(((MBPhotoOverlayImage *) [self.subviews lastObject]).frame.size.width*sizeDifference >= _minImageSizeMultiplier && ((MBPhotoOverlayImage *) [self.subviews lastObject]).frame.size.width*sizeDifference <=_maxImageSizeMultiplier){
            ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform=newTransform2;
        }
        
        
        
        
        float prevAngle = [self angleBetweenPoint1:prevPoint1 andPoint2:prevPoint2];
        
        float curAngle = [self angleBetweenPoint1:curPoint1 andPoint2:curPoint2];
        
        float angleDifference = curAngle - prevAngle;
        
        
        
        CGAffineTransform newTransform3 = CGAffineTransformRotate(((MBPhotoOverlayImage *) [self.subviews lastObject]).transform, angleDifference);
        
        ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform = newTransform3;
        
    }
    
    [super touchesMoved:touches withEvent:event];
    
}



- (NSInteger)distanceBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2 {
    
    CGFloat deltaX = fabsf(point1.x - point2.x);
    
    CGFloat deltaY = fabsf(point1.y - point2.y);
    
    CGFloat distance = sqrt((deltaY*deltaY)+(deltaX*deltaX));
    
    return distance;
    
}



- (CGFloat)angleBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2

{
    
    CGFloat deltaY = point1.y - point2.y;
    
    CGFloat deltaX = point1.x - point2.x;
    
    CGFloat angle = atan2(deltaY, deltaX);
    
    return angle;
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{     DLog(@"Matrice dopo : tx: %f, ty : %f, a : %f, b : %f, c : %f, d : %f  ",
           ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.tx,
           ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.ty,
           ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.a,
           ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.b,
           ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.c,
           ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform.d);
    
    _touchUp = YES;
    UITouch *touch = [touches anyObject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"maskTouchEndedInOverlayImage" object:nil];

    
    if (touch.tapCount == 2)
    {
        CGPoint location = [touch locationInView:self];
         MBPhotoOverlayImage *image = (MBPhotoOverlayImage *) [self.subviews lastObject];
        if(CGRectContainsPoint(image.frame, location)){
            [image removeFromSuperview];
        }
    }
    
    if (touch.tapCount == 3)
    {
        ((MBPhotoOverlayImage *) [self.subviews lastObject]).transform = CGAffineTransformIdentity;
        _xt = 0.0f; _yt = 0.0f;
        _zoomScale = 1.0f; _thetaRotation = 0.0f;
    }
    
    [super touchesEnded:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}



@end

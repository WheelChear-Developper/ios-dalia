//
//  MPVideoChannelHeaderView.m
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPVideoChannelHeaderView.h"

@implementation MPVideoChannelHeaderView {
    MPVideoObject *objectRedirect;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // FIX iOS6's Bug
    // For FullSCreen Entry
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youTubeVideofullScreen:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    
    // For FullSCreen Exit
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youTubeVideoExit:) name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youTubeVideoWillExit:) name:@"UIMoviePlayerControllerWillExitFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemEnded) name:@"AVPlayerItemDidPlayToEndTimeNotification" object:nil];
    
    //Disable Scroller
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
}
- (void)playerItemEnded {
    
    [self setData:objectRedirect];
}

- (void)youTubeVideofullScreen:(NSNotification *)notification {
    
    //Set Flag True.
    _isFullscreen = TRUE;
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"6.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 6.0
        
        [MPAppDelegate sharedMPAppDelegate].fullScreenVideoIsPlaying = YES;
    }
    else
    {
        // OS version < 6.0
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        
        //        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        //    UIView *videoView = (UIView*) [notification object];
        [[[[notification object] view] window] setBounds:CGRectMake(0, 0, screenRect.size.height, screenRect.size.width)];
        [[[[notification object] view] window] setCenter:CGPointMake(screenRect.size.width/2, screenRect.size.height/2)];
        
        [[[[notification object] view] window] setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
        
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
}

- (void)youTubeVideoWillExit:(NSNotification *)notification {
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"6.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        //        NSLog(@"youTubeVideoWillExit");
        
        [MPAppDelegate sharedMPAppDelegate].fullScreenVideoIsPlaying = NO;
    }
}

- (void)youTubeVideoExit:(NSNotification *)notification {
    
    //Set Flag False.
    _isFullscreen = FALSE;
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"6.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // Do nothing
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        [[[[notification object] view] window] setBounds:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        [[[[notification object] view] window] setTransform:CGAffineTransformIdentity];
    }
}

- (void)orientationChanged:(NSNotification *)notification {
    
    [self adjustViewsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void)adjustViewsForOrientation:(UIInterfaceOrientation) orientation {
    
    if (orientation == UIInterfaceOrientationPortrait){
        
        if(_isFullscreen)
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        else
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    }
}

-(BOOL)shouldAutorotate {
    
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations {

    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {

    return UIInterfaceOrientationPortrait;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setData:(MPVideoObject *)object {
    
    objectRedirect   = object;
    [Utility embedYouTube:object.url_video webview:webView frame:webView.frame];
    
    detailLabel.text = object.detail;
    
    CGSize detailSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:300 value:object.detail];
    CGRect detailFrame = detailLabel.frame;
    detailFrame.size.height = detailSize.height+5;
    detailLabel.frame = detailFrame;
}

+ (CGFloat)heightForHeader:(MPVideoObject *)object {
    
    CGSize detailSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:300 value:object.detail];
    
    return (detailSize.height + 250);
}

@end

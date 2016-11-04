//
//  MPTopImagesView.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPTopImageObject.h"
#import "ManagerDownload.h"
#import "MPPageControl.h"
#import "LazyInternet.h"
#import "InfinitePagingView.h"

@protocol MPTopImagesViewDelegate<NSObject>
@required
- (void)showWebView:(NSString*)text;
@end

@interface MPTopImagesView : UIView<ManagerDownloadDelegate,LazyInternetDelegate,InfinitePagingViewDelegate>
{
    LazyInternet *lazyImage;
    // REPERTED BY M.ama 2016.10.27 START
    // 名前変更
    IBOutlet InfinitePagingView *scroll_PageView;
    // REPERTED BY M.ama 2016.10.27 END
    IBOutlet UILabel *descriptionLabel;
    NSMutableArray *listObjects;
    IBOutlet MPPageControl *pageControl;
    //list contain actual image
    NSMutableArray *listActualImage;
    NSMutableArray *listDescriptionReceived;
    BOOL _isSquare;
    
    NSMutableArray *listLinkUrl;
    
    NSMutableArray *ary_list;
    long lng_imageDownloadCount;
}

@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic) BOOL isSquare;
@property (nonatomic,assign) id<MPTopImagesViewDelegate> delegate;

- (void)setUpView:(NSArray*)listImage;

@end

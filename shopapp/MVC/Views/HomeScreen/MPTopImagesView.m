//
//  MPTopImagesView.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPTopImagesView.h"
#import "ManagerDownload.h"
#import "MPConfigObject.h"
#import "MPTopImageObject.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@implementation MPTopImagesView

@synthesize isSquare = _isSquare;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [[ManagerDownload sharedInstance] getListImage:[Utility getAppID] delegate:self];
    listActualImage = [[NSMutableArray alloc] init];
    //TODO:show detail top image
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    //Default value for cancelsTouchesInView is YES, which will prevent buttons to be clicked
    singleTap.cancelsTouchesInView = NO;
    [scroll_PageView addGestureRecognizer:singleTap];
}

#pragma mark - Show detail top image
- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture {
    
    if([self.delegate respondsToSelector:@selector(showWebView:)]){
        
        NSString* str_url = [listLinkUrl objectAtIndex:pageControl.currentPage];
        NSLog(@"PageNo:%d linkurl: %@", pageControl.currentPage, str_url);
        if(![str_url isEqualToString:@""]){
            
            [self.delegate showWebView:[listLinkUrl objectAtIndex:pageControl.currentPage]];
        }
    }
    
    NSLog(@"image %ld",(long)pageControl.currentPage);
}

#pragma mark -  ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    listObjects = param.listData;
    NSMutableArray *listTemp = listObjects;

    for(id obj in listTemp) {
         NSLog(@"image url: %@",[(MPTopImageObject*)obj topUrl]);
    }
    listObjects = listTemp;
    
    [self setUpView:listTemp];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)setUpView:(NSArray*)listImage {

    if(listImage.count > 0) {
        [pageControl setHidden:NO];
        // Set up the array to hold the views for each page
        self.pageViews = [[NSMutableArray alloc] init];
        listDescriptionReceived = [[NSMutableArray alloc] init];
        listLinkUrl = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < listImage.count; ++i) {
            [self.pageViews addObject:[NSNull null]];
        }
        //set pagecontrol
        scroll_PageView.delegate = self;
        
        if(_isSquare)
            scroll_PageView.pageSize = CGSizeMake(scroll_PageView.frame.size.height, scroll_PageView.frame.size.height);

        pageControl.numberOfPages = listImage.count;
        pageControl.currentPage = 0;
        int i = 0;

        // REPERTED BY M.ama 2016.10.27 START
        // 画像順番設定
        lng_imageDownloadCount = 0;
        ary_list = [NSMutableArray array];
        for (id obj in listImage) {
            if ([obj isKindOfClass:[MPTopImageObject class]]) {

                [ary_list insertObject:obj atIndex:i];
                i ++;
            }
        }
        // REPERTED BY M.ama 2016.10.27 END

        [self setImageCount];
        
    }else{
        [pageControl setHidden:YES];
        UIImageView *blankImage = [[UIImageView alloc] initWithFrame:scroll_PageView.bounds];
        [blankImage setImage:[UIImage imageNamed:@"blackImage.png"]];
        [scroll_PageView addPageView:blankImage index:0];
    }
}

// INSERTED BY M.ama 2016.10.27 START
// 画像順番設定
-(void)setImageCount {

    if(lng_imageDownloadCount < ary_list.count){

        UIImage *image = nil;

        NSLog(@"SetImageNo _ %ld", lng_imageDownloadCount);

        //lazy loading images
        lazyImage = [[LazyInternet alloc] init];
        [lazyImage startDownload:[NSString stringWithFormat:BASE_PREFIX_URL,[(MPTopImageObject*)ary_list[lng_imageDownloadCount] topUrl]] withDelegate:self withUnique:image];
    }else{

        // INSERTED BY M.ama 2016.10.08 START
        //４秒ごとのスライド
        [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(timerScroll:) userInfo:nil repeats:YES];
        // INSERTED BY M.ama 2016.10.08 END
    }
}

-(void)timerScroll:(NSTimer*)timer {

    [scroll_PageView scrollToNextPage:YES];
}
// INSERTED BY M.ama 2016.10.27 END

// REPERTED BY M.ama 2016.10.27 START
// 画像順番設定
- (void)lazyInternetDidLoad:(NSData *)data
                 withUnique:(id)unique {

    NSLog(@"LoadImageNo _ %ld", lng_imageDownloadCount);
    
    if(data) {
        unique = [UIImage imageWithData:data];

        if (!unique) {
            unique = [UIImage imageNamed:UNAVAILABLE_IMAGE];
        }
    }else{
        unique = [UIImage imageNamed:UNAVAILABLE_IMAGE];
    }

    // Load an individual page, first seeing if we've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:lng_imageDownloadCount];
    if((NSNull*)pageView == [NSNull null]) {

        CGRect frame;
        UIView *titleView;
        UILabel *imageTitleLabel;

        if(!self.isSquare){
            frame = CGRectMake(0.f, 0.f, scroll_PageView.frame.size.width, scroll_PageView.frame.size.height);
            frame = CGRectInset(frame, 0.0f, 0.0f);
        }else{
            frame = CGRectMake(0.f, 0.f, scroll_PageView.frame.size.height, scroll_PageView.frame.size.height);
        }
        //add actual image to list
        [listActualImage addObject:unique];

        UIImageView *newPageView = [[UIImageView alloc] initWithImage:unique];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        newPageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);

        UIView *myView = [[UIView alloc] initWithFrame:frame];
        // REPLACED BY ama 2016.10.29 START
        // 背景色変更
        [newPageView setBackgroundColor:[UIColor clearColor]];
        // REPLACED BY ama 2016.10.29 END

        [myView addSubview:newPageView];
        // REPLACED BY ama 2016.09.30 START
        // トップ画像のサイズ変更
        if(!self.isSquare){
            // REPLACED BY M.ama 2016.10.08 START
            // スライドエリアの文字位置修正
            titleView = [[UIView alloc] initWithFrame:CGRectMake(0, myView.frame.size.height - 30, frame.size.width, 30)];
            imageTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, myView.frame.size.height - 30, frame.size.width - 20, 30)];
            // REPLACED BY M.ama 2016.10.08 END
        }else{
            titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 141, scroll_PageView.frame.size.height - 4, 60)];
            imageTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 141, scroll_PageView.frame.size.height - 20, 60)];
        }
        titleView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        // REPLACED BY ama 2016.09.30 END
        
        imageTitleLabel.backgroundColor = [UIColor clearColor];
        imageTitleLabel.numberOfLines = 2;
        imageTitleLabel.text = [(MPTopImageObject*)[listObjects objectAtIndex:lng_imageDownloadCount] topDesc];
        [listDescriptionReceived addObject:[Utility checkNIL:imageTitleLabel.text]];
        
        NSString* url = [(MPTopImageObject*)[listObjects objectAtIndex:lng_imageDownloadCount] linkUrl];
        [listLinkUrl addObject:[Utility checkNIL:url]];
        
        imageTitleLabel.textColor = [UIColor whiteColor];
        [imageTitleLabel setFont:[UIFont systemFontOfSize:11]];
        
        [myView addSubview:titleView];
        [myView addSubview:imageTitleLabel];

        
        if(![(MPTopImageObject*)[listObjects objectAtIndex:lng_imageDownloadCount] topDesc] ) {
            [titleView setHidden:YES];
        }
        
        if([(MPTopImageObject*)[listObjects objectAtIndex:lng_imageDownloadCount] is_News] == 1) {
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            [view setBackgroundColor:[UIColor clearColor]];
            [view setImage:[UIImage imageNamed:@"top_image_new.png"]];
            [view setTag:1000];
            [myView addSubview:view];
        }

        [self.pageViews replaceObjectAtIndex:lng_imageDownloadCount withObject:myView];
        [scroll_PageView addPageView:[self.pageViews objectAtIndex:lng_imageDownloadCount] index:lng_imageDownloadCount];
        [scroll_PageView setClipsToBounds:YES];

        lng_imageDownloadCount +=1;
        [self setImageCount];
    }
}
// REPERTED BY M.ama 2016.10.27 END

#pragma mark - InfinitePagingViewDelegate
- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex {
    
    pageControl.currentPage = pageIndex;
}

- (void)pagingView:(InfinitePagingView *)pagingView didScroll:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex {

    pageControl.currentPage = pageIndex;
}

- (void)pagingView:(InfinitePagingView *)pagingView didEndDragging:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex {

    pageControl.currentPage = pageIndex;
}

@end

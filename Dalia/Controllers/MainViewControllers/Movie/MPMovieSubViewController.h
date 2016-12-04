//
//  MPMovieSubViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/03.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"

@protocol MPMovieSubViewControllerDelegate<NSObject>
@end

@interface MPMovieSubViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UILabel *lbl_title;
    __weak IBOutlet UIWebView *web_view;
    __weak IBOutlet UILabel *lbl_comment;

}
@property (nonatomic, assign) id<MPMovieSubViewControllerDelegate> delegate;
@property (nonatomic, assign) MPVideolistObject* obj_video;
@property (nonatomic, assign) NSString* str_videoUrl;

- (IBAction)btn_back:(id)sender;
- (IBAction)btn_heart:(id)sender;
- (IBAction)btn_line:(id)sender;
- (IBAction)btn_facebook:(id)sender;
- (IBAction)btn_blog:(id)sender;

@end

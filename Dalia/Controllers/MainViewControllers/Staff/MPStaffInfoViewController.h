//
//  MPStaffInfoViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPStaffCollectionCell.h"
#import "MPStafflistObject.h"
#import "MPWebViewController.h"

@protocol MPStaffInfoViewControllerDelegate<NSObject>
@end

@interface MPStaffInfoViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UICollectionView *_col_photolist;

    __weak IBOutlet UIImageView *img_photo;
    __weak IBOutlet UILabel *lbl_name1;
    __weak IBOutlet UILabel *lbl_name2;
    __weak IBOutlet UILabel *lbl_comment;

    NSString* _str_reserve_url;
    NSString* _str_instagram_url;
    NSString* _str_facebook_url;
    NSString* _str_twitter_url;
    NSString* _str_blog_url;

}
@property (nonatomic, assign) id<MPStaffInfoViewControllerDelegate> delegate;
@property (nonatomic, assign) MPStafflistObject* obj_staff;
@property (nonatomic, assign) NSMutableArray *ary_photoImage;

- (IBAction)btn_yoyaku:(id)sender;
- (IBAction)btn_insta:(id)sender;
- (IBAction)btn_facebook:(id)sender;
- (IBAction)btn_twitter:(id)sender;
- (IBAction)btn_blog:(id)sender;

@end

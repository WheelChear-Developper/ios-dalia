//
//  HearCatalogCategoryListInfo_SlideView.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol HearCatalogCategoryListInfo_SlideViewDelegate<NSObject>

@end

@interface HearCatalogCategoryListInfo_SlideView : UIView
{
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    long _lng_category;
    __weak IBOutlet UIImageView *_img_ladies;
    __weak IBOutlet UIImageView *_img_mens;
    __weak IBOutlet UIImageView *_img_favorite;
}
+ (instancetype)myView;
@property (nonatomic, assign) id<HearCatalogCategoryListInfo_SlideViewDelegate> delegate;

@property (nonatomic) UIScrollView* scr_rootview;

@property (weak, nonatomic) IBOutlet UIImageView *img_photo;
@property (weak, nonatomic) IBOutlet UIPageControl *pgc_page;

@property (nonatomic, assign) long lng_categolyType;
@property (nonatomic, assign) long lng_categolyNo;

- (void)setCategolyType:(long)type;

- (IBAction)btn_ladies:(id)sender;
- (IBAction)btn_mens:(id)sender;
- (IBAction)btn_favorite:(id)sender;

@end

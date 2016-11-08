//
//  MPHomeMenuDetailViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "MPItemObject.h"

typedef NS_ENUM(NSInteger, DETAIL_LIST_TYPE) {
    DETAIL_LIST_TYPE_MENU,
    DETAIL_LIST_TYPE_COLLECTION,
    DETAIL_LIST_TYPE_FAVORITE,
    DETAIL_LIST_TYPE_MIXED
};

@interface MPHomeMenuDetailViewController : MPBaseViewController<UIScrollViewDelegate ,ManagerDownloadDelegate>
{
    MPItemObject *itemObject;
    DETAIL_LIST_TYPE detailType;
    BOOL _isRecommend;
    NSString *alertMessage;
    
    UIScrollView* _scr_rootview;
    UIView *scr_inView;
    UIView *cornerView;
    UILabel *title;
    UIImageView *imageMenu;
    UILabel *titleMenu;
    UILabel *priceMenu;
    UILabel *lbl_contentMenu;
}
@property (nonatomic, strong) NSString* recommennd;
- (void)setData:(id) object withType:(DETAIL_LIST_TYPE)type withRecommendType:(BOOL)isRecommend;

@end

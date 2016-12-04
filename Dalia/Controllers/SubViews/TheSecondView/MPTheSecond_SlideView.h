//
//  MPTheSecond_SlideView.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol MPTheSecond_SlideViewDelegate<NSObject>
- (void)btn_favebook;
- (void)btn_twitter;
- (void)btn_line;
@end

@interface MPTheSecond_SlideView : UIView
{
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    __weak IBOutlet UIPageControl *_pgc_page;
}
+ (instancetype)myView;
@property (nonatomic, assign) id<MPTheSecond_SlideViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scr_rootview;

@property (weak, nonatomic) IBOutlet UIView *view_specialMark;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UIImageView *img_photo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Info1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Info2;
@property (weak, nonatomic) IBOutlet UILabel *lbl_turn;
@property (weak, nonatomic) IBOutlet UIImageView *img_stamp;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UIView *view_message;
@property (weak, nonatomic) IBOutlet UILabel *lbl_message;
@property (nonatomic) long lng_messageHeight;
@property (weak, nonatomic) IBOutlet UIView *view_left;
@property (weak, nonatomic) IBOutlet UIView *view_right;

- (IBAction)btn_detail:(id)sender;

-(void)setNumberOfPages:(long)count;
-(void)setCurrentCount:(long)count;
-(long)getCurrentCount;

- (IBAction)btn_favebook:(id)sender;
- (IBAction)btn_twitter:(id)sender;
- (IBAction)btn_line:(id)sender;

@end

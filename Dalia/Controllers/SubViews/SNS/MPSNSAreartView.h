//
//  MPSNSAreartView.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/04.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol MPSNSAreartViewDelegate<NSObject>
-(void)postFacebook:(NSString*)comment;
-(void)postTwitter:(NSString*)comment;
-(void)postLine:(NSString*)comment;
@end

@interface MPSNSAreartView : UIView
{
    IBOutlet UILabel *lbl_title;
    IBOutlet UILabel *lbl_comment;
}
@property (nonatomic, assign) id<MPSNSAreartViewDelegate> delegate;

@property (nonatomic, assign) long lng_snsType;

- (void)setData:(NSString*)title comment:(NSString*)comment;

- (IBAction)btn_cansel:(id)sender;
- (IBAction)btn_shar:(id)sender;

@end

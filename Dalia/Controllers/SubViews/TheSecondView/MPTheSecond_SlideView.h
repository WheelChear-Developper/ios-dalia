//
//  MPTheSecond_SlideView.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol MPTheSecond_SlideViewDelegate<NSObject>

@end

@interface MPTheSecond_SlideView : UIView
{

}
@property (nonatomic, assign) id<MPTheSecond_SlideViewDelegate> delegate;

@end

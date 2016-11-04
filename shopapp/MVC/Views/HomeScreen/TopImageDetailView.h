//
//  TopImageDetailView.h
//  Misepuri
//
//  Created by TUYENBQ on 3/4/14.
//  Copyright (c) 2014 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopImageDetailView : UIView
{
    
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *contentView;
    IBOutlet UIView *wrapView;
    IBOutlet UIView *wrapViewParent;
    IBOutlet UIView *imageViewWrap;
}
- (void) setData: (UIImage*) imageData withContent: (NSString*) content;

@end

//
//  MPMenuListCollectionCell.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPMenuListCollectionCell : UICollectionViewCell
{
    IBOutlet UIImageView *imageView;
}
- (void)setImage:(UIImage *)image;
@end

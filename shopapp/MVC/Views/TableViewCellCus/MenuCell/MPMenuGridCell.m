//
//  MPMenuGridCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPMenuGridCell.h"

#define SIZE_IMAGE 88
#define PADDING_IMAGE 10
@implementation MPMenuGridCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setData:(NSArray *)listItem {
    
    _listItem = listItem;
    NSLog(@"%@",_listItem);
    long row = 0;
    long column = 0;
    for (int i = 0; i < _listItem.count; i ++) {
        
        MPItemObject *itemObj = [_listItem objectAtIndex:i];
        //====bonus
        
        //メニュー単位のVIEW
        UIView *view = [[UIView alloc] init];
        [view setFrame:CGRectMake(column*(SIZE_IMAGE+PADDING_IMAGE)+PADDING_IMAGE, row*(SIZE_IMAGE+40+PADDING_IMAGE)+PADDING_IMAGE, SIZE_IMAGE, SIZE_IMAGE+40)];
        [view setBackgroundColor:[UIColor clearColor]];
        
        //メニュー画像
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE_IMAGE, SIZE_IMAGE)];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;
        [view addSubview:imageView];
        
        //メニューボタン
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button.imageView setContentMode:UIViewContentModeCenter];
        [button setFrame:CGRectMake(0, 0, SIZE_IMAGE, SIZE_IMAGE)];
        
        //非同期画像セット
        if (itemObj.thumbnail) {
            NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,itemObj.thumbnail]];
            NSURLRequest* request = [NSURLRequest requestWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response,
                                                       NSData * data,
                                                       NSError * error) {
                                       UIImage *image = nil;
                                       if (!error){
                                           image = [[UIImage alloc] initWithData:data];
                                           // do whatever you want with image
                                       }else{
                                           image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
                                       }
                                       // REPRASED BY ama 2016.10.30 START
                                       //クーポンイメージダウンロード
                                       [button setImage:image forState:UIControlStateNormal];
                                       button.imageView.contentMode = UIViewContentModeScaleAspectFit;
                                       // REPRASED BY ama 2016.10.30 END
                                   }];
        }else{
            [imageView setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
        }
        [button addTarget:self action:@selector(getDetailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTag:i];
        [view addSubview:button];
        
        
        UILabel *title = [[UILabel alloc] init];
        [title setFrame:CGRectMake(0, button.frame.size.height, SIZE_IMAGE, 28)];
        title.numberOfLines = 2;
        [title setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:9]];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setText:itemObj.title];
        [view addSubview:title];
        
        UILabel *price = [[UILabel alloc] init];
        [price setFrame:CGRectMake(0, title.frame.size.height + title.frame.origin.y, SIZE_IMAGE, 14)];
        [price setFont:[UIFont fontWithName:@"HelveticaNeue" size:9]];
        [price setBackgroundColor:[UIColor clearColor]];
        if ([[Utility checkNIL:itemObj.price] isEqualToString:@""]) {
            [price setText:@""];
            
        }else{
            [price setText:[NSString stringWithFormat:@"¥%@ (＋税)",itemObj.price]];
        }
        //[price setText:[NSString stringWithFormat:@"¥%@",itemObj.price]];
        [view addSubview:price];
        
        [self addSubview:view];
        
        if (column == 2) {
            column = 0;
            row ++;
        }else{
            column ++;
        }
    }
}

+ (CGFloat)heightForRow:(NSArray *)listItem {
    
    int row = 0;
    int column = 0;
    for (int i = 0; i < listItem.count; i ++) {
        if (column == 2) {
            column = 0;
            row ++;
        }else{
            column ++;
        }
    }
    
    if (listItem.count % 3 != 0) {
        row += 1;
    }
    
    return (row)*(SIZE_IMAGE+PADDING_IMAGE+42);
}

- (void)getDetailButtonClicked:(UIButton*)sender {
    
    MPItemObject *itemObj = [_listItem objectAtIndex:sender.tag];
    if ([self.delegate respondsToSelector:@selector(selectProduct:)]) {
        [self.delegate selectProduct:itemObj];
    }
}

@end

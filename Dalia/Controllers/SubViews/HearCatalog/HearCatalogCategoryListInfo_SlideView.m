//
//  HearCatalogCategoryListInfo_SlideView.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "HearCatalogCategoryListInfo_SlideView.h"

@implementation HearCatalogCategoryListInfo_SlideView

+ (instancetype)myView
{
    // xib ファイルから MyView のインスタンスを得る
    UINib *nib = [UINib nibWithNibName:@"HearCatalogCategoryListInfo_SlideView" bundle:nil];
    HearCatalogCategoryListInfo_SlideView *view = [nib instantiateWithOwner:self options:nil][0];

    return view;
}

-(void)setNumberOfPages:(long)count {

    _pgc_page.numberOfPages = count;
}

-(void)setCurrentCount:(long)count {

    _pgc_page.currentPage = count;
}

-(long)getCurrentCount {

    return _pgc_page.currentPage;
}

- (IBAction)btn_ladies:(id)sender {

    [self setCategolyType:0];
}

- (IBAction)btn_mens:(id)sender {


    [self setCategolyType:1];
}

- (IBAction)btn_favorite:(id)sender {

    [self setCategolyType:2];
}

- (void)setCategolyType:(long)type {

    _lng_category = type;

    switch (type) {
        case 0:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_dark.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_light.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_light.png"];
        }
            break;
        case 1:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_dark.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_light.png"];
        }
            break;
        case 2:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_light.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_dark.png"];
        }
    }
}

@end

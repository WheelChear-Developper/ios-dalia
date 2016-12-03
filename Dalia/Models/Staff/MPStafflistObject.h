//
//  MPStafflistObject.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPStafflistObject : NSObject

@property (nonatomic,strong) NSString  *id;
@property (nonatomic, strong) NSString *name1;
@property (nonatomic, strong) NSString *name2;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *post;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *reserve_url;
@property (nonatomic, strong) NSString *instagram_url;
@property (nonatomic, strong) NSString *facebook_url;
@property (nonatomic, strong) NSString *twitter_url;
@property (nonatomic, strong) NSString *blog_url;
@property (nonatomic, strong) NSString *updated_at;
@property (nonatomic, strong) NSString *styles;

@end

//
//  MPVideolistObject.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPVideolistObject : NSObject

@property (nonatomic,strong) NSString  *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSMutableArray *url_video;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *time;
@property (nonatomic) long isLike;
@property (nonatomic) long isSns;
@property (nonatomic) long like;

@end

//
//  MPTopImageObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPTopImageObject : NSObject
@property (nonatomic,strong) NSString *topID;
@property (nonatomic, strong) NSString *topUrl;
@property (nonatomic, strong) NSString *topDesc;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic) long is_url_open;
@property (nonatomic) long is_News;
@end

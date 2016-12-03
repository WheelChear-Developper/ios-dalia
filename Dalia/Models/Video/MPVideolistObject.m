//
//  MPVideolistObject.m
//  Dalia
//
//  Created by M.Amatani on 2016/12/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPVideolistObject.h"

@implementation MPVideolistObject

- (id)init{

    if (self = [super init]) {
        self.url_video = [[NSMutableArray alloc] init];
    }

    return  self;
}

@end

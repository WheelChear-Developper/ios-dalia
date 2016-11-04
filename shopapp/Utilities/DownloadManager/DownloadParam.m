//
//  DownloadParam.m
//  Oromo
//
//  Created by TUYENBQ on 10/16/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//

#import "DownloadParam.h"

@implementation DownloadParam
- (id)init
{
    self = [super init];
    if (self) {
        _listData = [[NSMutableArray alloc] init];
    }
    return self;
}
- (id)initWithType:(RequestType)type{
    self = [self init];
    if(self){
        self.request_type = type;
        self.result_code = -1;
    }
    return self;
}
- (BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[DownloadParam class]]) {
        DownloadParam *param = (DownloadParam *)object;
        if (param.request_type == self.request_type) {
            return YES;
        }
    }
    return NO;
}
@end

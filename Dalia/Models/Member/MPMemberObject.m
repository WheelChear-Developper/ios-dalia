//
//  MPMemberObject.m
//  Misepuri
//
//  Created by AMA on 2016/09/04.
//

#import "MPMemberObject.h"

@implementation MPMemberObject

- (id)init{

    if (self = [super init]) {
        self.fld_name = [[NSMutableArray alloc] init];
    }

    if (self = [super init]) {
        self.fld_colom = [[NSMutableArray alloc] init];
    }

    if (self = [super init]) {
        self.fld_essential = [[NSMutableArray alloc] init];
    }

    if (self = [super init]) {
        self.fld_value = [[NSMutableArray alloc] init];
    }

    if (self = [super init]) {
        self.fld_shoplist = [[NSMutableArray alloc] init];
    }

    return  self;
}
@end

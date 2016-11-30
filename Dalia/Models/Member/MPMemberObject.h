//
//  MPMemberObject.h
//  Misepuri
//
//  Created by AMA on 2016/09/04.
//

#import <Foundation/Foundation.h>

@interface MPMemberObject : NSObject

@property (nonatomic, strong) NSMutableArray *fld_name;
@property (nonatomic, strong) NSMutableArray *fld_colom;
@property (nonatomic, strong) NSMutableArray *fld_essential;

@property (nonatomic, strong) NSMutableArray *fld_value;
@property (nonatomic) BOOL flg_details;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSMutableArray *fld_shoplist;

@end

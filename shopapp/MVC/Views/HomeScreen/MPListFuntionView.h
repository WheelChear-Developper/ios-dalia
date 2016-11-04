//
//  MPListFuntionView.h
//  Misepuri
//
//  Created by TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FunctionType) {
    FunctionType_1,
    FunctionType_2,
    FunctionType_3,
    FunctionType_4
};

@protocol ListFunctionDelegate<NSObject>
@optional
- (void) choiceFunction: (FunctionType) type;
@end

@interface MPListFuntionView : UIView
{
    NSArray *listFunction;
    NSMutableArray *listButton;
}
@property (nonatomic, assign) id<ListFunctionDelegate> delegate;

@end
